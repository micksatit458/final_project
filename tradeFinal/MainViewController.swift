//
//  MainViewController.swift
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

class MainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    var productList:Dictionary = [String:[String:Any]]()
    var productName:Array = [String]()
    var num:Int = 0
//    var userReal: Dictionary = [String:[String:Any]]
    
    @IBOutlet weak var clv1: UICollectionView!
     @IBOutlet weak var loginInfoLabel: UILabel!
    
    
    let myRefreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Wait a second", comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let storageRef = storage.reference().child(productList[productName[indexPath.row]]!["pdImg"] as! String)
        
        let downloadTask = storageRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
            if let error = error {
                print("Download Error!\(error)")
            } else {
                let image = UIImage(data: data!)
                cell.productImage.image = image
            }
        }
        
        cell.productName.text = productList[productName[indexPath.row]]!["name"] as! String
//        cell.lbFname.text = userList[userName[indexPath.row]]!["C_Fname"] as! String
//         cell.index = indexPath
//        cell.delegate = self
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = clv1.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
        print("index path of read: \(indexPath.row)")
             print(self.productList[self.productName[indexPath.row]])
             
             self.num = indexPath.row
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //        let mvc = self.storyboard?.instantiateViewController(identifier: "detailView") as! detailVC
            
            let mvc = self.storyboard?.instantiateViewController(identifier: "detailView") as! detailViewController
            mvc.productList = self.productList
            mvc.productName = self.productName
            mvc.num = self.num
            
            if self.productList.count > 0 {
               self.view.window?.rootViewController = mvc
           }
            
        }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = clv1.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
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
//            self.recollec()
            self.clv1.reloadData()
            print("reload")
            }
        }
    }
    

    @IBAction func btnPorifle(_ sender: Any) {
    }
    
    @IBAction func btnChat(_ sender: Any) {
    }
    
    @IBAction func btnHome(_ sender: Any) {
    }
    
    
    @IBAction func btnAdd(_ sender: Any) {
        let mvc = storyboard?.instantiateViewController(identifier: "addView")as? addViewController
                self.view.window?.rootViewController = mvc
    }
    
    @IBAction func btnNoti(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.loginInfoLabel.text = "Hello | " + (Auth.auth().currentUser?.email)!
//            clv1.reloadData()
//            readData()
        }
        else {
            self.loginInfoLabel.text = "Please Login"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clv1.refreshControl = myRefreshControl
        clv1.delegate = self
        clv1.dataSource = self
        print(self.productList)
        var layout = self.clv1.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.clv1.frame.size.width - 20)/2, height: self.clv1.frame.size.height/3)
        readData()
        clv1.reloadData()

        // Do any additional setup after loading the view.
    }
    
//    func createAlert (title:String, message:String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func refresh(sender: UIRefreshControl) {
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
            
            print("reload")
            }
        }
        let str = "This is \(self.productName.count) line"
        self.productName.append(str)
        sender.endRefreshing()
        clv1.reloadData()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                             let vc = self.storyboard?.instantiateViewController(identifier: "MainView") as! MainViewController
                                                 self.view.window?.rootViewController = vc
    }

}

