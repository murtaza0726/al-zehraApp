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
    
    @IBOutlet var endSession: UIButton!
    @IBOutlet var deleteAccount: UIButton!
    
    let ref = Database.database().reference()
    
    var userDetail = [userDetails]()
    var user = ["Address", "Email", "Password"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromDB()
        
        self.title = "User Profile"
        
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
//        let headerLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width, height: 40))
//        headerLabel.text = "User Profile"
//
//        header.addSubview(headerLabel)
//        headerLabel.adjustsFontSizeToFitWidth = true
//        headerLabel.font = .boldSystemFont(ofSize: 25)
//        userInfoList.tableHeaderView = header
        
        endSession.underline2()
        deleteAccount.underline2()
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        self.logoutUser()
    }
    
    
    func getDataFromDB(){
        let currentUserID = Auth.auth().currentUser?.uid
        self.ref.child("userDetails").child(currentUserID!).observe(.value, with: {(snapshot) in
            self.userDetail.removeAll()

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
                if userKey == "primaryDetails" {
                    self.userName.text = (users.firstName + " " + users.LastName)
                }else{
                    print("nokkkkkkkkk")
                }
            }
        })
    }
    
    func logoutUser(){
        let auth = Auth.auth()
        do{
            try auth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
            print("user is logged out successfully")
            NotificationCenter.default.post(name: .userLoggedOut, object: nil)
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
        
//        let myCategory6: userDetails
//        myCategory6 = userDetail[indexPath.row]
        
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
            
        }
        if indexPath.row == 2{
            let passwordAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordViewController") as! UpdatePasswordViewController
            self.navigationController?.pushViewController(passwordAddressVC, animated: true)
        }
    }
}

extension UIButton {
    func underline2() {
        let attributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.underlineStyle: 1,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
        ]
        guard let title2 = self.titleLabel else { return }
        guard let tittleText2 = title2.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText2), attributes: attributes)
        self.setAttributedTitle(NSAttributedString(attributedString: attributedString), for: .normal)
        
    }
}
