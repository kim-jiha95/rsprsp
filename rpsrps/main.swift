//
//  main.swift
//  rpsrps
//
//  Created by Jihaha kim on 2023/09/25.
//

import Foundation

// 묵찌빠

//유저의 입력값

//readLine을 종료하는 조건이 맞을때까지 계속 readLine을 보여줘야한다.
// 0: 게임 종료, 1: 가위, 2: 바위, 3: 보
// 유저가 게임을 종료할 때 까지 유저의 input을 받는다.
// 컴퓨터는 가위 바위 보를 random으로 낸다.
// 승리를 print한다.
// 유저가 게임 종료를 입력 시 입력과 출력을 멈춘다.

// 1. 유저의 입력을 여러 번 받는 로직 구현
// 2. 종료할 수 있는 로직을 구현
// 종료 값 0 이면 종료할 수 있는 로직 구현
// 3. 묵찌빠를 정의할 수 있는 타입
// 4. 유저의 입력값에 대하여 가위바위보를 판단할 수 있는 객체 구현 -> 쪼개서 역할 분리

//유저의 입력을 받기 전에 -> 가위 바위 보를 입력해주세요.
//비긴 경우에 -> 비겼습니다.
//이긴 경우에 -> 이겼습니다.
//진 경우에 -> 졌습니다.
//0~3이 입력값이 아닌 경우에 -> 잘못된 입력값입니다. -> ............묵찌빠까지 가능하면


// 가위 바위 보 게임 함수
//func playRockPaperScissors(userChoice: Int) -> String {
//    let computerChoice = Int.random(in: 1...3) // 1: 가위, 2: 바위, 3: 보
//
//    if userChoice < 1 || userChoice > 3 {
//        return "잘못된 입력값입니다."
//    }
//
//    if userChoice == computerChoice {
//        return "비겼습니다."
//    } else if (userChoice == 1 && computerChoice == 3) ||
//              (userChoice == 2 && computerChoice == 1) ||
//              (userChoice == 3 && computerChoice == 2) {
//        return "이겼습니다."
//    } else {
//        return "졌습니다."
//    }
//}
//
//print("가위(1), 바위(2), 보(3) 중 하나를 선택하세요. 종료하려면 0을 입력하세요.")
//
//
//while true {
//    if let input = readLine(), let choice = Int(input) {
//           if choice == 0 {
//               print("게임을 종료합니다.")
//               break
//           } else {
//               let result = playRockPaperScissors(userChoice: choice)
//               print(result)
//           }
//       } else {
//           print("잘못된 입력값입니다. 가위(1), 바위(2), 보(3) 중 하나를 선택하세요. 종료하려면 0을 입력하세요.")
//       }
    //}


//게임 결과
enum GameResult {
    case win
    case draw
    case lose
    case exit
    case retry
    case error
}

//가위바위보 입력
func startsRockScissorsPaper() {
    print("가위(1), 바위(2), 보(3), 종료(0) : ", terminator: " ")

    guard let input: String = readLine(), let users = Int(input) else {
        printResultScissorsRockPaper(result: .error)
        return
    }
    
    let computer = Int.random(in: 1...3)
    
    compareRockScissorsPaper(users: users, computer: computer)
}

//가위바위보 결과비교
func compareRockScissorsPaper(users: Int, computer: Int) {
    let compareResult: GameResult
    
    if (users == computer) {
        compareResult = .draw
    } else if ((users == 1 && computer == 3) || (users == 2 && computer == 1) || (users == 3 && computer == 2)) {
        compareResult = .win
    } else if ((users == 1 && computer == 2) || (users == 2 && computer == 3) || (users == 3 && computer == 1)) {
        compareResult = .lose
    } else if (users == 0) {
        compareResult = .exit
    } else {
        compareResult = .retry
    }
    printResultScissorsRockPaper(result: compareResult)
}

//가위바위보 결과출력
func printResultScissorsRockPaper(result: GameResult) {
    switch result {
    case .win:
        print("이겼습니다!")
        startRockScissorsPaper(gameResult: .win, turn: "사용자")
    case .lose:
        print("졌습니다!")
        startRockScissorsPaper(gameResult: .win, turn: "컴퓨터")
    case .draw:
        print("비겼습니다!")
        startsRockScissorsPaper()
    case .exit:
        print("게임 종료")
    case .retry:
        print("잘못된 입력입니다. 다시 시도해주세요")
        startsRockScissorsPaper()
    case .error:
        print("입력값이 잘못되어 게임을 종료합니다.")
    }
}

//묵찌빠 입력
func startRockScissorsPaper(gameResult: GameResult, turn: String) {
        print("[\(turn) 턴] 묵(1), 찌(2), 빠(3)!<종료 : 0> : ",terminator: " ")
        
        guard let input: String = readLine(), let users = Int(input) else {
        printResultScissorsRockPaper(result: .error)
            return
        }
        
        let computer = Int.random(in: 1...3)
        
        compareRockScissorsPaper(users: users, computer: computer, turn: turn)
}

//묵찌빠 결과비교
func compareRockScissorsPaper(users: Int, computer: Int, turn: String) {
    let compareResult: GameResult
    var nextTurn: String = turn
    
    if ((users == 1 && computer == 2) || (users == 2 && computer == 3) || (users == 3 && computer == 1)) {
        compareResult = .win
        nextTurn = "사용자"
    } else if ((users == 1 && computer == 3) || (users == 2 && computer == 1) || (users == 3 && computer == 2)) {
        compareResult = .lose
        nextTurn = "컴퓨터"
    } else if ((users == 1 && computer == 1) || (users == 2 && computer == 2) || (users == 3 && computer == 3)) {
        compareResult = .draw
    } else if (users == 0) {
        compareResult = .exit
    } else {
        compareResult = .retry
    }
    printResultRockScissorsPaper(game: compareResult, turn: nextTurn)
}

//묵찌빠 결과출력
func printResultRockScissorsPaper(game: GameResult, turn: String) {
    switch game {
    case .win:
        print("\(turn)의 턴입니다")
        startRockScissorsPaper(gameResult: .win, turn: "사용자")
    case .lose:
        print("\(turn)의 턴입니다")
        startRockScissorsPaper(gameResult: .lose, turn: "컴퓨터")
    case .draw:
        print("\(turn)의 승리!")
    case .exit:
        print("게임 종료")
    default:
        print("잘못된 입력입니다. 다시 시도해주세요")
        startRockScissorsPaper(gameResult: .lose, turn: "컴퓨터")
    }
}

//게임 호출
startsRockScissorsPaper()
