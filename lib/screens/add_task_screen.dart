import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTasksCallback;

  AddTaskScreen(this.addTasksCallback);
  Widget build(BuildContext context) {
    String finalTaskTitle;
    var now = new DateTime.now();
    print(now);

    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   'Add Task',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 25.0,
            //     color: Color(0xFF07273d),
            //   ),
            // ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 30.0,
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.w300,
              ),
              onChanged: (newText) {
                finalTaskTitle = newText;
                // print(finalTaskTitle);
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            TextButton(
              onPressed: () {
                finalTaskTitle = finalTaskTitle.toString();
                if (finalTaskTitle != "null") {
                  addTasksCallback(finalTaskTitle);
                }
                // print('>>>>>>>>>>>>>> $finalTaskTitle');
              },
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF07273d)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(top: 10.0, bottom: 10.0))),
            ),
          ],
        ),
      ),
    );
  }
}
