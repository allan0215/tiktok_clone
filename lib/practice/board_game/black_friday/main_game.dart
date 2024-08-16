// game variables
import 'dart:math';

enum Stock { blue, green, white, purple, yellow, black }

const List<int> goldPrice = [
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  35,
  40,
  45,
  50,
  55,
  60,
  65,
  70,
  75,
  80,
  85,
  90,
  95,
  100
];

// TODO : 주식 주머니 만들기

class GameBoard {
  static const Map<int, List<int>> stockPrices = {
    1: [4, 5, 6, 8, 10, 12, 15],
    2: [6, 8, 10, 12, 15, 20, 25],
    3: [10, 12, 15, 20, 25, 30, 35],
    4: [15, 20, 25, 30, 35, 40, 45],
    5: [25, 30, 35, 40, 45, 50, 60],
    6: [35, 40, 45, 50, 60, 65, 75],
    7: [45, 50, 60, 65, 75, 85, 90],
    8: [60, 70, 75, 85, 90, 100, 110],
    9: [75, 85, 95, 100, 110, 12, 130],
    10: [95, 105, 115, 125, 135, 145, 155],
    11: [115, 125, 135, 145, 160, 170, 180],
    12: [135, 150, 160, 170, 180, 200, 210],
    13: [150, 175, 190, 200, 210, 225, 240]
  };
}

typedef StockMap = Map<Stock, int>;

extension StockMapExtension on StockMap {
  List<Stock> selectRandom({required int amount, required int black}) {
    List<Stock> stockList = List.generate(black, (index) => Stock.black);
    List<Stock> result = [];
    int totalAmount = 0;
    forEach((key, value) {
      totalAmount += value;
      stockList.addAll(List.generate(value, (index) => key));
    });
    if (amount > totalAmount) {
      throw "Random select amount must be smaller than total amount";
    }
    for (int i = amount; i == 0; i--) {
      int randomPick = Random().nextInt(stockList.length);
      result.add(stockList[randomPick]);
      stockList.removeAt(randomPick);
    }
    return result;
  }
}

//

//
class GameSettings {
  final int players;

  GameSettings._internal({required this.players});

  factory GameSettings({required int players}) {
    return GameSettings._internal(players: players);
  }
}

class Player {
  Player({required this.stocks, required this.coins, required this.gold});

  int coins;
  StockMap stocks;
  int gold;
}

class StockPrice {
  int rowNum = 1;
  int columnNum = 4;

  StockPrice();
  StockPrice.most() : columnNum = 5;
  StockPrice.least() : columnNum = 3;
  StockPrice._manual({required this.rowNum, required this.columnNum});

  int get price {
    var x = GameBoard.stockPrices[rowNum];
    return x![columnNum];
  }

// 오퍼레이터와 메서드 중 뭐가 더 나은지 고민해보기
  StockPrice operator +(int a) {
    if (columnNum + a > 6) {
      return StockPrice._manual(rowNum: rowNum + 1, columnNum: columnNum);
    }
    return StockPrice._manual(rowNum: rowNum, columnNum: columnNum + a);
  }

  StockPrice operator -(int a) {
    if (columnNum + a < 0) {
      return StockPrice._manual(rowNum: rowNum - 1, columnNum: columnNum);
    }
    return StockPrice._manual(rowNum: rowNum, columnNum: columnNum + a);
  }
}

class StockPocket {
  int blackStock = 0;

  final StockMap _inPocket = {
    Stock.green: 14,
    Stock.blue: 14,
    Stock.yellow: 14,
    Stock.white: 14,
    Stock.purple: 14
  };

  final StockMap _buyable = {
    Stock.green: 5,
    Stock.blue: 5,
    Stock.yellow: 5,
    Stock.white: 5,
    Stock.purple: 5
  };

  final StockMap sellingBoard1 = {
    Stock.green: 2,
    Stock.blue: 2,
    Stock.yellow: 2,
    Stock.white: 2,
    Stock.purple: 2
  };
  final StockMap sellingBoard2 = {
    Stock.green: 2,
    Stock.blue: 2,
    Stock.yellow: 2,
    Stock.white: 2,
    Stock.purple: 2
  };
  final StockMap sellingBoard3 = {
    Stock.green: 2,
    Stock.blue: 2,
    Stock.yellow: 2,
    Stock.white: 2,
    Stock.purple: 2
  };

  StockPocket._internal();
  factory StockPocket() => StockPocket._internal();

  void initGame() {
    List<Stock> selected = _inPocket.selectRandom(amount: 10, black: 0);
    for (var element in selected) {
      _inPocket[element] = _inPocket[element]! - 1;
      _buyable[element] = _buyable[element]! + 1;
    }
  }

  StockMap get inPocket => _inPocket;
  StockMap get buyable => _buyable;
}

// current game

/* class CurrentStock {
  StockPrice price;
  int buyable;
}

class CurrentGame {
  final Player playerA, playerB, playerC, playerD;
  StockPrice green, blue, yellow, whit, purple;
} */


// 게임 절차

// init game

// 플레이어 행동
  // 1. 금 구매
    // 플레이어 보유 코인, 보유 금 수량 변경
    // 금 판매량 변경
    // buyable Stock >> onGoldBuy 로 이동
    // buyable Stock 수량 체크 >> 시세 변경 체크
    // onGoldBuy 수량 체크 >> 주가 변동 체크
  // 2. 주식 판매
    // 플레이어 보유 코인, 주식 수량 변경
    // sellingBoard >> buyable 이동
      // 판매한 주식과 같은 주식이 sellingBorad에 없을 경우 플레이어에게 선택 받는 절차 추가
    // 주식 시세 변동
    // sellingBoard 수량 체크 >> 주가 변동 체크
  // 3. 주식 구매
    //

// 주가 변동 (주가 변동 요인을 인자로 받아야 할 듯.)

// 금 시세 변동
  // 금 시세 체크 >> 100 도달시 dispose game