import UIKit
import SwiftUI
import Firebase
import FirebaseDatabase

class CustViewController: UIViewController {
    @IBOutlet weak var itemlabel: UILabel!
    @IBOutlet weak var myimage: UIImageView!
    var mytext: String?
    var myitem: String!
    var tinydb : TinyDB!;
    var cnt : Int = 0
    var mydesc : String!
    var mypric : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tinydb = TinyDB();
        let ref: DatabaseReference = Database.database().reference();
        itemlabel.text = "Hello"
    }
}
