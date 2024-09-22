import 'package:cleanarchitecture/core/theme/app_pallet.dart';
import 'package:cleanarchitecture/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatelessWidget {
  const AddNewBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tittleController = TextEditingController();
    final bodycontroller = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              DottedBorder(
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
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ["Business", "Technology", "Programming", "Entertainment"]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white)),
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
                          )
                          .toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BlogEditorField(controller: tittleController, hintText: "Tittle")
            ],
          ),
        ),
      ),
    );
  }
}
