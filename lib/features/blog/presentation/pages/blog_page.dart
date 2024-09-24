import 'package:cleanarchitecture/features/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:cleanarchitecture/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(FetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("blog app"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddNewBlogPage(),
                ));
              },
              icon: const Icon(Icons.add_circle_outline))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, blogstate) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const CircularProgressIndicator();
          } else if (state is BlogSuccess) {
            return ListView.separated(
                itemBuilder: (context, index) => const Text("--------"),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: state.blog.length);
          } else if (state is BlogFailure) {
            return SizedBox(
              child: Text(state.errorMessage),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
