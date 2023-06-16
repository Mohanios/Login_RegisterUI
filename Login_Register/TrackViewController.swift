//
//  TrackViewController.swift
//  Login_Register
//
//  Created by Mohanraj on 21/02/23.
//

import UIKit

class TrackViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
