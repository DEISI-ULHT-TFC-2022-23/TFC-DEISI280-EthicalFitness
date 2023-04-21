import 'package:flutter/material.dart';

class GroupClassesPage extends StatefulWidget {
  @override
  _GroupClassesPageState createState() => _GroupClassesPageState();
}

class _GroupClassesPageState extends State<GroupClassesPage> {
  // List to store group classes
  List<String> groupClasses = [
    'Yoga',
    'Zumba',
    'Pilates',
    'Crossfit',
    'Spinning',
    'Bootcamp'
  ];

  // Set to store selected group classes
  Set<String> selectedGroupClasses = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Classes'),
      ),
      body: ListView.builder(
        itemCount: groupClasses.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            title: Text(groupClasses[index]),
            value: selectedGroupClasses.contains(groupClasses[index]),
            onChanged: (bool? value) {
              setState(() {
                if (value != null && value) {
                  selectedGroupClasses.add(groupClasses[index]);
                } else {
                  selectedGroupClasses.remove(groupClasses[index]);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          // Save selected group classes
          // You can add your own code here to save the selected group classes
          print(selectedGroupClasses);
        },
      ),
    );
  }
}
