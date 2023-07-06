//
//  userInfoListViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-04-23.
//

import UIKit
import Firebase
import FirebaseAuth

class userInfoListViewController: UIViewController {

    
    @IBOutlet var supportTable: UITableView!
    
    var supportList = ["User Profile", "Payment Method", "Order History","Location Services", "Country/Region", "Contact Us", "Help and Information", "Privacy Policy", "Setting", "Terms & Conditions"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Support"
        
    }
}

extension userInfoListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return supportList.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = supportTable.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath)
        cell.selectionStyle = .none
        self.supportTable.separatorStyle = .none
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = supportList[indexPath.section]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            checkCurrentUser()
        }
        else if indexPath.section == 1{
            let paymentMethod = self.storyboard?.instantiateViewController(withIdentifier: "paymentMethodViewController") as! paymentMethodViewController
            self.navigationController?.pushViewController(paymentMethod, animated: true)
        }
        else if indexPath.section == 2{
            let orderHistory = self.storyboard?.instantiateViewController(withIdentifier: "OrderHistoryViewController") as! OrderHistoryViewController
            self.navigationController?.pushViewController(orderHistory, animated: true)
        }
        else{
            let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "notReady") as! notReadyViewController
            self.navigationController?.pushViewController(homePageVC, animated: true)
        }
    }
    func checkCurrentUser(){
        if Auth.auth().currentUser?.uid != nil{
            Auth.auth().currentUser?.reload(completion: { (error) in
                if let error = error{
                    print("checkIfUserSignedIn \(error.localizedDescription)")
                }
                let userPageVC = self.storyboard?.instantiateViewController(withIdentifier: "userPage") as! userInfoPageViewController
                self.navigationController?.pushViewController(userPageVC, animated: true)
                let userID = (Auth.auth().currentUser?.uid) ?? ""
                print("Current user ID is : " + userID)
            })
        }else{
            let createNewUser = self.storyboard?.instantiateViewController(withIdentifier: "userCheck") as! welcomePageViewController
            self.navigationController?.pushViewController(createNewUser, animated: true)
        }
    }
}
