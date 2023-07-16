// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/todoController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController controller = Get.put(TodoController());

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Add TODO',
                  content: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                        ),
                      ),
                      TextFormField(
                        controller: descController,
                        decoration: const InputDecoration(
                          hintText: 'Descripation',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cencal')),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                controller.postTodo(titleController.text,descController.text);
                                titleController.clear();
                                descController.clear();
                                Get.back();
                              },
                              child: const Text('Save')),
                        ],
                      )
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title:  const Text(
                  'All Task',
                  style: TextStyle(
                    
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
             
       
              backgroundColor: Colors.deepPurpleAccent,
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
               
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    child: Obx(
                  () =>controller.isloading.value 
                  ?Center(child: Lottie.network('https://lottie.host/743fac73-fcd4-4c2e-9f60-ec84c383aef5/cNPPbphsRN.json',)): Column(
                      children: controller.todoList
                          .map(
                            (e) => Card(
                              child: ListTile(
                               
                                title: Text(e.title.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                subtitle: Text(e.desc.toString()),
                                trailing: IconButton(onPressed: (){
                                  controller.deleteTodo(e.id);
                                }, icon: const Icon(Icons.delete)),
                              ),
                            )
                          )
                          .toList()),
                ))
              ],
            ))));
  }
}

