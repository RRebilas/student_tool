import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ToDoModel.dart';

class ToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<ToDoModel>(context, listen: false);

    return Stack(
      children: <Widget>[
        Scrollbar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Consumer<ToDoModel>(
              builder: (context, task, child) => ListView.builder(
                  itemCount: task.tasks.length,
                  itemBuilder: (context, index) {
                    try {
                      return Dismissible(
                        key: Key(task.tasks[index].id.toString()),
                        onDismissed: (direction) {
                          //TODO: swipe right to complete task and move it to completed DraggableScrollableSheet
                          //TODO: swipe left to display icon to delete task, maybe click for details with menu to edit task
                          taskProvider.remove(index);
                        },
                        child: ListTile(
                          leading: Container(
                            width: 20,
                            child: FlatButton(
                              child: Icon(Icons.edit),
                              //TODO
                              onPressed: () {},
                            ),
                          ),
                          title: Text(task.tasks[index].title),
                        ),
                      );
                    } catch (e) {
                      return Text('error occurred');
                    }
                  }),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              tooltip: 'Utwórz',
              backgroundColor: Colors.deepPurple.shade900,
              onPressed: () {
                taskProvider.add(Task('Zadanie'));
              },
              label: Text('Utwórz'),
              icon: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
