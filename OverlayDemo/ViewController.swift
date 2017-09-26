//
//  ViewController.swift
//  OverlayDemo
//
//  Created by Patrick Lin on 26/09/2017.
//  Copyright © 2017 Soocii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            let controller = UIViewController()
            
            controller.view.frame = UIApplication.shared.statusBarFrame
            
            controller.view.backgroundColor = UIColor.blue
            
            appDelegate.customStatusBar = CustomStatusBar()
            
            appDelegate.customStatusBar?.isHidden = false
            
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            appDelegate.customStatusBar?.isHidden = true
            
        }
        
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
            
            
            
        }) { (context: UIViewControllerTransitionCoordinatorContext) in
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                
                appDelegate.customStatusBar?.isHidden = false
                
            }
            
        }
        
    }

}
