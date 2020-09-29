import 'package:flutter/material.dart';
import 'package:flutter_quizz/widgets/text_utils.dart';
import 'package:flutter_quizz/widgets/quizz_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset('assets/quizz_cover.jpg', fit: BoxFit.cover,),
              ),
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return QuizzPage();
                }));
              },
              child: TextUtils('Démarrer le quizz', color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}
