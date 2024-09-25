import 'dart:developer';
import 'dart:io';

import 'package:cleanarchitecture/core/cubit/cubit/app_user_cubit.dart';
import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:cleanarchitecture/core/utils/pick_image.dart';
import 'package:cleanarchitecture/core/utils/show_snackbar.dart';
import 'package:cleanarchitecture/features/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:cleanarchitecture/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final tittleController = TextEditingController();
  final bodycontroller = TextEditingController();
  List<String> selectedTopics = [];
  final formKey = GlobalKey<FormState>();
  File? image;
  void selectImage() async {
    final selectedImage = await pickImage();
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context: context, message: state.errorMessage);
          } else if (state is BloguploadSuccess) {
            context.read<BlogBloc>().add(FetchAllBlogs());
            log("blog update success");
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: selectImage,
                        child: image == null
                            ? DottedBorder(
                                color: AppPallete.borderColor,
                                dashPattern: const [10, 4],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                strokeCap: StrokeCap.round,
                                child: const SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder,
                                        size: 50,
                                      ),
                                      Text(
                                        "Select your image",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            "Business",
                            "Technology",
                            "Programming",
                            "Entertainment"
                          ]
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedTopics.contains(e)) {
                                        selectedTopics.remove(e);
                                      } else {
                                        selectedTopics.add(e);
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: selectedTopics.contains(e)
                                              ? AppPallete.gradient1
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: selectedTopics.contains(e)
                                                  ? AppPallete.gradient1
                                                  : Colors.white)),
                                      child: Center(
                                        child: Text(
                                          e,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlogEditorField(
                          controller: tittleController, hintText: "Tittle"),
                      const SizedBox(
                        height: 20,
                      ),
                      BlogEditorField(
                          controller: bodycontroller, hintText: "Blog content"),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate() &&
                              selectedTopics.isNotEmpty &&
                              image != null) {
                            final userId = (context.read<AppUserCubit>().state
                                    as AppUserLogedin)
                                .user
                                .id;
                            context.read<BlogBloc>().add(BlogUpload(
                                userId: userId,
                                image: image!,
                                content: bodycontroller.text.trim(),
                                tittle: tittleController.text.trim(),
                                topics: selectedTopics));
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    AppPallete.gradient1,
                                    AppPallete.gradient2,
                                  ]),
                              borderRadius: BorderRadius.circular(12),
                              color: AppPallete.gradient2),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
