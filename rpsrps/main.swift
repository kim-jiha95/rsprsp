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
//            print("유저 입력 값: ", userInput, "컴퓨터 입력 값 : ", computerInput)
            print("당신이", compareResult.description)
        }
        catch {
            print(error)
        }
    }
        
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

struct muk_chi_bar {
    enum InputError: Error {
        case invalid
    }
    
    func start() {
        var userHasLead = true
        var gameIsOver = false
        
        print("묵찌빠 게임을 시작합니다.")
        
        while true {
            do {
                if gameIsOver {
                    break
                }
                
                if userHasLead {
                    let userRSPInput = try receiveUserInputRSP()
                    let computerRSPInput = Int.random(in: 1...3)
                    
                    let userChoice = try RockScissorsPaper(input: userRSPInput)
                    let computerChoice = try RockScissorsPaper(input: computerRSPInput)
                    
                    print("사용자: \(userChoice), 컴퓨터: \(computerChoice)")
                    
                    if let rspResult = GameResult(users: userChoice, computer: computerChoice) {
                        if rspResult == .win {
                            print("가위바위보에서 사용자가 이겼습니다!")
                            userHasLead = false
                        } else if rspResult == .lose {
                            print("가위바위보에서 컴퓨터가 이겼습니다!")
                            userHasLead = false
                        } else {
                            print("가위바위보에서 비겼습니다.")
                        }
                    } else {
                        print("잘못된 입력입니다. 다시 시도하세요.")
                    }
                }
                
                if !userHasLead {
                    let userMukChiBarInput = try receiveUserInputMukChiBar()
                    let computerMukChiBarInput = Int.random(in: 1...3)
                    
                    let userMukChiBarChoice = try RockScissorsPaper(input: userMukChiBarInput)
                    let computerMukChiBarChoice = try RockScissorsPaper(input: computerMukChiBarInput)
                    
                    print("사용자: \(userMukChiBarChoice), 컴퓨터: \(computerMukChiBarChoice)")
                    
                    // 묵찌빠 이긴 조건
                    if userMukChiBarChoice == computerMukChiBarChoice {
                        print("묵찌빠에서 사용자가 이겼습니다!")
                        gameIsOver = true
                    } else {
                        print("다시 가위바위보를 진행합니다.")
                        userHasLead = true
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    func receiveUserInputRSP() throws -> Int {
        print("가위(1), 바위(2), 보(3) 선택: ", terminator: " ")
        guard
            let input: String = readLine(),
            let userInput = Int(input),
            [1, 2, 3].contains(userInput)
        else {
            throw InputError.invalid
        }
        return userInput
    }
    
    func receiveUserInputMukChiBar() throws -> Int {
        print("묵(1), 찌(2), 빠(3) 선택: ", terminator: " ")
        guard
            let input: String = readLine(),
            let userInput = Int(input),
            [1, 2, 3].contains(userInput)
        else {
            throw InputError.invalid
        }
        return userInput
    }
}

let mukChiBarGame = muk_chi_bar()
mukChiBarGame.start()



let game = RockScissorsPaperGame()
//game.start()


