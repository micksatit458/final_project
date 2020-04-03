//
//  detailViewController.swift
//  tradeFinal
//
//  Created by Satit Nangnoi on 2/4/2563 BE.
//  Copyright © 2563 Satit Nangnoi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import LocalAuthentication

class detailViewController: UIViewController {
    
    
       let storage = Storage.storage()
       let db = Firestore.firestore()
       var productList:Dictionary = [String:[String:Any]]()
       var productName:Array = [String]()
       var num:Int = 0
    @IBOutlet weak var imgPic: UIImageView!
       @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtNumber: UILabel!
       @IBOutlet weak var txtDesc: UILabel!
       @IBOutlet weak var txtWant: UILabel!
       

   
    @IBAction func btnCancel(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
            self.view.window?.rootViewController = vc
    }
    
    @IBAction func btnTrade(_ sender: Any) {
                let context : LAContext = LAContext()
                if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
                    context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Message") { (good, error) in
                        if good {
                            print("Hello my friend")
                        }else{
                            print("Can't login")
                        }
                    }
        }
    }
    
     func readData(){
               self.db.collection("trade").getDocuments { (DocumentSnapshot, Error) in

               if Error == nil && DocumentSnapshot != nil {
                   self.productList.removeAll()
                   self.productName.removeAll()
                   
                   for document in DocumentSnapshot!.documents {

                       let data = document.data()
                       let name = data["name"] as! String
                       self.productList[name] = data
                       self.productName.append(name)
                                                   
                   }
    //               self.tbv1.reloadData()
    //                self.imgPic.reloadInputViews()
                   print("reload")
                   }
               }
           }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storageRef = storage.reference().child(productList[productName[num]]!["pdImg"] as! String)
            
            let downloadTask = storageRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Download Error!\(error)")
                } else {
                    let image = UIImage(data: data!)
                    self.imgPic.image = image
                }
            }
            
            self.txtName.text = productList[productName[num]]!["name"] as! String
            self.txtPrice.text = productList[productName[num]]!["price"] as! String
            self.txtNumber.text = productList[productName[num]]!["number"] as! String
            self.txtDesc.text = productList[productName[num]]!["desc"] as! String
            self.txtWant.text = productList[productName[num]]!["want"] as! String

            // Do any additional setup after loading the view.
        }
    

        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //super
}





