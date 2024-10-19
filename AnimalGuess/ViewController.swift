//
//  ViewController.swift
//  AnimalGuess
//
//  Created by Cesar Colato on 9/28/23.
//

// Importing the necessary module for UI elements.
import UIKit

// Main ViewController class for the AnimalGuess game.
class ViewController: UIViewController {
    
    // MARK: - UI Outlets
    
    // Image view to display the random animal image.
    @IBOutlet weak var animalImageView: UIImageView!
    // Label to display the question to the user.
    @IBOutlet weak var questionLabel: UILabel!
    // Label to display the current score.
    @IBOutlet weak var scoreLabel: UILabel!
    // Button to start the game.
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Properties
    
    // Array containing the names of the animals.
    let animals = ["bird", "cat", "alligator", "dog", "giraffe"]
    // Array containing the animal images.
    let animalImages: [UIImage] = [
        UIImage(named: "1.png")!,
        UIImage(named: "2.png")!,
        UIImage(named: "3.png")!,
        UIImage(named: "4.png")!,
        UIImage(named: "5.png")!
    ]
    
    // Variable to hold the name of the current displayed animal.
    var currentAnimal = ""
    // Variable to hold the current score.
    var score = 0
    
    // MARK: - Lifecycle Methods
    
    // This method is called when the view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the background image of the main view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        
        // Initially showing the start button.
        startButton.isHidden = false
    }
    
    // MARK: - Game Logic
    
    // Action method to start the game.
    @IBAction func startGame() {
        // Hiding the start button.
        startButton.isHidden = true
        // Resetting the score to 0.
        score = 0
        // Updating the score label.
        scoreLabel.text = "Score: \(score)"
        // Asking the first question.
        askQuestion()
    }
    
    // Method to generate a random question.
    func askQuestion() {
        // Getting a random index for selecting an animal.
        let randomIndex = Int.random(in: 0..<animals.count)
        
        // 50% chance to match the name with the image.
        if Bool.random() {
            currentAnimal = animals[randomIndex]
        } else {
            // Selecting a different animal name.
            currentAnimal = animals.filter { $0 != animals[randomIndex] }.randomElement() ?? ""
        }
        
        // Displaying the animal image.
        animalImageView.image = animalImages[randomIndex]
        // Displaying the question.
        questionLabel.text = "Is this a \(currentAnimal)?"
    }
    
    // Action method called when the "Yes" or "No" button is tapped.
    @IBAction func answerTapped(_ sender: UIButton) {
        // Checking if the "Yes" button was tapped.
        if let answer = sender.titleLabel?.text, answer == "Yes" {
            // Checking if the displayed image matches the asked animal name.
            let currentIndex = animals.firstIndex(of: currentAnimal) ?? -1
            if currentIndex >= 0 && animalImageView.image == animalImages[currentIndex] {
                // Incrementing the score.
                score += 1
                // Updating the score label.
                scoreLabel.text = "Score: \(score)"
                
                // Checking if the game is over.
                if score == 10 {
                    gameOver()
                    return
                }
            }
        }
        // Asking the next question.
        askQuestion()
    }
    
    // Method to handle the end of the game.
    func gameOver() {
        // Showing the start button for restarting the game.
        startButton.isHidden = false
        // Displaying the final score.
        questionLabel.text = "Game Over! Your score is \(score)."
    }
}
