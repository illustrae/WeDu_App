import 'package:flutter/material.dart';


class TopCards extends StatelessWidget {
  const TopCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            18.0), // Adjust the radius for roundness
      ),
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top:10),
      color: Color.fromARGB(255, 204, 202, 204),
      elevation: 3,
      child: Container(
        height:100,
        width:125,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: Center(
          child: Text("Box 1"),
        ),
      ),
    );
  }
}
