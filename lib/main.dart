import 'package:flutter/material.dart';
import 'package:quiz/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black54,
          body: quizapp(),
        ),
      )
  );
}

class quizapp extends StatefulWidget {
  @override
  _quizappState createState() => _quizappState();
}

class _quizappState extends State<quizapp> {
  @override

  QuizBrain qb = new QuizBrain();

  void alert(){
    int x = qb.getCorrectCount();
    Alert(
      context: context,
      title: "Quiz End",
      desc: "You have successfull awnsered $x questions.",
      buttons: [
        DialogButton(
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              qb.reset();
            });
          },
          width: 120,
        )
      ],
    ).show();
  }

  void checker(bool x){
    if(qb.getQuestionAwnser() == x){
      if(qb.lengthExceed()) {
        setState(() {
          qb.scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          qb.countup();
          qb.incrimentQuestionNumber();
        });
      }else{
        qb.countup();
        alert();
      }
    }else{
      if(qb.lengthExceed()) {
        setState(() {
          qb.scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          qb.incrimentQuestionNumber();
        });
      }else{
        alert();
      }
    }
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qb.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    'true',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: (){
                    checker(true);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Text(
                    'false',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: (){
                    checker(false);
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Row(
            children: qb.scoreKeeper,
          ),
        )
      ],
    );
  }
}
