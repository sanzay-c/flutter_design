import 'package:counter_animation/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is CounterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CounterUpdate) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Counter: ${state.count}',
                    style: const TextStyle(
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => counterBloc.add(CounterIncrement()),
                        child: const Text('+', style: TextStyle(fontSize: 30),),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => counterBloc.add(CounterDecrement()),
                        child: const Text('-', style: TextStyle(fontSize: 30),),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else if (state is CounterInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Counter: 0',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => counterBloc.add(CounterIncrement()),
                        child: const Text('+', style: TextStyle(fontSize: 30),),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => counterBloc.add(CounterDecrement()),
                        child: const Text('-', style: TextStyle(fontSize: 30),),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
