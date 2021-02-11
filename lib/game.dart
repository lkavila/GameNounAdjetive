import 'dart:math';
import 'Player.dart';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class FirstStatefulWidget extends StatefulWidget {
  FirstStatefulWidget({Key key}) : super(key: key);

  @override
  _FirstStatefulWidgetState createState() => _FirstStatefulWidgetState();
}



class _FirstStatefulWidgetState extends State<FirstStatefulWidget> {
  String _theState = "0";
  int _actualWordType = 0;
  int _score = 0;
  int _intentos = 1;
  List<Player> _players = [];
  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      print("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      print("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
    }

    setState(() {
      _theState = randomItem;
      _actualWordType = option;
    });
  }

  void _onPressed(int option) {
    if (option == _actualWordType) {
      print("good");
      _score=_score+10;
    } else {
      print("not good");
      _score=_score-5;
    }
    setRandomWord();
  }

  void _onReset() {
    Player myP = Player();
    myP.name = "player "+_intentos.toString();
    myP.score = _score;
    _players.add(myP);
    _players.sort((a,b)=>b.score.compareTo(a.score));
    print("El maximo puntaje es "+ _players.first.score.toString() + ", obtenido por "+_players.first.name);
    _score=0;
    _intentos++;

    setState(() {
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 50.0, 0.0, 0.0),
            child: Align(
            
              alignment: Alignment.centerRight,
              child: Row(
              
                children: [ 
                  Text( "Score: ",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text("$_score   ",   
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 15)),
                  ),
                  Container(
                    width: 40.0,
                    child: Image(
                      image: AssetImage('assets/images/moneda.png'),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(80.0, 0.0, 0.0, 0.0),
                      child:MaterialButton(
                              minWidth: 50.0,
                              height: 30.0,
                              onPressed: () => {_onReset(), showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                                elevation: 16,
                                                content: Container(
                                                  height: 400.0,
                                                  width: 350.0,
                                                  child: ListView(
                                                    children: <Widget>[
                                                      SizedBox(height: 20),
                                                      Center(
                                                        child: Text(
                                                          "Leaderboard",
                                                          style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                      
                                                      SizedBox(height: 20),
                                                      getPlayers(_players)

                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                          FlatButton(
                                                            child: Text('Ok'),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            })
                                                ]
                                               
                                              );
                                          },
                                        ),
                                        },
                              color: Colors.blue,
                              splashColor: Colors.indigo[700],
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.blue)
                              ),
                              child: Text('Reset', style: TextStyle(color: Colors.white, fontSize: 10)),
                            ),
                  ),
                ],
                ),
            ),
          
          ),


          Text(
            "$_theState",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent, fontSize: 30)),
          
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Expanded(
                  child: MaterialButton(
                      minWidth: 150.0,
                      height: 200.0,
                      onPressed: () => _onPressed(0),
                      color: Colors.blue[300],
                      splashColor: Colors.indigo[700],
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue)
                      ),
                      child: Text('Noun', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                ),
                Expanded(
                  child: MaterialButton(
                      minWidth: 10.0,
                      height: 200.0,
                      onPressed: () => _onPressed(1),
                      color: Colors.amber,
                      splashColor: Colors.amber[200],
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue)
                      ),
                      child: Text('Adjective', style: TextStyle(color: Colors.white,fontSize: 15)),
                    ),
                ),


            ],
          ),
          

        ],
      ),
    );
  }
}

  Widget getPlayers(List<Player> players)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < players.length; i++){
        list.add(_buildName(imageAsset: players[i].image, name: players[i].name, score: players[i].score));
    }
    return new Column(children: list);
  }

Widget _buildName({String imageAsset, String name, int score}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12),
        Container(height: 2, color: Colors.redAccent),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(imageAsset),
              radius: 30,
            ),
            SizedBox(width: 12),
            Text(name),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text("$score"),
              decoration: BoxDecoration(
                color: Colors.yellow[900],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

