import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;

  TaskTile({
    this.isChecked,
    this.taskTitle,
    this.checkboxCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: EdgeInsets.zero,
      title: Text(
        taskTitle,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w300,
          fontSize: 20.0,
          decoration: isChecked ? TextDecoration.lineThrough : null,
          color: isChecked ? Colors.grey : Colors.blueGrey[900],
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.blueGrey[900],
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
