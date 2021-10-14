import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SheetWidget extends StatefulWidget {
  final Function(String id, String title, double price, DateTime date) addItem;
  const SheetWidget(this.addItem, {Key? key}) : super(key: key);

  @override
  State<SheetWidget> createState() => _SheetWidgetState();
}

class _SheetWidgetState extends State<SheetWidget> {
  DateTime? _selectedDate;
  var titleController = TextEditingController();
  var priceController = TextEditingController();

  void _showDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _selectedDate = value ?? DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Enter Title of Item',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
              labelText: 'Price',
              hintText: 'Enter Price of Item',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate == null
                    ? 'No Date Selected Yet!'
                    : DateFormat.yMMMd().format(_selectedDate!),
              ),
              TextButton(
                onPressed: () {
                  _showDate(context);
                },
                child: const Text('Select Date'),
              )
            ],
          ),
          MaterialButton(
            onPressed: () {
              widget.addItem(
                DateTime.now().toString(),
                titleController.text,
                double.parse(priceController.text),
                _selectedDate!,
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Add Item',
              style: TextStyle(color: Colors.white),
            ),
            height: 50,
            minWidth: double.infinity,
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    );
  }
}
