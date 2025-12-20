import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/features/advanced_pagination/api_services_news.dart';
import 'package:posts_app/features/advanced_pagination/news.dart';
import 'package:posts_app/features/advanced_pagination/news_cache.dart';
import 'package:rxdart/rxdart.dart';

part 'adv_pagination_event.dart';
part 'adv_pagination_state.dart';

class AdvPaginationBloc extends Bloc<AdvPaginationEvent, AdvPaginationState> {
  final ApiServicesNews api;
  final NewsCache cache;

  int page = 1;
  final int limit = 10;
  bool isFetching = false;
  String currentQuery = '';

  AdvPaginationBloc({required this.api, required this.cache})
    : super(AdvPaginationInitial()) {
    on<FetchNewsEvent>(_onFetchNews);
    on<RetryFetchNewsEvent>((e, emit) => add(FetchNewsEvent()));
    on<SearchNewsChanged>(
      _onSearchChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration d) {
    return (events, mapper) => events.debounceTime(d).switchMap(mapper);
  }

  Future<void> _onFetchNews(FetchNewsEvent event, Emitter emit) async {
    if (isFetching) return;
    isFetching = true;

    try {
      if (state is AdvPaginationInitial) {
        emit(AdvPaginationLoading());
      }

      final news = await api.fetchNews(
        page: page,
        limit: limit,
        query: currentQuery,
      );

      if (state is AdvPaginationLoaded) {
        final current = state as AdvPaginationLoaded;
        emit(
          news.isEmpty
              ? current.copyWith(hasReachedMax: true)
              : current.copyWith(
                  news: List.of(current.news)..addAll(news),
                  hasReachedMax: news.length < limit,
                ),
        );
      } else {
        emit(
          AdvPaginationLoaded(news: news, hasReachedMax: news.length < limit),
        );
      }

      await cache.save((state as AdvPaginationLoaded).news);

      page++;
    } catch (e) {
      final cached = await cache.load();
      if (cached.isNotEmpty) {
        emit(AdvPaginationCached(cached));
      } else {
        emit(AdvPaginationError(errorMessage: e.toString()));
      }
    } finally {
      isFetching = false;
    }
  }

  Future<void> _onSearchChanged(SearchNewsChanged event, Emitter emit) async {
    currentQuery = event.query;
    page = 1;

    if (event.query.isEmpty) {
      emit(AdvPaginationInitial());
      add(FetchNewsEvent());
      return;
    }

    emit(AdvPaginationLoading());
    try {
      final data = await api.fetchNews(
        page: page,
        limit: limit,
        query: currentQuery,
      );

      emit(AdvPaginationLoaded(news: data, hasReachedMax: data.length < limit));
      await cache.save(data);
      page++;
    } catch (e) {
      emit(AdvPaginationError(errorMessage: e.toString()));
    }
  }
}
