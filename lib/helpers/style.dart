import 'package:flutter/material.dart';

buttonUI(String text, {Function()? onTap}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 16),
        height: 36,
        width: 165,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 6,
                  offset: Offset(0, 1)),
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 2,
                  offset: Offset(0, 1)),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        )),
      ));
}
