
import UIKit

class ViewController: UIViewController {
    
    // MARK: - State
    
    private var bruteForcingIsRunning = false
    
    private var backgroundIsBlack: Bool = false {
        didSet { self.view.backgroundColor = backgroundIsBlack ? .black : .white }
    }
    
    // MARK: - UI Elements & Oulets
    
    @IBOutlet weak var generatedPasswordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var createPasswordButton: UIButton!
    @IBOutlet weak var changeColorButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createRandomValueForPasswordOf(symbolsNumber: Int) -> String {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        let alphabetUppercased = alphabet.uppercased()
        let numbers = "0123456789"
        let symbols = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
        let charactersForPassword = alphabet + alphabetUppercased + numbers + symbols
        
        let charactersCount = UInt32(charactersForPassword.count)
        var passwordString = String()
        
        for _ in 0 ..< symbolsNumber {
            let anyNumber = Int(arc4random_uniform(charactersCount))
            let anyIndex = charactersForPassword.index(charactersForPassword.startIndex, offsetBy: anyNumber)
            let incrementedCharacter = charactersForPassword[anyIndex]
            passwordString += String(incrementedCharacter)
        }
        return passwordString
    }
}

