//
//  signupViewController.swift
//  tradeFinal
//
//  Created by Satit Nangnoi on 2/4/2563 BE.
//  Copyright © 2563 Satit Nangnoi. All rights reserved.
//

import UIKit
import Firebase

class signupViewController: UIViewController {
    
    @IBOutlet weak var txtUser: UITextField!
       @IBOutlet weak var txtPass: UITextField!
       
       @IBAction func btnSignup(_ sender: Any) {
           if txtUser.text != nil && txtPass != nil {
               Auth.auth().createUser(withEmail: txtUser.text!, password: txtPass.text!) {
                   (Result, Error) in
                   if Error != nil {
                       print(Error.debugDescription)
                   }
                   else {
                       print("Register Successfully")
                       self.dismiss(animated: true, completion: nil)
                   }
               }
           }
       }

       @IBAction func btnBack(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
