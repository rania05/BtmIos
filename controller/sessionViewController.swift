//
//  sessionViewController.swift
//  BTMFINAL
//
//  Created by imen manai on 12/29/20.
//

import UIKit

class sessionViewController: UIViewController {
    let Userdefaults = UserDefaults.standard
    let userRepo = UserRepository()
    let db = localDB()
    var users:[User] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)

        check()
        // Do any additional setup after loading the view.
    }
    @objc func timeToMoveOn() {
        let hasSession: Bool = UserDefaults.standard.bool(forKey: "isLogin")

        if hasSession {
            
            performSegue(withIdentifier: "homeseg", sender:self)

            
        }else {
            performSegue(withIdentifier: "logsegue", sender:self)

            
        }
      }
    
    func check() {
       
        let hasSession: Bool = UserDefaults.standard.bool(forKey: "isLogin")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let initialViewController = storyboard.instantiateViewController(withIdentifier: "Nav") as! UITabBarController
        let nextvc = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController

        
            if hasSession {
                
                performSegue(withIdentifier: "homeseg", sender:(Any).self)

                
            }else {
                performSegue(withIdentifier: "logsegue", sender:(Any).self)

                
            }
        
        
        
    }
    
    func checkLogin() {
        users = db.read()
        if (users.count > 0 ){
            print(users.count)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let NavViewController = storyBoard.instantiateViewController(withIdentifier: "Nav") as! UITabBarController
            self.present(NavViewController, animated: true, completion: nil)
            
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "login", bundle: nil)
        let NavViewController = storyBoard.instantiateViewController(withIdentifier: "Nav") as! UITabBarController
        self.present(NavViewController, animated: true, completion: nil)
        
    }

}
