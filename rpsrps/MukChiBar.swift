//
//  File.swift
//  rpsrps
//
//  Created by 한상진 on 10/5/23.
//

import Foundation

struct MukChiBar {
    
    let receiver: UserInputReceiver = .init()
    let rsp: RockScissorsPaperGame = .init()

    // 길다 == 너무 함수의 역할이 많다.
    // 인덴트가 깊고 함수가 길면 -> 쪼개야한다.
    // 코드가 비슷하다 == 재사용을 고려해야한다. 
    // -> 함수(이 객체 안에서만 쓰일 때) or 프로토콜(여러 개의 struct에 적용할 수 있을 때) or 객체(특정한 로직을 수행할 수 있는 아이일때)
    
    /// 최초값을 입력받고
    /// 묵찌빠 로직을 비교해서
    /// 
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
                    let user = try receiver.receiveUsersNumber()
                    let computer = Int.random(in: 1...3)
                    let result = try rsp.getGameResult(with: user, and: computer)
                    print("사용자: \(user), 컴퓨터: \(computer)")
                    switch result {
                    case .win:
                        print("가위바위보에서 사용자가 이겼습니다!")
                        userHasLead = false
                    case .lose:
                        print("가위바위보에서 컴퓨터가 이겼습니다!")
                        userHasLead = false
                    case .draw:
                        print("가위바위보에서 비겼습니다.")
                    }
                }
                
                if !userHasLead {
                    let user = try receiver.receiveUsersNumber(with: UserInputReceiver.Constant.mcb)
                    let computer = Int.random(in: 1...3)
                    
                    let userMukChiBarChoice = try RockScissorsPaper(input: user)
                    let computerMukChiBarChoice = try RockScissorsPaper(input: computer)
                    
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
}
