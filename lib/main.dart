import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('Elements'),
          ),
          body: const BodyContainer(),
        ),
      ),
    );
  }
}

class ScoreRow extends StatelessWidget {
  const ScoreRow({
    super.key,
    required this.playerScore,
    required this.computerScore,
  });

  final int playerScore;
  final int computerScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Player',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              Text(
                'Score: $playerScore',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Computer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              Text(
                'Score: $computerScore',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ComputerChoice extends StatelessWidget {
  const ComputerChoice({super.key, required this.message, required this.icon});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              icon,
              size: 160,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key, required this.onClicked});
  final ValueChanged<String> onClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ChoiceButton(
          buttonColor: const Color.fromARGB(255, 175, 81, 89),
          iconColor: const Color.fromARGB(255, 210, 157, 153),
          icon: const FaIcon(
            FontAwesomeIcons.fire,
            size: 40,
          ),
          choice: 'fire',
          onClicked: onClicked,
        ),
        ChoiceButton(
          buttonColor: const Color.fromARGB(255, 44, 128, 87),
          iconColor: const Color.fromARGB(255, 106, 172, 109),
          icon: const FaIcon(
            FontAwesomeIcons.leaf,
            size: 40,
          ),
          choice: 'grass',
          onClicked: onClicked,
        ),
        ChoiceButton(
          buttonColor: const Color.fromARGB(115, 4, 61, 110),
          iconColor: const Color.fromARGB(255, 151, 187, 217),
          icon: const FaIcon(
            FontAwesomeIcons.water,
            size: 40,
          ),
          choice: 'water',
          onClicked: onClicked,
        )
      ],
    );
  }
}

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.buttonColor,
    required this.choice,
    required this.onClicked,
  });

  final FaIcon icon;
  final Color iconColor;
  final Color buttonColor;
  final String choice;
  final ValueChanged<String> onClicked;

  void _handleClick() {
    onClicked(choice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: buttonColor,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 106, 107, 107),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(4.0, 4.0))
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        color: iconColor,
        onPressed: (() => _handleClick()),
        icon: icon,
      ),
    );
  }
}

class NavRow extends StatelessWidget {
  const NavRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 106, 107, 107),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  offset: Offset(3.0, 3.0))
            ],
          ),
          child: IconButton(
            onPressed: (() => Phoenix.rebirth(context)),
            icon: const FaIcon(FontAwesomeIcons.rotate),
            color: Colors.white,
            iconSize: 30,
          ),
        ),
      ],
    );
  }
}

class BodyContainer extends StatefulWidget {
  const BodyContainer({Key? key}) : super(key: key);

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  IconData _icon = FontAwesomeIcons.robot;
  String _message = 'Your move';
  String _playerChoice = '';
  String _computerChoice = '';
  int _playerScore = 0;
  int _computerScore = 0;

  void _changeMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  void _raisePlayerScore() {
    setState(() {
      _playerScore++;
    });
  }

  void _raiseComputerScore() {
    setState(() {
      _computerScore++;
    });
  }

  void _changeComputerChoice() {
    Random random = Random();
    int randomNumber = random.nextInt(3);
    String choice = '';
    IconData icon = FontAwesomeIcons.robot;
    switch (randomNumber) {
      case 0:
        choice = 'fire';
        icon = FontAwesomeIcons.fire;
        break;
      case 1:
        choice = 'grass';
        icon = FontAwesomeIcons.leaf;
        break;
      case 2:
        choice = 'water';
        icon = FontAwesomeIcons.water;
        break;
    }
    setState(() {
      _computerChoice = choice;
      _icon = icon;
    });
  }

  void _onClicked(String choice) {
    setState(() {
      _playerChoice = choice;
    });
    _changeComputerChoice();
    _getWinner();
  }

  void _getWinner() {
    if (_playerChoice == 'fire' && _computerChoice == 'grass') {
      _changeMessage('Player Wins');
      _raisePlayerScore();
    } else if (_computerChoice == 'fire' && _playerChoice == 'grass') {
      _changeMessage('Computer Wins');
      _raiseComputerScore();
    } else if (_playerChoice == 'grass' && _computerChoice == 'water') {
      _changeMessage('Player Wins');
      _raisePlayerScore();
    } else if (_computerChoice == 'grass' && _playerChoice == 'water') {
      _changeMessage('Computer Wins');
      _raiseComputerScore();
    } else if (_playerChoice == 'water' && _computerChoice == 'fire') {
      _changeMessage('Player Wins');
      _raisePlayerScore();
    } else if (_computerChoice == 'water' && _playerChoice == 'fire') {
      _changeMessage('Computer Wins');
      _raiseComputerScore();
    } else {
      _changeMessage('Draw');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 157, 189, 204),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ScoreRow(
              playerScore: _playerScore,
              computerScore: _computerScore,
            ),
          ),
          Expanded(
            flex: 6,
            child: ComputerChoice(icon: _icon, message: _message),
          ),
          Expanded(
            flex: 2,
            child: ButtonRow(
              onClicked: _onClicked,
            ),
          ),
          const Expanded(
            flex: 2,
            child: NavRow(),
          )
        ],
      ),
    );
  }
}
