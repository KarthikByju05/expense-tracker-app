import 'package:expensetracker/components/expense_summary.dart';
import 'package:expensetracker/components/expense_tile.dart';
import 'package:expensetracker/data/expense_data.dart';
import 'package:expensetracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare data
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

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
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(hintText: "Expense Name"),
            ),

            // expense amount
            TextField(
              controller: newExpenseAmountController,
              decoration: const InputDecoration(hintText: "Dollars"),
            ),
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

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // save item
  void save() {
    // check if both controllers are filled before saving
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      // create new expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );

      //add the expense item
      Provider.of<ExpenseData>(
        context,
        listen: false,
      ).addNewExpense(newExpense);

      Navigator.pop(context);
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: ListView(
          children: [
            // weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekData()),

            const SizedBox(height: 20),
            // expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
