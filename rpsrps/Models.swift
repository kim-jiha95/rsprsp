//
//  Models.swift
//  rpsrps
//
//  Created by 한상진 on 10/5/23.
//

import Foundation

enum RockScissorsPaper: Int, CaseIterable {
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
    
    static var computersRandomValue: Self {
        return Self.allCases.randomElement() ?? .rock // Self.allCases == [RockScissorsPaper], [.rock, .scissors, .paper]
    } 
}

enum GameResult: CustomStringConvertible {
    enum InitError: Error {
        case fail
    }
    
    case win
    case draw
    case lose
    
    init(users: RockScissorsPaper, computer: RockScissorsPaper) throws {
        if (users == .rock && computer == .scissors) || (users == .scissors && computer == .paper) || (users == .paper && computer == .rock) {
            self = .win
        } else if (users == .rock && computer == .paper) || (users == .scissors && computer == .rock) || (users == .paper && computer == .scissors) {
            self = .lose
        } else if (users == .rock && computer == .rock) || (users == .scissors && computer == .scissors) || (users == .paper && computer == .paper) {
            self = .draw
        } else {
            throw InitError.fail
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
