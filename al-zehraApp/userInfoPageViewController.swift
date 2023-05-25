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
    let ref = Database.database().reference()
    
    var userDetail = [userDetails]()
    var user = ["Address", "Email", "Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromDB()

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
            //self.userInfoList.reloadData()
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
        let cell = userInfoList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! userDetailsListTableViewCell
        self.userInfoList.separatorStyle = .none
        cell.selectionStyle = .none
//        let myDetails: userDetails
//        myDetails = userDetail[indexPath.row]
//        print(myDetails.email)
        
        
 
        cell.labelText?.text = user[indexPath.row]
        if indexPath.row == 0 {
            cell.subLabel.isHidden = true
        }
        if indexPath.row == 1 {
            cell.subLabel.isHidden = false
            cell.subLabel?.text = ""
        }
        if indexPath.row == 2 {
            cell.subLabel.isHidden = true
        }
        if indexPath.row == 3 {
            cell.subLabel.isHidden = true
        }


        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = userInfoList.cellForRow(at: indexPath)
        if indexPath.row == 0 {
            let adddressVC = self.storyboard?.instantiateViewController(withIdentifier: "userAddressViewController") as! userAddressViewController
            self.navigationController?.pushViewController(adddressVC, animated: true)
        }
        if indexPath.row == 1{
            let emailAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
            self.navigationController?.pushViewController(emailAddressVC, animated: true)
            
        }else{
            print("erorrrrrrrrr-2")
        }
    }
}
