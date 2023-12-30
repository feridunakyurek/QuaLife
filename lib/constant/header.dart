import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: deviceWidth,
      height: deviceHeight / 8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              'QuaLife',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
          ),
          Text(
            "Kaliteli Yaşam Destekçiniz",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
