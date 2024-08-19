import 'package:flutter/material.dart';
import 'package:taskappwithblocandfirebase/blocs/bloc_exports.dart';
import 'completed_tasks_screen.dart';
import 'favorite_tasks_screen.dart';
import 'my_drawer.dart';
import 'pending_screen.dart';

import 'add_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Pending Tasks'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pageName': const FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];
// to get all task we call in init state
  @override
  void initState() {
    context.read<TasksBloc>().add(GetAllTasks());
    super.initState();

  }
  // end 

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add,color: Colors.blue,
            
            size: 30,),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child:  Icon(Icons.add),
              backgroundColor: Colors.blueAccent,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        backgroundColor: Colors.blueAccent, // Set your desired background color here
        selectedItemColor: Colors.white, // Optional: Set the color of the selected item
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'Pending Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_sharp), label: 'Completed Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite Tasks'),
        ],
      ),
    );
  }
}
