//
//  signUpViewController.swift
//  al-zehraApp
//
//  Created by Murtaza Haider Naqvi on 2023-03-16.
//

import UIKit
import Firebase
import FirebaseAuth

class signUpViewController: UIViewController {
    
    enum fieldError : Error {
        case invalidFirstName, invalidLastName, invalidPhone, invalidPassword, invalidEmail, invalidAddress1,  invalidAddress2,  invalidPostalCode,  invalidCity
    }

    //user input text field-1
    @IBOutlet var fNameText: UITextField!
    @IBOutlet var LastNameText: UITextField!
    @IBOutlet var phoneNumText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    
    //error message label
    @IBOutlet var invalidEmailMsg: UILabel!
    @IBOutlet var invalidPhoneNum: UILabel!
    @IBOutlet var invalidPassword: UILabel!
    @IBOutlet var invalidFirstName: UILabel!
    @IBOutlet var invalidLastName: UILabel!
    @IBOutlet var invalidAddressLineOne: UILabel!
    @IBOutlet var invalidAddressLineTwo: UILabel!
    @IBOutlet var invalidPostalCode: UILabel!
    @IBOutlet var invalidCity: UILabel!
    
    
    //user input text field-2
    @IBOutlet var addressLine1: UITextField!
    @IBOutlet var addressLine2: UITextField!
    @IBOutlet var postalCode: UITextField!
    @IBOutlet var city: UITextField!
    
    
    
    //database reference
    
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.invalidEmailMsg.isHidden = true
        self.invalidPassword.isHidden = true
        self.invalidPhoneNum.isHidden = true
        self.invalidLastName.isHidden = true
        self.invalidFirstName.isHidden = true
        self.invalidAddressLineOne.isHidden = true
        self.invalidAddressLineTwo.isHidden = true
        self.invalidPostalCode.isHidden = true
        self.invalidCity.isHidden = true
        
        self.fNameText.setUpUnderlineTextField4()
        self.LastNameText.setUpUnderlineTextField4()
        self.phoneNumText.setUpUnderlineTextField4()
        self.emailText.setUpUnderlineTextField4()
        self.passwordText.setUpUnderlineTextField4()
        self.addressLine1.setUpUnderlineTextField4()
        self.addressLine2.setUpUnderlineTextField4()
        self.postalCode.setUpUnderlineTextField4()
        self.city.setUpUnderlineTextField4()
        
        self.ref = Database.database().reference()
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        
        _ = (self.checkErrorFirstName(),
        self.checkErrorLastName(),
        self.checkErrorEmail(),
        self.checkErrorAddressOne(),
        self.checkErrorAddressTwo(),
        self.checkErrorPostalCode(),
        self.checkErrorPhoneNum(),
        self.checkErrorCity(),
        self.checkErrorPassword())
        
        self.checkall()
    }

    func checkall(){
        if self.checkErrorFirstName() &&
            self.checkErrorLastName() &&
            self.checkErrorEmail() &&
            self.checkErrorAddressOne() &&
            self.checkErrorAddressTwo() &&
            self.checkErrorPostalCode() &&
            self.checkErrorPhoneNum() &&
            self.checkErrorCity() &&
            self.checkErrorPassword()
            
        {
            self.createUserfunc()
        }
        else{
            print("NOK")
        }
    }
    
    //function to save user info to database
    
    func saveData(){
        let userID = Auth.auth().currentUser?.uid
        let dict = ["firstName":fNameText.text!,"LastName":LastNameText.text!, "phone":phoneNumText.text!, "email":emailText.text!, "password":passwordText.text!, "userUID": userID, "addressLine1": addressLine1.text!, "addressLine2": addressLine2.text!, "postalCode": postalCode.text!, "city": city.text!]
        
        self.ref.child("userDetails").child(userID!).child("primaryDetails").setValue(dict)
    }
    
    //function to ccreate user for login
    
    func createUserfunc(){
        print("start")
        Auth.auth().createUser(withEmail: emailText.text ?? "", password: passwordText.text ?? "") { firebaseResult, error in
            if let e = error {
                print(e.localizedDescription)
                print("not working")
                let error = e.localizedDescription
                if error == e.localizedDescription && error == "The email address is already in use by another account."{
                    
                    //action sheet
                    let actionSheet = UIAlertController(title: "User already exist", message: "The email address is already in use by another account", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(actionSheet, animated: true)
                }
                if error == e.localizedDescription && error == "The email address is badly formatted."{
                    
                    //action sheet
                    let actionSheet = UIAlertController(title: "Invalid Email", message: "The email address is badly formatted.", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(actionSheet, animated: true)
                }
                if error == e.localizedDescription && error == "The password must be 6 characters long or more."{
                    
                    //action sheet
                    let actionSheet = UIAlertController(title: "Invalid Password", message: "The password must be 6 characters long or more.", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(actionSheet, animated: true)
                }
            }else{
                //navigate to app home page
                self.saveData()
                let userID = Auth.auth().currentUser?.uid
                dump(Auth.auth().currentUser?.displayName)
                dump(userID)
                let homePageVC = self.storyboard?.instantiateViewController(withIdentifier: "userPage") as! userInfoPageViewController
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    //first name validation
    func firstNameEmpty() throws {
        if self.fNameText.text != ""{
            print(self.fNameText.text!)
            self.invalidFirstName.isHidden = true
        }
        else{
            self.invalidFirstName.isHidden = false
            self.invalidFirstName.textColor = UIColor.red
            //self.fNameText.placeholder = "Field can not be empty"
        
//            self.fNameText.attributedPlaceholder = NSAttributedString(string: fNameText.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            self.invalidFirstName.text = "Field can not be empty"
            throw fieldError.invalidFirstName
        }
    }
    func checkErrorFirstName() -> Bool{
        do{
            try self.firstNameEmpty()
            return true
        }
        catch fieldError.invalidFirstName{
            print("Empty First Name")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    //Last name validation
    func lastNameEmpty() throws {
        if self.LastNameText.text != ""{
            print(self.LastNameText.text!)
            self.invalidLastName.isHidden = true
        }
        else{
            self.invalidLastName.isHidden = false
            self.invalidLastName.textColor = UIColor.red
            self.invalidLastName.text = "Field can not be empty"
            throw fieldError.invalidLastName
        }
    }
    func checkErrorLastName() -> Bool{
        do{
            try self.lastNameEmpty()
            return true
        }
        catch fieldError.invalidLastName{
            print("Empty Last Name")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    func phoneNumEmpty() throws {
        if self.phoneNumText.text != ""{
            print(self.phoneNumText.text!)
            self.invalidPhoneNum.isHidden = true
        }
        else{
            self.invalidPhoneNum.isHidden = false
            self.invalidPhoneNum.textColor = UIColor.red
            self.invalidPhoneNum.text = "Field can not be empty"
            throw fieldError.invalidPhone
        }
    }
    func checkErrorPhoneNum() -> Bool{
        do{
            try self.phoneNumEmpty()
            return true
        }
        catch fieldError.invalidPhone{
            print("Empty Phone Number")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    //email validation
    func emailEmpty() throws {
        if (self.emailText.text != ""){
            print(self.emailText.text!)
            self.invalidEmailMsg.isHidden = true
        }
        else{
            self.invalidEmailMsg.isHidden = false
            self.invalidEmailMsg.textColor = UIColor.red
            self.invalidEmailMsg.text = "Field can not be empty"
            throw fieldError.invalidEmail
        }
    }
    func checkErrorEmail() -> Bool{
        do{
            try self.emailEmpty()
            return true
        }
        catch fieldError.invalidEmail{
            print("Empty email")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    //address line 1 validation
    func addressOneEmpty() throws{
        if (self.addressLine1.text != ""){
            print(self.addressLine1.text!)
            self.invalidAddressLineOne.isHidden = true
        }
        else{
            self.invalidAddressLineOne.isHidden = false
            self.invalidAddressLineOne.textColor = UIColor.red
            self.invalidAddressLineOne.text = "Field can not be empty"
            throw fieldError.invalidAddress1
        }
    }
    func checkErrorAddressOne() -> Bool{
        do{
            try self.addressOneEmpty()
            return true
        }
        catch fieldError.invalidAddress1{
            print("Empty address line 1")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    //address line 2 validation
    func addressTwoEmpty()throws{
        if (self.addressLine2.text != ""){
            print(self.addressLine2.text!)
            self.invalidAddressLineTwo.isHidden = true
        }
        else{
            self.invalidAddressLineTwo.isHidden = false
            self.invalidAddressLineTwo.textColor = UIColor.red
            self.invalidAddressLineTwo.text = "Field can not be empty"
            throw fieldError.invalidAddress2
        }
    }
    func checkErrorAddressTwo() -> Bool{
        do{
            try self.addressTwoEmpty()
            return true
        }
        catch fieldError.invalidAddress2{
            print("Empty address line 2")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
        
    }
    
    //postal code validation
    func postalEmpty() throws {
        if (self.postalCode.text != ""){
            print(self.postalCode.text!)
            self.invalidPostalCode.isHidden = true
        }
        else{
            self.invalidPostalCode.isHidden = false
            self.invalidPostalCode.textColor = UIColor.red
            self.invalidPostalCode.text = "Field can not be empty"
            throw fieldError.invalidPostalCode
        }
    }
    func checkErrorPostalCode() -> Bool{
        do{
            try self.postalEmpty()
            return true
        }
        catch fieldError.invalidPostalCode{
            print("Empty postal code")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    //city validation
    func cityEmpty()throws {
        if (self.city.text != ""){
            self.invalidCity.isHidden = true
        }
        else{
            self.invalidCity.isHidden = false
            self.invalidCity.textColor = UIColor.red
            self.invalidCity.text = "Field can not be empty"
            throw fieldError.invalidCity
        }
    }
    func checkErrorCity() -> Bool{
        do{
            try self.cityEmpty()
            return true
        }
        catch fieldError.invalidCity{
            print("Empty city")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    //password validation
    func passwordEmpty()throws {
        if (self.passwordText.text != ""){
            self.invalidPassword.isHidden = true
        }
        else{
            self.invalidPassword.isHidden = false
            self.invalidPassword.textColor = UIColor.red
            self.invalidPassword.text = "Field can not be empty"
            throw fieldError.invalidPassword
        }
    }
    func checkErrorPassword() -> Bool{
        do{
            try self.passwordEmpty()
            return true
        }
        catch fieldError.invalidPassword{
            print("Empty city")
            return false
        }
        catch{
            print("Unknown error")
            return false
        }
    }
    
    //function to validate password field
    func passValidate(){
        if (self.passwordText.text != "") && (passwordText?.text?.isValidPassword)!{
            print("your password is valid")
            self.invalidPassword.isHidden = true
        }
        else if passwordText.text == ""{
            self.invalidPassword.isHidden = false
            self.invalidPassword.textColor = UIColor.red
            self.invalidPassword.text = "Field can not be empty"
        }
        else{
            invalidPassword.isEnabled = true
            invalidPassword.text = "The password must be 6 characters long or more and must contain special cha"
            invalidPassword.textColor = UIColor.red
        }
    }
    
    func emailValidate(){
        if (self.emailText.text != "") && (emailText.text?.isValidEmail)!{
            print("your email is valid")
            self.invalidEmailMsg.isHidden = true
            
        }
        else if self.emailText.text == ""{
            self.invalidEmailMsg.isHidden = false
            invalidEmailMsg.isEnabled = true
            invalidEmailMsg.text = "Field can not be empty"
            invalidEmailMsg.textColor = UIColor.red
        }
        else{
            print("email is invalid")
            self.invalidEmailMsg.isHidden = false
            invalidEmailMsg.isEnabled = true
            invalidEmailMsg.text = "Please enter a valid email"
            invalidEmailMsg.textColor = UIColor.red
        }
    }
}

//extension Regex to validate password, email, phone number
extension String{
    var isValidEmail: Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    var isValidPhoneNumber: Bool{
        let phoneRegex = "[0-9]{10}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    var isValidPassword: Bool{
        let passRegex = "[A-Za-z0-9_@!#$%^&*_-]{8,}"
        let passTest = NSPredicate(format: "SELF MATCHES %@", passRegex)
        return passTest.evaluate(with: self)
    }
}
extension UIView{
    func setUpUnderlineTextField4(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width - 15, height: 0.5)
        bottomLayer.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(bottomLayer)
    }
}
