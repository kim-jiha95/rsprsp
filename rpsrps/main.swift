//
//  main.swift
//  rock
//
//  Created by Jihaha kim on 2023/09/18.
//

import Foundation

//
//  main.swift
//  rpsrps
//
//  Created by Jihaha kim on 2023/09/25.
//

import Foundation

// 묵찌빠
// 가위바위보를 a, b가 해서 누가 이겼는지
// 묵찌빠 -> 이긴 사람, 지금 현재 뭘 내고 있는지 -> 가위바위보

//유저의 입력값
enum GameResult: CustomStringConvertible {
    case win
    case draw
    case lose
    
    init?(users: RockScissorsPaper, computer: RockScissorsPaper)  {
        if (users == .rock && computer == .scissors) || (users == .scissors && computer == .paper) || (users == .paper && computer == .rock) {
            self = .win
        } else if (users == .rock && computer == .paper) || (users == .scissors && computer == .rock) || (users == .paper && computer == .scissors) {
            self = .lose
        } else if (users == .rock && computer == .rock) || (users == .scissors && computer == .scissors) || (users == .paper && computer == .paper) {
            self = .draw
        } else {
            return nil
        }
    }
    
    var description: String {
        switch self {
        case .win: return "이겼습니다!"
        case .draw: return "졌습니다!"
        case .lose: return "비겼습니다!"
        }
    }
}

enum Turns: CustomStringConvertible {
    case user
    case computer
    
    var description: String {
        switch self {
        case .user: return "사용자"
        case .computer: return "컴퓨터"
        }
    }
}

// 묵찌빠 전체를 담당하는 객체
// 게임 시작, 끝, print
// 가위바위보를 하는 객체를 가지고 묵찌빠 진행
// 묵찌빠의 결과

// 가위바위보를 하는 객체
// 유저의 인풋, 컴퓨터의 인풋 -> 가위 바위 보의 결과

enum RockScissorsPaper: Int {
    
    enum InitError: Error {
        case fail
    }
    case rock = 1
    case scissors = 2
    case paper = 3

    
    init(input: Int) throws {
        if input == 1 {
            self = .rock
        } else if input == 2 {
            self = .scissors
        } else if input == 3 {
            self = .paper
        } else {
            throw InitError.fail
        }
    }
}

struct mukChiBar {}

struct RockScissorsPaperGame {
    enum InputError: Error {
        case invalid
    }
    
    func start() {
        do {
            let userInput = try receiveUserInput()
            let rsp = try RockScissorsPaper(input: userInput)
            
            let computerInput = Int.random(in: 1...3)
            let computerRsp = try RockScissorsPaper(input: computerInput)
            
            guard
                let compareResult: GameResult = .init(users: rsp, computer: computerRsp)
            else { return }
            print(compareResult.description)
        }
        catch {
            print(error)
        }
    }
    
    // func validateUserInput
    
    func receiveUserInput() throws -> Int {
        print("가위(1), 바위(2), 보(3), 종료(0) : ", terminator: " ")
        guard
            let input: String = readLine(),
            let userInput = Int(input),
            0...3 ~= userInput
        else {
            throw InputError.invalid
        }
        return userInput
    }
}
let game = RockScissorsPaperGame()
game.start()

/// 가위바위보 입력
//func startsRockScissorsPaper() {
//    print("가위(1), 바위(2), 보(3), 종료(0) : ", terminator: " ")
//
//    guard
//        let input: String = readLine(),
//        let users = Int(input)
//    else {
//        printScissorsRockPaperResult(with: .error)
//        return
//    }
//
//    let computer = Int.random(in: 1...3)
//
//    let compareResult: GameResult = .init(users: users, computer: computer)
////        printScissorsRockPaperResult(with: compareResult)
//}

////가위바위보 결과출력
//func printScissorsRockPaperResult(with result: GameResult) {
//    print(result.description)
//
//    switch result {
//    case .win:
//        startRockScissorsPaper(gameResult: .win, turn: .user)
//    case .lose:
//        startRockScissorsPaper(gameResult: .win, turn: .computer)
//    case .draw:
//        startsRockScissorsPaper()
//    case .retry:
//        startsRockScissorsPaper()
//    case .exit: return
//    case .error: return
//    }
//}
////묵찌빠 입력
//func startRockScissorsPaper(gameResult: GameResult, turn: Turns) {
//        print("[\(turn) 턴] 묵(1), 찌(2), 빠(3)!<종료 : 0> : ",terminator: " ")
//
//        guard let input: String = readLine(), let users = Int(input) else {
//        printScissorsRockPaperResult(with: .error)
//            return
//        }
//
//        let computer = Int.random(in: 1...3)
//
//        compareRockScissorsPaper(users: users, computer: computer, turn: turn)
//}
//
////묵찌빠 결과비교
//// divide and conquer
//// 잘게 나누고, 나눈 아이들을 결합해서 정복하는것
//func compareRockScissorsPaper(users: Int, computer: Int, turn: Turns) {
//    let compareResult: GameResult = .init(users: users, computer: computer)
//    let nextTurn: Turns = compareResult == .win ? .user : .computer
//    printResultRockScissorsPaper(game: compareResult, turn: nextTurn)
//}
//
////묵찌빠 결과출력
//func printResultRockScissorsPaper(game: GameResult, turn: Turns) {
//    switch game {
//    case .win:
//        print("\(turn)의 턴입니다")
//        startRockScissorsPaper(gameResult: .win, turn: .user)
//    case .lose:
//        print("\(turn)의 턴입니다")
//        startRockScissorsPaper(gameResult: .lose, turn: .computer)
//    case .draw:
//        print("\(turn)의 승리!")
//    case .exit:
//        print("게임 종료")
//    default:
//        print("잘못된 입력입니다. 다시 시도해주세요")
//        startRockScissorsPaper(gameResult: .lose, turn: .computer)
//    }
//}
//
//게임 호출
//startsRockScissorsPaper()

