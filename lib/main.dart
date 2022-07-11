import 'package:flutter/material.dart';
import 'file_utils.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator - Joshua Perth Alviso'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int first = 0, second = 0; // 2 numbers to calculate
  String opp = "", fstring = "", sstring = ""; //for opperands
  String result = "", text = ""; // Result

  void btnClicked(String btnVal){
    String toSave= 'Hello!';

    if(btnVal == "C"){
      //Reset
      result = "";
      text = "";
      first = 0;
      second = 0;
    }else if(btnVal == "+" || btnVal == "x" || btnVal == "-" || btnVal == "÷"){
      //Saving Values
      first = int.parse(text);
      fstring = text;
      result = "";
      opp = btnVal;
    }else if(btnVal == "="){
      //Execution of Operators
      second = int.parse(text);
      sstring  = text;
      if(opp == '+'){
        result = (first + second).toString();
      }else if(opp == '-'){
        result = (first - second).toString();
      }else if(opp == 'x'){
        result = (first * second).toString();
      }else if(opp == '÷'){
        result = (first ~/ second).toString();
      }

      toSave = fstring + " " + opp + " " + sstring + " = " + result; //What's being saved on the Text file
      FileUtils.saveToFile(toSave);



    } else{
      result = int.parse(text + btnVal).toString();
    }

    setState(() {
      text = result;
    });

  }

  Widget customOutlineButton(String value){
    return  Expanded(
      child: OutlinedButton(
          onPressed: () => btnClicked(value),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.grey,
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 25),

          )
      ),
    );
  }



  String fileContents = "";
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    FileUtils.readFromFile().then((contents) {
      setState(() {
        fileContents = contents;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text("History: " + fileContents,
                style: TextStyle(color: Colors.grey),
              )
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3A3A3A),
                      ),
                    )
                )
            ),
            Row(
              children: [
                customOutlineButton("9"),
                customOutlineButton("8"),
                customOutlineButton("7"),
                customOutlineButton("+"),
              ],
            ),
            Row(
              children: [
                customOutlineButton("6"),
                customOutlineButton("5"),
                customOutlineButton("4"),
                customOutlineButton("-"),
              ],
            ),
            Row(
              children: [
                customOutlineButton("3"),
                customOutlineButton("2"),
                customOutlineButton("1"),
                customOutlineButton("x"),
              ],
            ),
            Row(
              children: [
                customOutlineButton("C"),
                customOutlineButton("0"),
                customOutlineButton("="),
                customOutlineButton("÷"),
              ],
            ),


          ],




        ),
      ),
    );
  }
}
