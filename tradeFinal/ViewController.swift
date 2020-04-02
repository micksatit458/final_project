//
//  ViewController.swift
//  tradeFinal
//
//  Created by Satit Nangnoi on 2/4/2563 BE.
//  Copyright © 2563 Satit Nangnoi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import LocalAuthentication
import AVFoundation

public var auth = Auth.auth()

class ViewController: UIViewController {
    
       var productList:Dictionary = [String:[String:Any]]()
       var productName:Array = [String]()
       let db = Firestore.firestore()
       let storage = Storage.storage()
       var txtAlert:String=""
        
//       var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    @IBAction func btnLogin(_ sender: Any) {
               
               DispatchQueue.main.async {
                   print("main thread dispatch")
                   if self.txtUser.text != nil && self.txtPass != nil {
                       Auth.auth().signIn(withEmail: self.txtUser.text!, password: self.txtPass.text!) { (user,error) in
                           if error != nil {
                               print(error.debugDescription)
                           }
                           else {
                               print("Login Successfully")
                               
                               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                               let mvc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
                               
//                            mvc.productList = self.productList
//                            mvc.productName = self.productName
//                               
//                               if self.productList.count > 0 {
                                       self.view.window?.rootViewController = mvc
//                               }
//                               else {
//                                       self.btnLogin(self.btnLogin as Any)
//                                       print(self.productList)
//                               }
                           }
                       }
                   }
               }
           }
    
    
    
    @IBAction func btnSignup(_ sender: Any) {
        let storyBoad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyBoad.instantiateViewController(identifier: "signup") as! signupViewController
            
        self.present(svc, animated: true, completion: nil)
    }
    
        
    func readData(){
        db.collection("trade").getDocuments { (DocumentSnapshot, Error) in

        if Error == nil && DocumentSnapshot != nil {

            for document in DocumentSnapshot!.documents {

                let data = document.data()
                let name = data["name"] as! String
                    
                self.productList[name] = data
                self.productName.append(name)
                                        
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let context : LAContext = LAContext()
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
//            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Message") { (good, error) in
//                if good {
//                    print("Hello my friend")
//                }else{
//                    print("Can't login")
//                }
//            }
        }
//        let sound = Bundle.main.path(forResource: "sake", ofType: "mp3")
//        do{
//            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//        }
//        catch{
//            if audioPlayer.isPlaying==false{
//                audioPlayer.play()
//            }
////            audioPlayer.numberOfLoops = -1
//        }
//        audioPlayer.numberOfLoops = -1
//        audioPlayer.play()
//        readData()
//        // Do any additional setup after loading the view.
//    }


}

