import 'package:flutter/material.dart';

class TopCards extends StatelessWidget {
  final String text;
  final Color color;
  final double elevation;
  final Icon icon;

  const TopCards({
    super.key,
    required this.text,
    this.color = const Color.fromARGB(255, 204, 202, 204),
    this.elevation = 3.0,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18.0), // Adjust the radius for roundness
      ),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      elevation: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Container(
          width: 125,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              image: AssetImage('assets/images/flowers.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: const Color.fromARGB(255, 13, 170, 167).withOpacity(0.5),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [icon,
                  Text(style:TextStyle( fontFamily: 'Poppins', fontSize: 14, color: Color.fromARGB(255, 243, 237, 230)),text),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
