//
//  AuthViewController.swift
//  TempMonitor
//
//  Created by Алексей Шомников on 24.04.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
//import FirebaseDatabaseSwift


class AuthViewController: UIViewController {
    
    @IBOutlet weak var warnLabel: UILabel!
    
    @IBOutlet weak var loginTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTF.text = "alexchillout1703@gmail.com"
        passwordTF.text = "mirea1967"
        
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
        warnLabel.alpha = 0

    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func displayWarningLabel(withText text: String) {
            warnLabel.text = text
            
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                self?.warnLabel.alpha = 1
            }) { [weak self] complete in
                self?.warnLabel.alpha = 1
            }
        }
    
    @IBAction func loginTapped(_ sender: UIButton) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let email = loginTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(withText: "Данные введены некорректно")
            //warnLabel.text = "Info is Incorrect"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Неверный логин/пароль")
                return
            }
            
            if user != nil {
                //self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                print("\(email) connected")
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                //return
            }
        })
        
        
        
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let dvc = segue.destination as? TabBarController else { return }
    }
    
}
