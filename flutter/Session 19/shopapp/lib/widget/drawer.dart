import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Theme.of(context).colorScheme.primary,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Menu',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.pushReplacementNamed(context, '/tab'),
            title: Text(
              'Products',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.5,
            height: 0,
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/order'),
            title: Text(
              'Order',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 1.5,
            height: 0,
          ),
          ListTile(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/manage_products'),
            title: Text(
              'Manage Products',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
