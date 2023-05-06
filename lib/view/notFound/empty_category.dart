import 'package:flutter/material.dart';

class EmptyCategory extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String description;

  const EmptyCategory({
    Key? key,
    required this.iconData,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 64.0,
          backgroundColor: Colors.white,
          child: Icon(
            iconData,
            size: 64.0,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.grey,
              ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
