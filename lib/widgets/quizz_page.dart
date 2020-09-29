import 'package:flutter/material.dart';
import 'package:flutter_quizz/widgets/text_utils.dart';
import 'package:flutter_quizz/models/question.dart';
import 'dart:async';

class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {

  Question question;

  List<Question> listQuestion = [
    Question('Paris est elle la capitale de la france ?', true, 'Paris est bien la capitale de la France', 'paris.jpg'),
    Question('Les BCAA sont des acides aminés essentiels en Musculation ?', true, 'Il faut en consommer avec modération', 'bcaa.jpg'),
    Question('Limoges est la plus grande ville du monde ? ', false, 'La plus grande ville du monde est New-york', 'limoges.jpg'),
    Question('La lune est une planète ', false, 'La lune est le satellite naturelle de la terre', 'lune.jpg'),
    Question('Twitter est le réseau social le plus utilisé ?', false, 'Le réseau social le plus utilisé est Facebook', 'twitter.jpg'),
    Question('Flutter est un langage de programmation ?', false, 'Flutter est un kit de dévellopement (un Framework !)', 'flutter.jpg'),
    Question('Minecraft est un jeu vidéo ?', true, 'C\'est un jeu très cubique', 'minecraft.jpg'),
    Question('Lucifer est une série original Netflix ?', true, 'Oui c\'est vrai', 'lucifer.jpg'),
    Question('Louis XVI s\'est suicidé ?', false, 'Il s\'est pas suicidé, mais il aurait dû', 'louisxvi.jpg'),
    Question('Les prochains JO seront à Paris ? ', true, 'Ils se jourons éffectivement à Paris en 2024', 'jo.jpg')
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = listQuestion[index];
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.5;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: TextUtils('Quizz | partie'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextUtils('Question #${index + 1}', color: Colors.grey[900],),
            TextUtils('Score : $score / ${index + 1}', color: Colors.grey[900],),
            Card(
              elevation: 8.0,
              child: Container(
                height: size,
                width: size,
                child: Image.asset('assets/' + question.imagePath, fit: BoxFit.cover,),
              )
            ),
            TextUtils(question.question, color: Colors.grey[900], textScaleFactor: 1.3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                bouttonBool(true),
                bouttonBool(false)
              ],
            )
          ],
        )
      ),
    );
  }

  RaisedButton bouttonBool(bool b) {
    return RaisedButton(
      elevation: 8.0,
      onPressed: (() => dialog(b)),
      color: Colors.green,
      child: TextUtils(b ? 'Vrai' : 'Faux', color: Colors.white,),
    );
  }

  Future<Null> dialog(bool b) async {
    bool bonneResponse = (b == question.response);
    String vrai = "assets/true.png";
    String faux = "assets/false.png";

    if (bonneResponse) {
      score ++;
    }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: TextUtils(bonneResponse ? 'Bravo !' : 'Dommage', textScaleFactor: 1.4, color: bonneResponse ? Colors.green : Colors.red,),
            contentPadding: EdgeInsets.all(18),
            children: [
              Image.asset(bonneResponse ? vrai : faux, fit: BoxFit.cover),
              Container(
                height: 20.0,
              ),
              TextUtils(question.explication, textScaleFactor: 1.1, color: Colors.grey[900]),
              Container(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  getNextQuestion();
                },
                color: Colors.green,
                child: TextUtils('Question suivante', color: Colors.white, textScaleFactor: 1.2,),
              )
            ],
          );
        }
    );
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
        return AlertDialog(
          title: TextUtils('Fin du quizz', color: Colors.deepPurpleAccent, textScaleFactor: 1.2,),
          contentPadding: EdgeInsets.all(10.0),
          content: TextUtils('Votre score : $score / ${index + 1}', color: Colors.grey[900],),
          actions: [
            FlatButton(
              onPressed: (() {
                Navigator.pop(buildContext);
                Navigator.pop(context);
              }),
              child: TextUtils('Terminé', textScaleFactor: 1.4, color: Colors.deepPurpleAccent,),
            )
          ],
        );
      }
    );
  }

  void getNextQuestion() {
    if (index < listQuestion.length - 1) {
      index ++;
      setState(() {
        question = listQuestion[index];
      });
    } else {
      alerte();
    }
  }
}