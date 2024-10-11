import 'package:flutter/material.dart';

class info extends StatelessWidget {
  const info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(76, 140, 43, 1),
      padding: EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'images/agrocaf_logo.png',
                  height: 150.0,
                  width: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Agrocaf\nOperador',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Color.fromRGBO(255, 255, 255, 0.965),
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        )),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(90),
              )),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              color: Color.fromRGBO(252, 252, 252, 1),
              padding: EdgeInsets.symmetric(horizontal: 170, vertical: 8),
              //margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Text('Valor del Kilo --------'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
