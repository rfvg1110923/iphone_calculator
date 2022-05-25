import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main(){
  runApp(calculatorApp());
}

class calculatorApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(     //responsive_framework(響應式框架)
          child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: "/",
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
  String finalResult = "0";
  double num1 = 0;
  double num2 = 0;
  double num3 = 0;
  String operand = "";

  buttonPressed(String btntxt){     //按鈕觸發事件，不包含0
    if(btntxt == "AC"){
      result = "0";
      finalResult = "0";
      num1 = 0;
      num2 = 0;
      num3 = 0;
      operand = "";
    }
    else if(btntxt == "+" || btntxt == "-" || btntxt == "x" || btntxt == "/"){
      num1 = double.parse(result);
      operand = btntxt;
      finalResult = "0";
    }
    else if(btntxt == "."){
      if(!result.contains(".")){
        finalResult = result + btntxt;
      }
    }
    else if(btntxt == "+/-"){
      if(double.parse(result) < 0){
        finalResult = finalResult.replaceAll("-", "");
      }else if(double.parse(result) > 0){
        finalResult = "-$finalResult";
      }
    }
    else if(btntxt == "="){
      num2 = double.parse(result);
      if(operand == "+"){
        finalResult = (num1 + num2).toString();
      }
      else if(operand == "-"){
        finalResult = (num1 - num2).toString();
      }
      else if(operand == "x"){
        finalResult = (num1 * num2).toString();
        if (finalResult.split(".")[1].length > 8){      //取小數點後8位數
          finalResult = finalResult.split(".")[0] + "." +  finalResult.split(".")[1].substring(1,9);
        }
      }
      else if(operand == "/"){
        if(num2 == 0){
          finalResult = "ERROR";
        }
        else {
          finalResult = (num1 / num2).toString();
          if (finalResult.split(".")[1].length > 8){      //取小數點後8位數
            finalResult = finalResult.split(".")[0] + "." +  finalResult.split(".")[1].substring(1,9);
          }
        }
      }
      num1 = 0;
      num2 = 0;
      operand ="";
    }
    else if(btntxt == "%"){
      num3 = double.parse(result);
      finalResult = (num3 / 100).toString();
    }
    else{
      finalResult += btntxt;
    }
    if(finalResult.length > 1 && finalResult.startsWith("0") && !(finalResult.contains("."))){      //移除開頭的0
      finalResult = finalResult.substring(1, finalResult.length);
    }

    setState(() {     //畫面更新
      result = finalResult;
    });
  }

  Widget calbutton(String btntxt, Color btncolor, Color txtcolor){      //按鈕設定
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
              Row(      //顯示結果
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
              Row(      //按鈕介面
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
                  RaisedButton(     //button 0

                    padding: EdgeInsets.fromLTRB(34, 20, 145, 20),
                    onPressed: (){      //按鈕0觸發事件
                      if (result.length == 1 && result == "0")
                        finalResult = "0";
                      else {
                        finalResult += "0";
                      }
                      setState(() {
                        result = finalResult;
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

