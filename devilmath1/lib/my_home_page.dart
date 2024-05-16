
import 'package:flutter/material.dart'; 
import 'dart:math';
import 'dart:async';



class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/fire.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              "Start a game",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              height: 60.0,
              width: 200.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF5733), Color(0xFFC70039), Color(0xFF900C3F), Color(0xFF511845)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              height: 60.0,
              width: 200.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TutorialScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF5733), Color(0xFFC70039), Color(0xFF900C3F), Color(0xFF511845)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Tutorial',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF5733), Color(0xFFC70039), Color(0xFF900C3F), Color(0xFF511845)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen2()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(
                        16.0), // İstediğiniz padding değerini belirleyebilirsiniz
                    child: Text(
                      'Start the timer and start the game!',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GameScreen2 extends StatefulWidget {
  @override
  _GameScreen2State createState() => _GameScreen2State();
}

class _GameScreen2State extends State<GameScreen2> {
  int target = Random().nextInt(7);
  late List<dynamic> widgets;
  String expression = '';
  double difference = 0;
  late Timer timer;
  bool showNewPage = false;
  int points = 0; // Move the points variable to the class level

  @override
  void initState() {
    super.initState();
    widgets = _generateRandomExpression();
    _updateExpression();
    // Timer'ı başlatın
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      // Timer her saniye bir tetiklenecek
      setState(() {
        if (t.tick == 45) {
          // 45 saniye bittiğinde yapılacak işlemler
          timer.cancel(); // Timer'ı iptal et
          showNewPage = true; // Yeni sayfayı gösterme kontrolünü aktive et
          if (!mounted) return;
          _showResultPage(context, difference);
          // Yeni sayfayı aç
        }
      });
    });
  }

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  List<dynamic> _generateRandomExpression() {
    final random = Random();
    // ignore: unused_local_variable
    double difference = 0;

    final numbers = List.generate(
        5, (index) => random.nextInt(10)); // 0 ile 9 arasında rastgele sayılar
    final operators = ['+', '-', '*', '/'];

    // Sayıları ve operatörleri birleştir
    final result = <dynamic>[];
    for (var i = 0; i < numbers.length; i++) {
      result.add(numbers[i]);
      if (i < operators.length) {
        result.add(operators[i]);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    int randomNumInSecondTutorial = target;

    int flag = 0;
    for (int i = 0; i < expression.length - 2; i = i + 2) {
      if (!isNumeric(expression[0])) {
        flag = 1;
        break;
      }
      if (isNumeric(expression[i]) && isNumeric(expression[i + 2])) {
        flag = 1;
        break;
      }
      if (expression[i + 2] == '0' && expression[i] == '/') {
        flag = 1;
        break;
      }
    }

    if (flag == 1) {
      print("dizilim hatalı");
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            timer.cancel();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Target Number: $randomNumInSecondTutorial',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Container(
              height: 100,
              child: Center(
                child: ReorderableListView(
                  scrollDirection: Axis.horizontal,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      _reorderList(oldIndex, newIndex);
                      _updateExpression();
                    });
                  },
                  children: widgets
                      .asMap()
                      .map(
                        (index, item) => MapEntry(
                      index,
                      _buildItem(index, item),
                    ),
                  )
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: flag == 1 ? null : _calculateExpression,
            style: ElevatedButton.styleFrom(
              primary: Colors.black, // Arkaplan rengi
              onPrimary: Colors.white, // Metin rengi
            ),
            child: Text('Calculate'),
          ),
          Text('Equation: $expression'),
          Text('Remaining Time: ${45 - timer.tick} seconds'),
        ],
      ),
    );
  }

  Widget _buildItem(int index, dynamic item) {
    return Container(
      key: ValueKey('$item-$index'),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: item is int ? BoxShape.rectangle : BoxShape.circle,
        gradient: item is int
            ? LinearGradient(
          colors: [Color(0xFFC70039), Color(0xFF900C3F)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
            : LinearGradient(
          colors: [Color(0xFFFF5733), Color(0xFF511845)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      margin: EdgeInsets.all(4.0),
      child: Center(
        child: Text(
          item is int ? item.toString() : item,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }

  void _reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final dynamic item = widgets.removeAt(oldIndex);
    widgets.insert(newIndex, item);
  }

  void _updateExpression() {
    expression = widgets.map((item) => item.toString()).join(' ');
  }

  void _calculateExpression() {
    try {
      final result = evaluateExpression();
      difference = (target - result).abs();
      points = calculatePoints(difference);

      showNewPage = true;
      if (!mounted) return;
      _showResultPage(context, difference); // result ve difference'ı iletebilirsiniz

      setState(() {
        expression = result.toString();
        difference = difference;
      });
    } catch (e) {
      print('Calculation error: $e');
      // Hesaplama hatası durumunda sadece showNewPage değerini true yap
      showNewPage = true;
      if (!mounted) return;
      _showResultPage(context, difference);
    }
  }

  void _showResultPage(BuildContext context, double difference) {
    if (showNewPage) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Score(
            points: points,
            difference: difference,
            result: showNewPage ? null : double.parse(expression),
          ),
        ),
      );
    }
  }

  int calculatePoints(double difference) {
    if (difference > 2) {
      return 0;
    } else if (difference <= 2 && difference > 1) {
      return 1;
    } else if (difference <= 1 && difference > 0.5) {
      return 3;
    } else if (difference <= 0.5 && difference > 0.2) {
      return 4;
    } else if (difference <= 0.2 && difference > 0) {
      return 6;
    } else {
      return 10;
    }
  }

  double evaluateExpression() {
    final numbers = <double>[];
    final operators = <String>[];

    for (var item in widgets) {
      if (item is int) {
        numbers.add(item.toDouble());
      } else if (item is String) {
        operators.add(item);
      }
    }

    double result = numbers[0];

    for (var i = 0; i < operators.length; i++) {
      final operator = operators[i];
      final number = numbers[i + 1];

      if (operator == '+') {
        result += number;
      } else if (operator == '-') {
        result -= number;
      } else if (operator == '*') {
        result *= number;
      } else if (operator == '/') {
        result /= number;
      }
    }

    return result;
  }
}

class Score extends StatelessWidget {
  final int points;
  final double? result;
  final double difference;

  Score({required this.points, required this.result, required this.difference});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF5733), Color(0xFFC70039), Color(0xFF900C3F), Color(0xFF511845)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Text('Score: $points', style: TextStyle(fontSize: 25.0, color: Colors.white)),
                SizedBox(height: 20.0),
                Text(
                  difference != null ? 'You are this close to the target number: $difference' : 'Invalid equation',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Arkaplan rengi
                    onPrimary: Colors.black, // Yazı rengi
                  ),
                  child: Text('Return to Home'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class TargetNumberGenerator {
  static int _storedRandomNum = -1;

  static int generateRandomNumber() {
    if (_storedRandomNum == -1) {
      _storedRandomNum = Random().nextInt(7);
    }
    return _storedRandomNum;
  }
}

class RandomNumberGenerator {
  static int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(10);
  }
}

class _TutorialScreenState extends State<TutorialScreen> {
  int randomNum = TargetNumberGenerator.generateRandomNumber();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor:
              Colors.white,
          elevation: 8.0,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome to devil's math game! Before start the game, here is your target number: ",
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF5733), Color(0xFFC70039), Color(0xFF900C3F), Color(0xFF511845)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$randomNum',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'RULES',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  " -  Swap numbers and operators to ensure that the result of the equation is closest to the target number!",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Text(
                      " -  Remember, instead of processing priority (no pemdas), calculations will be done sequentially from left to right!",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  " -  You can practice here as much as you want before starting the game. Remember that you will only have 45 seconds each round in the game!",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondTutorial(randomNum: randomNum)),
            );
          },
          child: Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SecondTutorial extends StatefulWidget {
  final int randomNum;

  SecondTutorial({required this.randomNum});

  @override
  _SecondTutorialState createState() => _SecondTutorialState();
}

class _SecondTutorialState extends State<SecondTutorial> {
  late List<dynamic> widgets;
  String expression = '';
  double difference = 0;

  @override
  void initState() {
    super.initState();
    widgets = _generateRandomExpression();
    _updateExpression();
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  List<dynamic> _generateRandomExpression() {
    final
 random = Random();
    
    double difference = 0;

    final numbers = List.generate(
        5, (index) => random.nextInt(10)); // 0 ile 9 arasında rastgele sayılar
    final operators = ['+', '-', '*', '/'];

    final result = <dynamic>[];
    for (var i = 0; i < numbers.length; i++) {
      result.add(numbers[i]);
      if (i < operators.length) {
        result.add(operators[i]);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    int randomNumInSecondTutorial = widget.randomNum;

    int flag = 0;
    for (int i = 0; i < expression.length - 2; i = i + 2) {
      if (!isNumeric(expression[0])) {
        flag = 1;
        break;
      }
      if (isNumeric(expression[i]) && isNumeric(expression[i + 2])) {
        flag = 1;
        break;
      }
      if (expression[i + 2] == '0' && expression[i] == '/') {
        flag = 1;
        break;
      }
    }

    if (flag == 1) {
      print("dizilim hatalı");
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Container(
              height: 100,
              child: Center(
                child: ReorderableListView(
                  scrollDirection: Axis.horizontal,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      _reorderList(oldIndex, newIndex);
                      _updateExpression();
                    });
                  },
                  children: widgets
                      .asMap()
                      .map(
                        (index, item) => MapEntry(
                      index,
                      _buildItem(index, item),
                    ),
                  )
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: flag == 1 ? null : _calculateExpression,
            style: ElevatedButton.styleFrom(
              primary: Colors.black, // Arkaplan rengi
              onPrimary: Colors.white, // Metin rengi
            ),
            child: Text('Calculate'),
          ),
          Text('Result: $expression'),
          Text('Target Number: $randomNumInSecondTutorial'),
        ],
      ),
    );
  }

  Widget _buildItem(int index, dynamic item) {
    return Container(
      key: ValueKey('$item-$index'),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: item is int ? BoxShape.rectangle : BoxShape.circle,
        gradient: item is int
            ? LinearGradient(
          colors: [Color(0xFFC70039), Color(0xFF900C3F)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
            : LinearGradient(
          colors: [Color(0xFFFF5733), Color(0xFF511845)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      margin: EdgeInsets.all(4.0),
      child: Center(
        child: Text(
          item is int ? item.toString() : item,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }

  void _reorderList(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final dynamic item = widgets.removeAt(oldIndex);
    widgets.insert(newIndex, item);
  }

  void _updateExpression() {
    expression = widgets.map((item) => item.toString()).join(' ');
  }

  void _calculateExpression() {
    try {
      final result = evaluateExpression();
      double difference = (widget.randomNum - result).abs();
      int points = calculatePoints(difference);

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('You are this close to the target: $difference'),
                Text('Your Points: $points'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Bottom Sheet'i kapat
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        expression = result.toString();
        difference = difference;
      });
    } catch (e) {
      print('Hesaplama hatası: $e');
    }
  }

  int calculatePoints(double difference) {
    if (difference > 2) {
      return 0;
    } else if (difference <= 2 && difference > 1) {
      return 1;
    } else if (difference <= 1 && difference > 0.5) {
      return 3;
    } else if (difference <= 0.5 && difference > 0.2) {
      return 4;
    } else if (difference <= 0.2 && difference > 0) {
      return 6;
    } else {
      return 10;
    }
  }

  double evaluateExpression() {
    final numbers = <double>[];
    final operators = <String>[];

    for (var item in widgets) {
      if (item is int) {
        numbers.add(item.toDouble());
      } else if (item is String) {
        operators.add(item);
      }
    }

    double result = numbers[0];

    for (var i = 0; i < operators.length; i++) {
      final operator = operators[i];
      final number = numbers[i + 1];

      if (operator == '+') {
        result += number;
      } else if (operator == '-') {
        result -= number;
      } else if (operator == '*') {
        result *= number;
      } else if (operator == '/') {
        result /= number;
      }
    }

    return result;
  }
}
