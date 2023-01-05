//
//  SecondViewController.swift
//  Right on target
//
//  Created by Илья Сутормин on 11.12.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var game: Game<SecretColorValue>!
    
    var correctButtonTag: Int = 0

    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var buttonColor1: UIButton!
    @IBOutlet weak var buttonColor2: UIButton!
    @IBOutlet weak var buttonColor3: UIButton!
    @IBOutlet weak var buttonColor4: UIButton!
    
    var buttonsCollections: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonsCollections = [buttonColor1, buttonColor2, buttonColor3, buttonColor4]
        updateScene()
    }
    
    private func updateScene() {
        let secretColorString = game.secretValue.value.getByHexString()
        updateSecretColorLabel(withText: secretColorString)
        updateButtons(withRightSecretValue: game.secretValue)
    }
    
    @IBAction func compareValue(sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
        game.calculateScore(secretValue: game.secretValue, userValue: userValue)
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        updateScene()
    }
    
    private func updateSecretColorLabel(withText newHEXColorText: String) {
        hexLabel.text = "#\(newHEXColorText)"
    }
    
    private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
        correctButtonTag = Array(1...4).randomElement()!
        buttonsCollections.forEach { button in
            if button.tag == correctButtonTag {
                button.backgroundColor = secretValue.value.getByUIColor()
            } else {
                var copySecretValueForButton = secretValue
                copySecretValueForButton.setRandomValue()
                button.backgroundColor = copySecretValueForButton.value.getByUIColor()
            }
        }
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена",
                                      message: "Вы заработали \(score) очков",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default))
        self.present(alert, animated: true)
    }
}
