//
//  Game.swift
//  Right on target
//
//  Created by Илья Сутормин on 03.01.2023.
//

import Foundation
protocol GameProtocol {
    associatedtype SecretType
    var score: Int { get }
    var secretValue: SecretType { get }
    //Проверяет закончена ли игра
    var isGameEnded: Bool { get }
    //Начинает новую игру и сразу стартуе первый раунд
    func restartGame()
    //Начинает новый раунд (обновляет загаданное число)
    func startNewRound()
    //Сравнивает переданное значение с загаданным и начисляет очки
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: SecretValueProtocol>: GameProtocol {
    typealias SecretType = T
    var score: Int = 0
    var secretValue: T
    private var currentRoundNumber: Int = 0
    private var roundsCount: Int!
    private var compareClosure: (T, T) -> Int
    var isGameEnded: Bool {
        if currentRoundNumber == roundsCount{
            return true
        } else {
            return false
        }
    }
    
    init(secretValue: T, rounds: Int, compareClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        roundsCount = rounds
        self.compareClosure = compareClosure
        startNewRound()
    }
    
    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRound()
    }
    
    func startNewRound() {
       currentRoundNumber += 1
        self.secretValue.setRandomValue()
    }
    
    func calculateScore(secretValue: T, userValue: T) {
        score = score + compareClosure(secretValue, userValue)
    }
    
}
