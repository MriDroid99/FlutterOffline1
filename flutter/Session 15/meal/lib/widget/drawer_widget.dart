import 'package:flutter/material.dart';

class DrawrWidget extends StatelessWidget {
  const DrawrWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                color: Theme.of(context).primaryColor,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/'),
            title: Text(
              'Category',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            thickness: 1.5,
            height: 0,
          ),
          ListTile(
            onTap: () {},
            title: Text(
              'Setteings',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
