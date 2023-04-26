import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();

  String _resultText = "";

  void _calculateFibonacci(int n) {
    if (n > 0) {
      List<int> result = List.generate(n, (i) => 0);
      result[0] = result[1] = 1;

      for (int i = 2; i < n; i++) {
        result[i] = result[i - 1] + result[i - 2];
      }

      setState(() {
        _resultText = "El $n en la secuencia de Fibonacci es ${result[n - 1]}\n\nSecuencia completa: ${result.toString()}";
      });

      _showDialog(_resultText);

    } else {
      setState(() {
        _resultText = "No es un valor válido de N";
      });

      _showDialog(_resultText);
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Resultado"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fibonacci"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 52),
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Ingresa un número",
                ),
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 92),
            ElevatedButton(
              onPressed: () {
                String input = _textController.text;
                int number = int.tryParse(input) ?? 0;
                _calculateFibonacci(number);
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Resultado"),
                      content: Text(_resultText),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cerrar"),
                        ),
                      ],
                    ),
                );
              },
              child: Text("Enter"),
            ),
          ],
        ),
      ),
    );
  }
}
