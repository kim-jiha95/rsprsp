//
//  UserInput.swift
//  rpsrps
//
//  Created by 한상진 on 10/5/23.
//

import Foundation

/// 유저 입력에 대한 인터페이스를 정의한다.
protocol UserInputReceivable {
    func receiveUsersNumber(
        with guideMessage: String,
        terminator: String,
        numberRange: ClosedRange<Int>
    ) throws -> Int
}

/// 콘솔에서 유저의 입력값을 받아 
/// 검증하고,
/// 입력값을 return해주는 아이 
struct UserInputReceiver: UserInputReceivable {
    enum Constant {
        static let rspWithExit: String = "가위(1), 바위(2), 보(3), 종료(0) : "
        static let rspWithoutExit: String = "가위(1), 바위(2), 보(3) 선택: "
        static let mcb: String = "묵(1), 찌(2), 빠(3) 선택: "
    }
    
    enum InputError: Error {
        case invalid
    }
    
    func receiveUsersNumber(
        with guideMessage: String = Constant.rspWithoutExit,
        terminator: String = " ",
        numberRange: ClosedRange<Int> = 1...3
    ) throws -> Int {
        print(guideMessage, terminator: terminator)
        guard
            let input: String = readLine(),
            let userInput = Int(input),
            numberRange ~= userInput
        else {
            throw InputError.invalid
        }
        return userInput
    }
}
