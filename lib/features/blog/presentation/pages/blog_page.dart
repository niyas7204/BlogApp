import 'dart:developer';

import 'package:cleanarchitecture/core/theme/app_pallet.dart';
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (context, index1) => Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppPallete.blogListColors[index1 % 3],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppPallete.borderColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.blog[index1].topics.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 20,
                                ),
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppPallete.borderColor)),
                                  child: Center(
                                      child: Text(
                                          state.blog[index1].topics[index])),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(state.blog[index1].tittle),
                            Text(state.blog[index1].content),
                          ],
                        ),
                      )),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                  itemCount: state.blog.length),
            );
          } else if (state is BlogFailure) {
            log("get all blog error");
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
