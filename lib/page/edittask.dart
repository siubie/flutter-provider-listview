import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';
import '../models/task.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _controller.text = widget.task.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              // initialValue: task.name,
              decoration: InputDecoration(
                hintText: "Edit Task",
                errorText: context.watch<Tasklist>().taskName.error,
              ),
              controller: _controller,
              onChanged: (value) {
                context.read<Tasklist>().whenTaskNameChange(value);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: context.watch<Tasklist>().isActive
                        ? () {
                            context
                                .read<Tasklist>()
                                .setTaskName(_controller.text);

                            if (context.read<Tasklist>().isValidated()) {
                              context
                                  .read<Tasklist>()
                                  .updateTask(widget.task, _controller.text);
                              Navigator.pop(context);
                            }
                          }
                        : null,
                    child: const Text("Edit Task"),
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
