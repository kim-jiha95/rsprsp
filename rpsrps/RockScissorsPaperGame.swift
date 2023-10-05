//
//  RockScissorsPaperGame.swift
//  rpsrps
//
//  Created by 한상진 on 10/5/23.
//

import Foundation

/// 유저의 입력값을 받는 기능
/// 가위바위보 로직을 수행해서 게임의 승패를 결정하는 로직
struct RockScissorsPaperGame {
    let userInputReceiver: UserInputReceiver = .init()
    
    /// 종료할 수 있는 인풋을 받아서
    /// 0이면 종료시키고,
    /// 아니면 인풋으로 가위바위보를 해서
    /// 결과를 프린트
    func start() {
        do {
            let userInput = try userInputReceiver.receiveUsersNumber(
                with: UserInputReceiver.Constant.rspWithExit, 
                numberRange: 0...3
            )
            
            guard userInput != .zero else { 
                print("게임이 종료되었습니다.")
                return
            }
            
            let gameResult = try getGameResult(with: userInput)
            
            print("당신이", gameResult.description)
        }
        catch {
            print(error)
        }
    }
    
    func getGameResult(with userInput: Int, and computer: Int = Int.random(in: 1...3)) throws -> GameResult {
        let rsp = try RockScissorsPaper(input: userInput)
        let computerRsp: RockScissorsPaper = try RockScissorsPaper(input: computer)
        let compareResult: GameResult = try .init(users: rsp, computer: computerRsp)
        return compareResult
    }
}
