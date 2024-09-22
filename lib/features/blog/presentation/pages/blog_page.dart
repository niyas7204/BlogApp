import 'package:cleanarchitecture/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

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
    );
  }
}
