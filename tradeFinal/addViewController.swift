//
//  addViewController.swift
//  tradeFinal
//
//  Created by Satit Nangnoi on 2/4/2563 BE.
//  Copyright © 2563 Satit Nangnoi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage


class addViewController: UIViewController {
    
      let db = Firestore.firestore()
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var txtWant: UITextField!
 
    
    let imagePicker = UIImagePickerController()
     @IBOutlet weak var img: UIImageView!
    
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
                      self.view.window?.rootViewController = vc
    }
    
    
    @IBAction func btnPost(_ sender: Any) {
         self.uploadImage(_image: self.img.image!){ url in
                        self.add(name: "\(self.txtName.text!)", price:"\(self.txtPrice.text!)", number:"\(self.txtNumber.text!)", desc:"\(self.txtDesc.text!)", want:"\(self.txtWant.text!)", ProfileURL: url!){ success in
                                  if success != nil {
                                      
                                      print("yeah yes")
                                    
                                      
                                  }
                              }
            
                              }
                
                    
                
        //            add(Fname: "\(txtFN.text!)", Lname:"\(txtLN.text!)", Nname:"\(txtNN.text!)", Age:"\(txtAG.text!)", Email:"\(txtEM.text!)", Photo:"\(txtPH.text!)")
                
                
                
        //             self.dismiss(animated: true, completion: nil)
        //        }
    }
    
    
    func add(name:String, price:String, number:String, desc:String, want:String, ProfileURL:URL, complesion: @escaping(_ url:URL?) ->()){
    //        db.collection("commuFriend").addDocument(data: <#T##[String : Any]#>)({
    //            Fname: Fname,
    //            country: "Japan"
    //        })
    //        var ref: DocumentReference? = nil
              self.db.collection("trade").document(name).setData([
                "name" : name ,
                "price" : price ,
                "number" : number,
                "desc" : desc,
                "want" : want,
                "pdImg" : "\(name).jpg",
                "ProfileURL" :  ProfileURL.absoluteString
                
            ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document successfully Add!")
//                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
//                    self.view.window?.rootViewController = vc
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                  let mvc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
                                     self.view.window?.rootViewController = mvc
                }
                AlertView.instance.showAlert(title: "Success", message: "Your product has been added", alertType: .success)
            }
        }
    
//    func createAlert (title:String, message:String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        createAlert(title: "Your product has been added!", message: "Congrats")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(addViewController.openGallery(tapGesture:)))
        img.isUserInteractionEnabled = true
        img.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
            self.setupImagePicker()
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

    extension addViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        func setupImagePicker(){
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.delegate = self
                imagePicker.isEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            img.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }

    extension addViewController{

    func uploadImage(_image:UIImage, completion: @escaping((_ url:URL?) ->())){
        let storageRef = Storage.storage().reference().child("\(txtName.text!).jpg")
        let imgData = img.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                print("success")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
            }
        }
    }

