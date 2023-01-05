//
//  SecretValue.swift
//  Right on target
//
//  Created by Илья Сутормин on 05.01.2023.
//

import Foundation

//алиас типа секретного значения
typealias SecretNumericValue = SecretValue<Int>
//алиас типа для секретного цветового значения
//для определения значения используется кастомный тип Color
typealias SecretColorValue = SecretValue<Color>

//Протокол, на основе которого будет создан тип, описывающий сущность "Секретное значение"
protocol SecretValueProtocol {
    //ассоциированный тип, который будет определять тип данных значения
    associatedtype ValueType
    //само загаданное значение
    var value: ValueType { get }
    //изменяет текущее значение на слуяайное значение
    mutating func setRandomValue()
}

struct SecretValue<T: Equatable>: SecretValueProtocol {
    typealias ValueType = T
    var value: T
    //замыкание для выбора случайного значения
    private let randomValueClosure: (T) -> T
    init(initialValue: T, randomValueClosure: @escaping (T) -> T) {
        value = initialValue
        self.randomValueClosure = randomValueClosure
    }
    mutating func setRandomValue() {
        self.value = randomValueClosure(self.value)
    }
}
