//
//  userInfoPageViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-23.
//

import UIKit
import Firebase
import FirebaseAuth

class userInfoPageViewController: UIViewController {
    
    
    @IBOutlet var userInfoList: UITableView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    let ref = Database.database().reference()
    
    var userDetail = [userDetails]()
    var user = ["Address", "Email", "Password", "Edit Name"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromDB()
        //self.checkUserName()
//
//        user.append(["User": "First Name", "Details":"Murtaza"])
//        user.append(["User": "Last Name", "Details": "Haider"])
//        user.append(["User": "Email", "Details": "murtaza@gmail.com"])
//        user.append(["User": "Phone", "Details": "4372568766"])
//        user.append(["User": "Password", "Details": "Aman@0726"])
        logout()
    }
    
    func getDataFromDB(){
        self.ref.child("userDetails").observe(.value, with: {(snapshot) in
            self.userDetail.removeAll()
            let currentUserID = Auth.auth().currentUser?.uid
            for snap in snapshot.children.allObjects as! [DataSnapshot]{
                let userKey = snap.key
                print("userThred : " + userKey)
                let mainDict = snap.value as? [String: AnyObject]
                let firstName = mainDict?["firstName"]
                let LastName = mainDict?["LastName"]
                let phone = mainDict?["phone"]
                let password = mainDict?["password"]
                let userUID = mainDict?["userUID"]
                let email = mainDict?["email"]
                let addressLine1 = mainDict?["addressLine1"]
                let addressLine2 = mainDict?["addressLine2"]
                let postalCode = mainDict?["postalCode"]
                let city = mainDict?["city"]
                let users = userDetails(firstName: firstName as! String, LastName: LastName as! String, phone: phone as! String, email: email as! String, password: password as! String, userUID: userUID as! String, addressLine1: addressLine1 as! String, addressLine2: addressLine2 as! String, postalCode: postalCode as! String, city: city as! String)
                self.userDetail.append(users)
                
                if currentUserID == userKey {
                    self.userName.text = (users.firstName + " " + users.LastName)
                }else{
                    print("nokkkkkkkkk")
                }
             }
            self.userInfoList.reloadData()
        })
    }
    
    func logout(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(log))
    }
    @objc func log(){
        let auth = Auth.auth()
        do{
            try auth.signOut()
            let userPageVC = self.storyboard?.instantiateViewController(withIdentifier: "userCheck") as!
            welcomePageViewController
            self.navigationController?.popViewController(animated: true)
            print("user is logged out successfully")
            
        }catch
        {
            print("Error in signOut")
        }
    }
}
extension userInfoPageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userInfoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user[indexPath.row]
        //cell.detailTextLabel?.text = user[indexPath.row]["Details"] as? String
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = userInfoList.cellForRow(at: indexPath)
        if cell?.textLabel?.text  == "Address" {
            let adddressVC = self.storyboard?.instantiateViewController(withIdentifier: "userAddressViewController") as! userAddressViewController
            self.navigationController?.pushViewController(adddressVC, animated: true)
        }
        if cell?.textLabel?.text == "Email" {
            print("error")
        }else{
            print("erorrrrrrrrr-2")
        }
    }
}
