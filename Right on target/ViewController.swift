//
//  ViewController.swift
//  Right on target
//
//  Created by Илья Сутормин on 24.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //Сущность "Игра"
    var game: Game<SecretNumericValue>!

    //Элементы на сцене
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    //MARK - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
       //Создаем экземпляр сущности "Игра"к
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        //Обновляем данные о текущем значении загаднного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
//    override func loadView() {
//        super.loadView()
//        //Создаем метку для вывода номера версии
//        let versionLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 20))
//        //Изменяем текст метки
//        versionLabel.text = "Версия 1.3"
//        //добавляем метку в родительский view
//        self.view.addSubview(versionLabel)
//    }
    
    @IBAction func button(_ sender: UIButton) {
        //Высчитываем очки за раунд
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        //Проверяем окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена",
                                      message: "Вы заработали \(score) очков",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default))
        self.present(alert, animated: true)
    }
    
}

