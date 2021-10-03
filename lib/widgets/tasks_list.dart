import 'package:flutter/material.dart';
import 'tasks_tile.dart';
import '../models/task.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl_browser.dart';

class TasksList extends StatefulWidget {
  final List<Task> tasks;
  TasksList({this.tasks});
  createState() => TasksListState();
}

class TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        String time = widget.tasks[index].dateTime.toString();
        final item = widget.tasks[index];
        return Dismissible(
          key: Key(item.name),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          onDismissed: (direction) {
            setState(() {
              widget.tasks.removeAt(index);
            });

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Note dismissed')));
          },
          child: ListTile(
            // contentPadding: EdgeInsets.zero,

            title: Text(
              widget.tasks[index].name,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
                decoration: widget.tasks[index].isDone
                    ? TextDecoration.lineThrough
                    : null,
                color: widget.tasks[index].isDone
                    ? Colors.grey
                    : Colors.blueGrey[900],
              ),
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // SizedBox(
                //   height: 10.0,
                // ),
                Text(
                  // widget.tasks[index].dateTime.toString(),
                  time,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 10,
                  ),
                ),
              ],
            ),

            trailing: Checkbox(
              activeColor: Colors.blueGrey[900],
              value: widget.tasks[index].isDone,
              onChanged: (value) {
                setState(() {
                  widget.tasks[index].toggleDone();
                });
              },
            ),
          ),
        );
      },
    );
  }
}
