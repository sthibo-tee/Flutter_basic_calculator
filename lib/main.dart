import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expressions/expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});
  final selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorAppState(),
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        home: CalculatorScreen(),
        ),
        // child: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 70, 2))
        // ),
    );
  }

}

class CalculatorAppState extends ChangeNotifier {
  
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen>{

  String displayText = "0";
  String buttonInput = "";
  int openParentesisCount = 0;
  bool isDarkMode = false;
  bool clickEqual = false;
  bool zeroFirst = false;

  void onButtonPressed(String buttonText) {
    setState(() {
      if (clickEqual == true) {
        displayText = buttonText;
        clickEqual = false;

      }else if (displayText == "error") {
        displayText = buttonText;

      } else if ((openParentesisCount > 0) && (buttonText == "(")) {
        displayText += ")";
        openParentesisCount --;

      } else if (buttonText == "(") {

        if (displayText == "0") {
          displayText = "(";
          openParentesisCount ++;

        } else {
          displayText += "(";
          openParentesisCount ++;
        }
      } else {
        if (buttonText == "0" && displayText == "0") {
          zeroFirst = true;
          displayText = buttonText;

        }else if (zeroFirst == false && displayText == "0") {
          displayText = buttonText;

        } else {
          displayText += buttonText;
          zeroFirst = false;
        }
      }
    });
  }

  void clearDisplay() {
    setState(() {
      displayText = "0";
      openParentesisCount = 0;
    });
  }

  void backSpace() {
    setState(() {
      if (displayText.length > 1) {
        displayText = displayText.substring(0, displayText.length - 1);

      } else {
        displayText = "0";
        openParentesisCount = 0;
      }
    });
  }

  void evaluateEquation() {
    setState(() {
      try {
        List <String> temp = displayText.split("");
        int index ;

        if (temp.contains("x")) {
          index = temp.indexOf("x");
          temp.removeAt(index);
          temp.insert(index, "*");
        } 
        
        if (temp.contains("÷")) {
          index = temp.indexOf("÷");
          temp.removeAt(index);
          temp.insert(index, "/");
        }

        displayText = temp.join();

        final expression = Expression.parse(displayText);

        final evalutor = const ExpressionEvaluator();
        final result = evalutor.eval(expression, {});

        displayText = result.toString();
        clickEqual = true;

      } catch (e) {
        displayText = "error";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        actions: [
          IconButton(
            onPressed: null, 
            icon: Icon(Icons.brightness_6)
          ),
        ],
      ),
      
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            ),
            Divider(),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: clearDisplay,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("C",
                          style: TextStyle(fontSize: 24),),
                        ),
                        // ElevatedButton.icon(
                        //   onPressed: backSpace,
                        //   icon: Icon(Icons.backspace), 
                        //   label: Text(""),
                        //   style: ElevatedButton.styleFrom(
                        //     minimumSize: Size(60, 60),
                        //     padding: EdgeInsets.all(16),
                        //   ),
                        // ),
                        ElevatedButton(
                          onPressed: backSpace,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Icon(Icons.backspace),
                        ),
                        // IconButton(
                        //   onPressed:backSpace,
                        //   icon: Icon(Icons.backspace),
                        //   style: IconButton.styleFrom(
                        //     minimumSize: Size(60, 60),
                        //     padding: EdgeInsets.all(16),
                        //     elevation: 10,
                        //     shape: CircleBorder(),
                        //   ),
                        // ),
                        ElevatedButton(
                          onPressed: (){
                            onButtonPressed("(");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("()",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("+");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("+",
                          style: TextStyle(fontSize: 24),)
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("7");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("7",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("8");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("8",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("9");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("9",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("-");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("-",
                          style: TextStyle(fontSize: 24),)
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("4");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("4",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("5");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("5",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("6");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("6",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("x");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("x",
                          style: TextStyle(fontSize: 24),)
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("1");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("1",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("2");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("2",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("3");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("3",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("÷");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("÷",
                          style: TextStyle(fontSize: 24),)
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed(".");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text(".",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("0");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("0",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onButtonPressed("%");
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("%",
                          style: TextStyle(fontSize: 24),)
                        ),
                        ElevatedButton(
                          onPressed: evaluateEquation,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60, 60),
                            padding: EdgeInsets.all(16),
                          ),
                          child: Text("=",
                          style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
        ],
      ),
    );
  }
}