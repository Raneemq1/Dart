import 'dart:io';

//Define global varibales that assigns game conditionals and the game board standard values
List<String> board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
int winner = 0;
bool finish = false;
String s1 = 'X', s2 = 'O';
var movements = 0;
var player = 0;
void main() {
  var num, input;

  var restart = 1; //This flag checks the stop of the game
  var valid = true; //This bbolean checks the validaity of board place

  while (restart == 1) {
    print('Write 1 to choose X\nWrite 2 to choose O\n');

    try {
      num = int.parse(stdin.readLineSync()!);
      //check the validaity of the entered player number
      if (num < 1 || num > 2) {
        valid = false;
      }
    } catch (e) {
      valid = false;
    }

    while (!valid) {
      print("Invalid input. Please enter a valid input.");
      try {
        num = int.parse(stdin.readLineSync()!);
        if (num == 1 || num == 2) {
          valid = true;
        }
      } catch (e) {}
    }

    //Let the user about the selected charcter
    if (num == 1) {
      print('You select X character\n');
    } else {
      print('You select O character\n');
      s1 = 'O';
      s2 = 'X';
    }

    ticTacToc(0, '');
    player = 0;

    //this loop repeates until the game stop
    while (finish == false) {
      print(
          'Player ${player + 1}: Choose one of the available places by putting the number');
      try {
        input = int.parse(stdin.readLineSync()!);
        valid = true;
      } catch (e) {
        valid = false;
      }

      //check the validaity of the entered position
      while (!valid ||
          input > 9 ||
          input < 1 ||
          board[input - 1] == 'X' ||
          board[input - 1] == 'O') {
        print('Please choose an available place only');
        try {
          input = int.parse(stdin.readLineSync()!);
          valid = true;
        } catch (e) {
          valid = false;
        }
      }
      movements++;
      //assign the player charcter to the selected position and give the role to the other player
      if (player == 0) {
        ticTacToc(input, s1);
        player = 1;
      } else {
        ticTacToc(input, s2);
        player = 0;
      }

      //start checking if anyone win to finish the game
      if (movements >= 5) {
        if (check() == true) {
          print('\n\nCongratulations');
          break;
        }
      }

      //if all board places are taken the game will finish
      if (movements == 9) {
        finish = true;
      }
    }

    //check the winner by comparing the global conditional
    if (winner == 1) {
      print('X winner');
    } else if (winner == 2) {
      print('O winner');
    } else {
      print('No one win');
    }
    print('Press 1 to restart the game');
    restart = int.parse(stdin.readLineSync()!);
    if (restart == 1) {
      clean();
    }
  }
}

//This methods uses to return every global variables to thier original values
void clean() {
  board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  winner = 0;
  finish = false;
  movements = 0;
  s1 = 'X';
  s2 = 'O';
}

//This method uses to put the charcter in the selected place and print the board game
void ticTacToc(int place, String s) {
  if (place != 0) {
    board[place - 1] = s;
  }

  for (int i = 0; i < 9; i++) {
    if ((i + 1) % 3 != 0) {
      stdout.write(" ${board[i]}" + " |");
    } else {
      print(' ${board[i]} \n');
    }
    if ((i + 1) % 3 == 0 && i != 8) {
      print('---+---+---\n');
    }
  }
}

bool check() {
  if (checkDiagonal() || checkHorizontal() || checkVerical()) {
    return true;
  } else {
    return false;
  }
}

//this method checks the vertical matches
bool checkVerical() {
  int count1 = 0, count2 = 0;
  for (int i = 0; i < 9; i++) {
    //to clean the counters every coloumn
    if (i % 3 == 0) {
      count1 = 0;
      count2 = 0;
    }
    if (board[(3 * i) % 9] == 'X') {
      count1++;
      count2 = 0;
    } else if (board[(3 * i) % 9] == 'O') {
      count2++;
      count1 = 0;
    } else {
      count1 = 0;
      count2 = 0;
    }

    if (count1 == 3 || count2 == 3) {
      break;
    }
  }
  //assign the winner number
  if (count1 == 3) {
    winner = 1;
  } else if (count2 == 3) {
    winner = 2;
  }
  if (count1 == 3 || count2 == 3) {
    return true;
  } else {
    return false;
  }
}

//this method checks the horizontal matches
bool checkHorizontal() {
  int count1 = 0, count2 = 0;
  for (int i = 0; i < 9; i++) {
    //to clean the counters every row
    if ((i + 1) % 3 == 1) {
      count1 = 0;
      count2 = 0;
    }
    if (board[i] == 'X') {
      count1++;
      count2 = 0;
    } else if (board[i] == 'O') {
      count2++;
      count1 = 0;
    } else {
      count1 = 0;
      count2 = 0;
    }
    if (count1 == 3 || count2 == 3) {
      break;
    }
  }
  if (count1 == 3) {
    winner = 1;
  } else if (count2 == 3) {
    winner = 2;
  }

  if (count1 == 3 || count2 == 3) {
    return true;
  } else {
    return false;
  }
}

//this method checks the diagonal matches
bool checkDiagonal() {
  if (board[0] == 'X' && board[4] == 'X' && board[8] == 'X' ||
      board[2] == 'X' && board[4] == 'X' && board[6] == 'X') {
    winner = 1;
    return true;
  } else if (board[0] == 'O' && board[4] == 'O' && board[8] == 'O' ||
      board[2] == 'O' && board[4] == 'O' && board[6] == 'O') {
    winner = 2;
    return true;
  } else {
    return false;
  }
}
