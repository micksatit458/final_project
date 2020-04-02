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
import GoogleSignIn

public var auth = Auth.auth()



class ViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
       
//            if let error = error {
//                print("\(error.localizedDescription)")
//            } else {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let mvc = storyboard.instantiateViewController(withIdentifier: "MainView") as! MainViewController
//                self.view.window?.rootViewController = mvc
////                self.present(mvc, animated: false, completion: nil)
//            }
        
//*************************************************//
        
//        if (error == nil) {
//           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                                         let mvc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
//
//          //                            mvc.productList = self.productList
//          //                            mvc.productName = self.productName
//          //
//          //                               if self.productList.count > 0 {
//                                                 self.view.window?.rootViewController = mvc
//        } else {
//          print("\(error.localizedDescription)")
//        }
//*************************************************//
        
        if let error = error {
        print(error.localizedDescription)
        return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
        if let error = error {
        print(error.localizedDescription)
        } else {
            print("Login Successful.")
           if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mvc = storyboard.instantiateViewController(withIdentifier: "MainView") as! MainViewController
            self.view.window?.rootViewController = mvc
//            self.present(mvc, animated: true, completion: nil)
           }
            
        //This is where you should add the functionality of successful login
        //i.e. dismissing this view or push the home view controller etc
            let user = Auth.auth().currentUser
                   if user?.uid == nil {
                   //Show Login Screen
                   }
                   else {
                   //Show content
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                      let mvc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
                                                      
                       //                            mvc.productList = self.productList
                       //                            mvc.productName = self.productName
                       //
                       //                               if self.productList.count > 0 {
                                                              self.view.window?.rootViewController = mvc
                   }
        }
    }
    }
    
    
       var productList:Dictionary = [String:[String:Any]]()
       var productName:Array = [String]()
       let db = Firestore.firestore()
       let storage = Storage.storage()
       var txtAlert:String=""
        
//       var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
    @IBAction func btnLogoutG(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.signOut()
            print("Sign Out")
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
               
               DispatchQueue.main.async {
                   print("main thread dispatch")
                   if self.txtUser.text != nil && self.txtPass != nil {
                       Auth.auth().signIn(withEmail: self.txtUser.text!, password: self.txtPass.text!) { (user,error) in
                           if error != nil {
                               print(error.debugDescription)
                            AlertView.instance.showAlert(title: "Error", message: "You are wrong Email or Password pls re-check again", alertType: .failure)
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
                             AlertView.instance.showAlert(title: "Success", message: "You are succesfully loged into the system.", alertType: .success)
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
//        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().uiDelegate = self
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

