import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  // add a new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add a new expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //expense name
            TextField(controller: newExpenseNameController),

            // expense amount
            TextField(controller: newExpenseAmountController),
          ],
        ),

        actions: [
          // save button
          MaterialButton(onPressed: save, child: Text("SAVE")),

          // cancel button
          MaterialButton(onPressed: cancel, child: Text("CANCEL")),
        ],
      ),
    );
  }

  void save() {}

  void cancel() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        child: Icon(Icons.add),
      ),
    );
  }
}
