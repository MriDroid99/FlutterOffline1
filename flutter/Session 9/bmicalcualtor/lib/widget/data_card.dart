import 'package:flutter/material.dart';

class DataCard extends StatefulWidget {
  String label;
  int value;
  DataCard(this.label, this.value, {Key? key}) : super(key: key);

  @override
  State<DataCard> createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            '${widget.value}',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  setState(() {
                    widget.value--;
                  });
                },
                child: const Icon(Icons.remove),
              ),
              FloatingActionButton(
                mini: true,
                onPressed: () {
                  setState(() {
                    widget.value++;
                  });
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
