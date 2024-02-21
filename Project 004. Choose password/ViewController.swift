
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

