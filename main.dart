import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HangmanGame()));

class HangmanGame extends StatefulWidget {
  @override
  _HangmanGameState createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  String? word;
  String displayWord = '';
  int attempts = 5;
  String message = '';

  void startGame(String input) {
    setState(() {
      word = input.toUpperCase();
      displayWord = '_' * word!.length;
      attempts = 5;
      message = '';
    });
  }

  void guessLetter(String letter) {
    if (word == null || attempts == 0 || displayWord == word) return;

    setState(() {
      if (word!.contains(letter)) {
        for (int i = 0; i < word!.length; i++) {
          if (word![i] == letter) {
            displayWord = displayWord.substring(0, i) +
                letter +
                displayWord.substring(i + 1);
          }
        }
      } else {
        attempts--;
      }

      if (displayWord == word) {
        message = 'You Win!';
      } else if (attempts == 0) {
        message = 'You Lose! The word was $word.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hangman')),
      body: Column(
        children: [
          if (word == null) TextField(onSubmitted: startGame),
          if (word != null) Text('Word: $displayWord'),
          if (word != null) Text('Attempts: $attempts'),
          if (word != null && message.isEmpty)
            TextField(
              onSubmitted: (input) {
                if (input.isNotEmpty) guessLetter(input.toUpperCase());
              },
            ),
          if (message.isNotEmpty) Text(message),
          if (message.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  word = null;
                  displayWord = '';
                  attempts = 5;
                  message = '';
                });
              },
              child: Text('Try Again'),
            ),
        ],
      ),
    );
  }
}
