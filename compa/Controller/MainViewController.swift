//
//  ViewController.swift
//  compa
//
//  Created by m2sar on 12/04/2018.
//  Copyright © 2018 m2sar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool){
<<<<<<< HEAD
        self.performSegue(withIdentifier:"mainToMap", sender: self)
=======
        //self.performSegue(withIdentifier:"mainToMap", sender: self)
>>>>>>> 9d6a185ce5f5cad5fdc1ee2bc72f1b218c58881a
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier:"mainToLogin", sender: self)
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
        UserDefaults.standard.synchronize();
        //self.performSegue(withIdentifier:"loginView", sender: self)
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier:"mainToRegister", sender: self)
    }
}
