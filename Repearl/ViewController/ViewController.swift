import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func rscreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Storyboard2", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController2")
        self.show(controller, sender: self)
    }
    @IBAction func customer(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CustStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CustViewController")
        self.show(controller, sender: self)
    }
}
