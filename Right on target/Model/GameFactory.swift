//
//  GameFactory.swift
//  Right on target
//
//  Created by Илья Сутормин on 05.01.2023.
//

import Foundation

final class GameFactory {
    
    static func getNumericGame() -> some GameProtocol {
        let minSecretValue = 1
        let maxSecretValue = 50
        let secretValue = SecretNumericValue(initialValue: 0) { _ in
            //замыкание для выбора случайного значения
            return Array(minSecretValue...maxSecretValue).randomElement()!
        }
        return Game<SecretNumericValue>(secretValue: secretValue, rounds: 5) {secretValue, userValue in
            var compareResult: Int!
            if secretValue.value == userValue.value {
                compareResult = maxSecretValue
            } else if secretValue.value > userValue.value {
                compareResult = maxSecretValue - (secretValue.value - userValue.value)
            } else if secretValue.value < userValue.value {
                compareResult = maxSecretValue - (userValue.value - secretValue.value)
            }
            return compareResult
        }
    }
    
    static func getColorGame() -> some GameProtocol {
        let initialSecretColor = Color()
        let secretValue = SecretColorValue(initialValue: initialSecretColor) { color in
            var updateColor = color
            updateColor.red = Array(0...255).randomElement()!
            updateColor.green = Array(0...255).randomElement()!
            updateColor.blue = Array(0...255).randomElement()!
            return updateColor
        }
        return Game<SecretColorValue>(secretValue: secretValue, rounds: 5) {secretValue, userValue in
            if secretValue.value ==  userValue.value {
                return 1
            } else {
                return 0
            }
        }
    }
}
