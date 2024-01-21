import 'package:flutter/material.dart';

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
          case "M%":
            output = (num1 % num2).toString();
            break;
        }
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      });
    } else if (buttonText == "%") {
      setState(() {
        double a = double.parse(output);
        output = (a / 100).toString();
      });
    } else if (buttonText == "M%") {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [Colors.blue.shade700, Colors.blue.shade500],
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.bottomRight,
              //   ),
              //   borderRadius: BorderRadius.circular(20),
              // ),
                        
              
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 200),
          buildNumberButtonRow(["M%", "%", "C", "/"]),
          buildNumberButtonRow(["7", "8", "9", "X"]),
          buildNumberButtonRow(["4", "5", "6", "-"]),
          buildNumberButtonRow(["1", "2", "3", "+"]),
          buildNumberButtonRow(["0", "="]),
        ],
      ),
    );
  }

  Widget buildNumberButtonRow(List<String> buttons) {
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((buttonText) {
        Color buttonColor;
        
        switch (buttonText) {
          case "0":
          case "1":
          case "2":
          case "3":
          case "4":
          case "5":
          case "6":
          case "7":
          case "8":
          case "9":
            buttonColor = const Color.fromARGB(255, 10, 1, 0);
            break;
          // case "=":
          //   buttonColor = const Color.fromARGB(255, 211, 211, 211);
          //   break;
          case "C":
            buttonColor = const Color.fromARGB(255, 250, 9, 9);
            break;
          default:
            buttonColor = Colors.orange; // Default color for other buttons
            break;
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                buttonPressed(buttonText);
              },
              style: ElevatedButton.styleFrom(
                primary: buttonColor,
                padding: const EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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