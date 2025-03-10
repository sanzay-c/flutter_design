// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_app/data/datasources/blog_remote_data_sources.dart';
// import 'package:new_app/data/repositories/blog_repository_impl.dart';
// import 'package:new_app/domian/usecases/get_blog.dart';
// import 'package:new_app/domian/usecases/get_comment.dart';
// import 'package:new_app/presentation/bloc/blog_bloc.dart';
// import 'package:new_app/presentation/widgets/blog_list.dart';

// class BlogScreen extends StatelessWidget {
//   const BlogScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Blogs"),
//         centerTitle: true,
//       ),
//       body: BlocProvider(
//         create: (context) => BlogBloc(
//           blogs: GetBlog(
//             repository: BlogRepositoryImpl(
//               dataSources: BlogRemoteDataSources(),
//             ),
//           ),
//           blogComment: GetComment(
//             commentrepository: BlogRepositoryImpl(
//               dataSources: BlogRemoteDataSources(),
//             ),
//           ),
//         ),
//         child: BlogList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/data/datasources/blog_remote_data_sources.dart';
import 'package:new_app/data/repositories/blog_repository_impl.dart';
import 'package:new_app/domian/usecases/delete_blog.dart';
import 'package:new_app/domian/usecases/get_blog.dart';
import 'package:new_app/domian/usecases/update_blog.dart';
import 'package:new_app/presentation/blocs/blog/blog_bloc.dart';
import 'package:new_app/presentation/widgets/blog_list.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BlogBloc(
              blogs: GetBlog(
                repository: BlogRepositoryImpl(
                  dataSources: BlogRemoteDataSources(),
                ),
              ),
              deleteBlog: DeleteBlog(
                blogRepositoryDelete: BlogRepositoryImpl(
                  dataSources: BlogRemoteDataSources(),
                ),
              ),
              updateBlog: UpdateBlog(
                updateblogRepository: BlogRepositoryImpl(
                  dataSources: BlogRemoteDataSources(),
                ),
              ),
            ),
          ),
          // BlocProvider(
          //   create: (context) => BlogCommentBloc(
          //     blogComment: GetComment(
          //       commentrepository: BlogRepositoryImpl(
          //         dataSources: BlogRemoteDataSources(),
          //       ),
          //     ),
          //     deleteBlogComment: DeleteBlogComment(
          //       blogRepositoryDeleteComment: BlogRepositoryImpl(
          //         dataSources: BlogRemoteDataSources(),
          //       ),
          //     ),
          //   ),
          // ),
        ],
        child: BlogList(),
      ),
    );
  }
}
