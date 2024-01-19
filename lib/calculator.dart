import 'dart:ui';

import 'package:flutter/material.dart' show Alignment, BorderRadius, BoxDecoration, BuildContext, Colors, Column, Container, EdgeInsets, Expanded, FocusScope, FontWeight, Key, ListView, MainAxisAlignment, MaterialApp, Padding, RoundedRectangleBorder, Row, Scaffold, SizedBox, State, StatefulWidget, StatelessWidget, Text, TextButton, TextStyle, ThemeData, Widget, runApp;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    // ... (rest of the buttonPressed method remains unchanged)
    if (buttonText == "C") {
      setState(() {
        output = "0";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      });
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "X" || buttonText == "/") {
      setState(() {
        num1 = double.parse(output);
        operand = buttonText;
        output = "0";
      });
    } else if (buttonText == "=") {
      setState(() {
        num2 = double.parse(output);
        switch (operand) {
          case "+":
            output = (num1 + num2).toString();
            break;
          case "-":
            output = (num1 - num2).toString();
            break;
          case "X":
            output = (num1 * num2).toString();
            break;
          case "/":
            output = (num1 / num2).toString();
            break;
          case "Modulus":
            output = (num1 % num2).toString();
            break;
        }
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      });
    } else if (buttonText == "Percentage") {
      setState(() {
        double a = double.parse(output);
        output = (a / 100).toString();
      });
    } else if (buttonText == "Modulus") {
      setState(() {
        num1 = double.parse(output);
        operand = buttonText;
        output = "0";
      });
    } else {
      setState(() {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      });
    }
    FocusScope.of(context).unfocus();

    // After processing the button press, hide the keyboard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Flutter Calculator"),
      // ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: ListView(
        children: [
          Container(
  padding: const EdgeInsets.all(25.0),
  alignment: Alignment.centerRight,
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 255, 255, 255),
    borderRadius: BorderRadius.circular(15.0),
  ),
  child: Text(
    output,
    style: const TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      color:  Color.fromARGB(255, 0, 0, 255),
    ),
  ),
),

          const SizedBox(height: 200),
          buildButtonRow(["1", "2", "3", "+"]),
          buildButtonRow(["4", "5", "6", "-"]),
          buildButtonRow(["7", "8", "9", "X"]),
          buildButtonRow(["0", "C", "=", "/"]),
          buildButtonRow(["Percentage", "Modulus"]),
          // Add some extra space at the bottom to accommodate the keyboard
        ],
      ),
    );
  }

 Widget buildButtonRow(List<String> buttons) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((buttonText) {
        Color buttonColor = const Color.fromARGB(255, 255, 255, 255);
        Color textColor = const Color.fromARGB(255, 8, 0, 0); // Default text color

        // Set a different text color for specific buttons
        if (buttonText == "+" || buttonText == "-" || buttonText == "X" || buttonText == "/" || buttonText == "Percentage" || buttonText == "Modulus") {
          textColor = const Color.fromARGB(255, 0, 0, 255); // Blue text color
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                buttonPressed(buttonText);
              },
              style: TextButton.styleFrom(
                backgroundColor: buttonColor,
                shadowColor: const Color.fromARGB(255, 168, 154, 154),
                elevation: 3,
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}





}
