//
//  AuthViewController.swift
//  TempMonitor
//
//  Created by Алексей Шомников on 24.04.2022.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {
    
    @IBOutlet weak var warnLabel: UILabel!
    
    @IBOutlet weak var loginTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let connectedRef = Database.database().reference(withPath: ".info/connected")
            connectedRef.observe(.value, with: { snapshot in
                if let connected = snapshot.value as? Bool, connected {
                    print("Connected")
                } else {
                    print("Not connected")
                    // show alert here
                }
            })
        
        // Do any additional setup after loading the view.
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // performSegue(withIdentifier: "monitorSegue", sender: nil)
        // ...
        // after login is done, maybe put this in the login web service completion block
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let email = loginTF.text, let password = passwordTF.text, email != "", password != "" else {
            //displayWarningLabel(withText: "Info is incorrect")
            warnLabel.text = "Info is Incorrect"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.warnLabel.text = "Error occurred"
                return
            }
            
            if user != nil {
                //self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            
            //self?.displayWarningLabel(withText: "No such user")
            self?.warnLabel.text = "No such user"
            
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        })
        
        
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let dvc = segue.destination as? TabBarController else { return }
    }
    
}
