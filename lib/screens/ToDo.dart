import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studenttool/index.dart';
import 'package:studenttool/widgets/common_widgets.dart';
import '../models/ToDoModel.dart';

class ToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<ToDoModel>(context, listen: false);

    return SafeArea(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(60, 30)),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: appGradient(),
              ),
              child: Scrollbar(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      category("Szkoła"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            color: Colors.white,
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    size: 50,
                                    color: Colors.deepOrange.shade700,
                                  ),
                                ),
                                Text("Dodaj kategorię"),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Scrollbar(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                                  taskProvider.removeItem(index);
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
                      backgroundColor: Colors.deepOrange.shade600,
                      onPressed: () {
                        taskProvider.addItem(Task('Zadanie'));
                      },
                      label: Text('Utwórz'),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget category(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          color: Colors.white,
          width: 120,
          child: Center(child: Text("$title")),
        ),
      ),
    );
  }
}
