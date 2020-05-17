//
//  SplashViewController.swift
//  MovieBoxFinal
//
//  Created by 2unni on 3/16/20.
//  Copyright © 2020 2unni. All rights reserved.
//

import UIKit
import Reachability

class SplashViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    override func viewDidAppear(_ animated: Bool) {
        let tabView = self.storyboard?.instantiateViewController(withIdentifier: "tabView") as! UITabBarController
        tabView.modalPresentationStyle = .fullScreen
        sleep(2)
        
        self.present(tabView, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
