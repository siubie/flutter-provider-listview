import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});
  final TextEditingController _controller = TextEditingController();
  String task = ''; // This variable holds the tasks user wants to add

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Task Baru"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Masukkan Task Baru",
              ),
              onChanged: (value) {
                // This saves the value in the TextField for every character the user types

                context.read<Tasklist>().changeTaskName(value);
                task =
                    value; // The value in the TextField is referred to by the 'value' variable
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<Tasklist>().addTask(task);
                      //This is where I am calling the function to add a task to the list

                      Navigator.pop(context, true);
                    },
                    child: const Text("Tambah Task Baru"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
