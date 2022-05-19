import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main(){
  runApp(calculatorApp());
}

class calculatorApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: (context, child) => ResponsiveWrapper.builder(
      //     child,
      //     maxWidth: 1200,
      //     minWidth: 480,
      //     defaultScale: true,
      //     breakpoints: [
      //       ResponsiveBreakpoint.resize(480, name: MOBILE),
      //       ResponsiveBreakpoint.autoScale(800, name: TABLET),
      //       ResponsiveBreakpoint.resize(1000, name: DESKTOP),
      //     ],
      //     background: Container(color: Color(0xFFF5F5F5))),
      // initialRoute: "/",
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String result = "0";
  String _result = "0";
  dynamic num1 = 0;
  dynamic num2 = 0;
  String operand = "";

  buttonPressed(String btntxt){
    if(btntxt == "AC"){
      _result = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    }else if(btntxt == "+" || btntxt == "-" || btntxt == "x" || btntxt == "/"){
      num1 = double.parse(result);
      operand = btntxt;
      _result = "0";
    }else if(btntxt == "."){
      if(_result.contains(".")){
        return;
      }else{
        _result = _result + btntxt;
      }
    }else if(btntxt == "+/-"){
      if(double.parse(result) < 0){
        _result = _result.replaceAll("-", "");
      }else if(double.parse(result) > 0){
        _result = "-$_result";
      }
    }else if(btntxt == "="){
      num2 = double.parse(result);
      if(operand == "+"){
        _result = (num1 + num2).toString();
      }else if(operand == "-"){
        _result = (num1 - num2).toString();
      }else if(operand == "x"){
        _result = (num1 * num2).toString();
      }else if(operand == "/"){
        if(num2 == 0){
          _result = "ERROR";
        }else
          _result = (num1 / num2).toStringAsFixed(5);
      }
      num1 = 0;
      num2 = 0;
    }else if(btntxt == "%"){
      _result = (double.parse(result) / 100).toString();
    }
    else{
      _result += btntxt;
      if(_result.length > 1 && _result.startsWith("0") && !(_result.contains("."))){
        _result = _result.substring(1, _result.length);
      }
    }

    setState(() {
      result = _result;
    });
  }


  Widget calbutton(String btntxt, Color btncolor, Color txtcolor){
    return Container(
      child: RaisedButton(
        onPressed: () => buttonPressed(btntxt),
        child: Text(btntxt,
          style: TextStyle(
              fontSize: 35,
              color: txtcolor
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20.0),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Calculator"),backgroundColor: Colors.black,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(  //顯示結果
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(result,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                    fontSize: 50),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("AC", Colors.grey, Colors.black),
                calbutton("+/-", Colors.grey, Colors.black),
                calbutton("%", Colors.grey, Colors.black),
                calbutton("/", Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("7", Colors.grey.shade800, Colors.white),
                calbutton("8", Colors.grey.shade800, Colors.white),
                calbutton("9", Colors.grey.shade800, Colors.white),
                calbutton("x", Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("4", Colors.grey.shade800, Colors.white),
                calbutton("5", Colors.grey.shade800, Colors.white),
                calbutton("6", Colors.grey.shade800, Colors.white),
                calbutton("-", Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton("1", Colors.grey.shade800, Colors.white),
                calbutton("2", Colors.grey.shade800, Colors.white),
                calbutton("3", Colors.grey.shade800 , Colors.white),
                calbutton("+", Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(   //button 0
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: (){
                    setState(() {
                      if (result.length == 1 && result == "0")
                        result = "0";
                      else {
                        result += "0";
                      }
                    });
                  },
                  shape: StadiumBorder(),
                  child: Text("0",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white
                    ),
                  ),
                  color: Colors.grey.shade800,
                ),
                calbutton(".", Colors.grey.shade800 , Colors.white),
                calbutton("=", Colors.amber.shade700, Colors.white),
              ],
            )
          ],
        ),
      )
    );
  }
}

