//
//  ViewController.swift
//  Login_Register
//
//  Created by Mohanraj on 20/02/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var SignInLbl: UIButton!
    @IBOutlet weak var signUpLbl: UIButton!
    
    @IBOutlet weak var signUpOuterView: UIView!
    @IBOutlet weak var signInOuterView: UIView!
    @IBOutlet weak var TotalOuterViewLbl: UIView!
    
    @IBOutlet weak var faceBookLblView: UIView!
    @IBOutlet weak var googleLblView: UIView!
    @IBOutlet weak var emailLblView: UIView!
    @IBOutlet weak var passwordLblView: UIView!
    
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var shadowLayer: CAShapeLayer!
    var RegList : [NSManagedObject] = []
    var details2 = String()
    var userName = [String]()
    var passwords = [String]()
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        signUpOuterView.addInnerShadow(onSide: UIView.innerShadowSide.bottomAndLeft, shadowColor: UIColor.lightGray, shadowSize: 10.0, shadowOpacity: 10.0)
    }
    @IBAction func signAc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginAtn(_ sender: Any) {
        
        if emailTxtField.text == "" {
            loginPageValidation()
        } else {
            fetchValues(email: emailTxtField.text ?? "", password: passwordTxtField.text ?? "")
            print("asif",fetchValues)
        }
    }
    
    func fetchValues(email: String, password : String) {
        userName.removeAll()
        passwords.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginData")
        do {
            let result = try context.fetch(request)
            print("result", result)
            for data in result as! [NSManagedObject] {
                print("Data",data)
                print("Email",data.value(forKey: "email") as! String)
                let emailvalue = data.value(forKey: "email") as! String
                let passValue = data.value(forKey: "password") as! String
                userName.append(emailvalue)
                passwords.append(passValue)
                print("userName",userName)
                print("password",passwords)
            }
            
            DispatchQueue.main.async { [self] in
                if userName.contains(where: {$0  ==  email}) &&  passwords.contains(where: {$0  == password}){
                    print("working fine")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
                    navigationController?.pushViewController(vc, animated: true)
                    self.emailTxtField.text = ""
                    self.passwordTxtField.text = ""
                } else {
                    print(" Not working fine")
                    displayErrorMessage(title: "Alert", message: "Please enter valid  email or password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                        print("Please Enter Your Email")
                    }])
                }
            }
            
        } catch {
            print("dummy")
        }
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        loginPageValidation()
    }
    
    @IBAction func signUpBtnAction(_ sender: Any) {
        if let signupVC = self.storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
            self.navigationController?.pushViewController(signupVC, animated: true)
        }
    }
    
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK:- UITextFieldValidation Methods
    func loginPageValidation() {
        //check valid email:
        if (emailTxtField.text?.isEmpty)! {
            displayErrorMessage(title: "Empty", message: "Please enter your Email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Email")
            }])
        }
        else  if (passwordTxtField.text?.isEmpty)! {
            displayErrorMessage(title: "Empty", message: "Please enter your Password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Please Enter Your Password")
            }])
        }
    }
}

