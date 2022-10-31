import UIKit
import Firebase
import FirebaseDatabase

class ViewController2: UIViewController {
    @IBOutlet weak var itemname: UITextField!
    @IBOutlet weak var itemdesc: UITextField!
    @IBOutlet weak var itemprice: UITextField!
    @IBOutlet weak var itemimage: UITextField!
    @IBOutlet weak var myimage: UIImageView!
    
    var cnt : Int = 0
    var item : FoodItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        item = FoodItem("rice")
    }
    @IBAction func pickimg(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    @IBAction func nextclicked(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    func uploadObjectToFirebase(){
        let ref: DatabaseReference = Database.database().reference();
        let myitem: FoodItem = FoodItem(itemname.text!);
        ref.child("Items").child(itemname.text!).setValue(myitem.toDictionary);
        ref.child("Items").child(itemname.text!).child("ItemDesc").setValue(itemdesc.text!);
        ref.child("Items").child(itemname.text!).child("ItemPrice").setValue(itemprice.text!);
    }
}
extension ViewController2:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            myimage.image = image
            //let myimg = "myimg" + cnt.codingKey.stringValue
            //let mypic = "mypic" + cnt.codingKey.stringValue
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
