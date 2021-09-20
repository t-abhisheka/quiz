import 'package:flutter/material.dart';
import 'package:quiz/quiz_brain.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black54,
      body: quizapp(),
    ),
  ));
}

class quizapp extends StatefulWidget {
  @override
  _quizappState createState() => _quizappState();
}

class _quizappState extends State<quizapp> {
  @override
  QuizBrain qb = new QuizBrain();

  void checker(bool x) {
    if (qb.getQuestionAwnser() == x) {
      if (qb.lengthExceed()) {
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
      } else {
        qb.endAlert();
      }
    } else {
      if (qb.lengthExceed()) {
        setState(() {
          qb.scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          qb.incrimentQuestionNumber();
        });
      } else {
        qb.endAlert();
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
                  onPressed: () {
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
                  onPressed: () {
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
