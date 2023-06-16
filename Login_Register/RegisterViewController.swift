//
//  RegisterViewController.swift
//  Login_Register
//
//  Created by Mohanraj on 21/02/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var mobileNumberTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var signUpOuterView: UIView!
    @IBOutlet weak var signInOuterView: UIView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var loginDatas : [String] = []
    var storeData : Bool? = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        signInOuterView.addInnerShadow(onSide: UIView.innerShadowSide.bottomAndLeft, shadowColor: UIColor.lightGray, shadowSize: 10.0, shadowOpacity: 10.0)
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        
    }
    @IBAction func signUpAtn(_ sender: Any) {
        loginPageValidation()
        
    }
    func fetchValues() {
        loginDatas.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print("request",result)
            for data in result as! [NSManagedObject] {
                print("Data",data)
                loginDatas.append(data.value(forKey: "email") as! String)
                print("loginDatas",loginDatas)
                print("loginCount",loginDatas.count)
                print("Email",data.value(forKey: "email") as! String)
            }
            
        } catch {
            print("failed")
        }
    }
    func saveValues(firstName: String,lastName: String,email: String,Password: String,phone : String) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LoginData", in: managedContext)!
        let person = LoginData(entity: entity, insertInto: managedContext)
        person.firstName = firstName
        person.lastName = lastName
        person.email = email
        person.password = Password
        person.phone = phone
        
        do {
            try managedContext.save()
            let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            navigationController?.pushViewController(loginVc, animated: true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}


extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK:- UITextFieldValidation Methods
    func loginPageValidation() {
        //check valid email:
        if (firstNameTxtField.text?.isEmpty)! {
            displayErrorMessage(title: "Empty", message: "Please enter your FirstName", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Email")
            }])
        }
        else  if (lastNameTxtField.text?.isEmpty)! {
            displayErrorMessage(title: "Empty", message: "Please enter your LastName", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Password")
            }])
        }
        
        else  if (mobileNumberTxtField.text?.isEmpty)! {
            displayErrorMessage(title: "Empty", message: "Please enter your MobileNumber", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your MobileNumber")
            }])
        }
        else  if (mobileNumberTxtField.text?.isPhonenumberValid)! == false {
            displayErrorMessage(title: "Empty", message: "Please enter vaild MobileNumber", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your MobileNumber")
            }])
        }
        else  if (emailTxtField.text?.isEmpty)! {
            displayErrorMessage(title: "Empty", message: "Please enter your email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Password")
            }])
        }
        else  if (emailTxtField.text?.isValidEmail)! == false {
            displayErrorMessage(title: "Empty", message: "Please enter vaild email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Password")
            }])
        }
        else  if (passwordTxtField.text?.isEmpty)! {
            displayErrorMessage(title: "Empty", message: "Please enter your Password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Password")
            }])
        }
        else  if (passwordTxtField.text?.isPasswordValid)! == false {
            displayErrorMessage(title: "Empty", message: "Please enter valid Password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Password")
            }])
        }
        else {
            saveValues(firstName: firstNameTxtField.text ?? "", lastName: lastNameTxtField.text ?? "", email: emailTxtField.text ?? "", Password: passwordTxtField.text ?? "" , phone: mobileNumberTxtField.text ?? "")
            fetchValues()
        }
    }
}






