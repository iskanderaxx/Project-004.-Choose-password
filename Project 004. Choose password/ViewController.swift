
import UIKit

class ViewController: UIViewController {
    
    // MARK: - State
    
    private var bruteForcingIsRunning = false
    
    private var backgroundIsBlack: Bool = false {
        didSet { self.view.backgroundColor = backgroundIsBlack ? .black : .white }
    }
    
    // MARK: - UI Elements & Oulets
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var generatePasswordButton: UIButton!
    @IBOutlet weak var changeBackgroundColorButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createRandomValueForPasswordWith(randomSymbols: Int) -> String {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        let alphabetUppercased = alphabet.uppercased()
        let numbers = "0123456789"
        let symbols = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
        let charactersForPassword = alphabet + alphabetUppercased + numbers + symbols
        
        let charactersCount = UInt32(charactersForPassword.count)
        var passwordString = String()
        
        for _ in 0 ..< randomSymbols {
            let anyNumber = Int(arc4random_uniform(charactersCount))
            let anyIndex = charactersForPassword.index(charactersForPassword.startIndex, offsetBy: anyNumber)
            let incrementedCharacter = charactersForPassword[anyIndex]
            passwordString += String(incrementedCharacter)
        }
        return passwordString
    }
    
    private func bruteForce(correctPassword: String) {
        var myPassword = String()
        let bruteForce = BruteForceMethod()
        let allowedCharactes: [String] = String().printable.map { String($0) }
        
        while myPassword != correctPassword && bruteForcingIsRunning {
            myPassword = bruteForce.generateBruteForce(myPassword, fromArray: allowedCharactes)
            
            DispatchQueue.main.async {
                self.passwordLabel.text = myPassword
            }
        }
        endBruteForce()
    }
    
    private func endBruteForce() {
        bruteForcingIsRunning = false
        
        DispatchQueue.main.async {
            self.passwordLabel.text = "Failed"
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.passwordTextField.isSecureTextEntry = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction func createNewPassword(_ sender: UIButton) {
        if bruteForcingIsRunning {
            bruteForcingIsRunning = false
            endBruteForce()
            return
        }
        
        let passwordSymbolsNumber: Int = 4
        let newPassword = createRandomValueForPasswordWith(randomSymbols: passwordSymbolsNumber)
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = newPassword
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        generatePasswordButton.setTitle("Stop", for: .normal)
        bruteForcingIsRunning = true
        
        DispatchQueue.global().async { [ weak self ] in
            self?.bruteForce(correctPassword: newPassword)
        }
    }

    @IBAction func changeBackgroundColor(_ sender: UIButton) {
        backgroundIsBlack.toggle()
        
        if bruteForcingIsRunning {
            bruteForcingIsRunning = false
            endBruteForce()
        }
    }
}

