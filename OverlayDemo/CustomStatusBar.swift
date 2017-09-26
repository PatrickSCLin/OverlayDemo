//
//  CustomStatusBar.swift
//  OverlayDemo
//
//  Created by Patrick Lin on 26/09/2017.
//  Copyright © 2017 Soocii. All rights reserved.
//

import UIKit

class CustomStatusBar: UIWindow {
    
    var tapGesture: UITapGestureRecognizer!
    
    // MARK: Internal Methods
    
    func tap(_ gesture: UITapGestureRecognizer) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let navigation = appDelegate.window?.rootViewController as? UINavigationController, let controller = navigation.viewControllers.first as? ViewController {
            
            controller.performSegue(withIdentifier: "Live", sender: nil)
            
        }
        
    }
    
    // MARK: Init Methods

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.frame = UIApplication.shared.statusBarFrame
        
        self.backgroundColor = UIColor.clear
        
        if let controller = self.rootViewController {
            
            controller.view.frame = self.frame
            
        }
        
    }
    
    init() {
        
        super.init(frame: UIApplication.shared.statusBarFrame)
        
        self.rootViewController = CustomStatusBarController()
        
        self.windowLevel = UIWindowLevelStatusBar + 1
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(CustomStatusBar.tap(_:)))
        
        self.addGestureRecognizer(self.tapGesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

}

class CustomStatusBarController: UIViewController {
    
    var titleLabel: UILabel!
    
    var customStatusBar: CustomStatusBar? {
        
        get {
            
            return (UIApplication.shared.delegate as? AppDelegate)?.customStatusBar
            
        }
        
    }
    
    // MARK: Internal Methods
    
    func startAnimation() {
        
        self.titleLabel.alpha = 1
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            self.titleLabel.alpha = 0
            
        }, completion: nil)
        
    }
    
    func stopAnimation() {
        
        self.titleLabel.layer.removeAllAnimations()
        
    }
    
    // MARK: Init Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.titleLabel = UILabel()
        
        self.titleLabel.frame = self.view.frame
        
        self.titleLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.titleLabel.backgroundColor = UIColor.clear
        
        self.titleLabel.textColor = UIColor.white
        
        self.titleLabel.text = "正在Sooocii直播中"
        
        self.titleLabel.textAlignment = .center
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        
        self.view.backgroundColor = UIColor.red
        
        self.view.addSubview(self.titleLabel)
        
        NotificationCenter.default.addObserver(forName: .UIApplicationWillEnterForeground, object: nil, queue: nil) { (notification: Notification) in
            
            self.customStatusBar?.isHidden = false
            
            self.startAnimation()
            
        }
        
        NotificationCenter.default.addObserver(forName: .UIApplicationDidEnterBackground, object: nil, queue: nil) { (notification: Notification) in
            
            self.customStatusBar?.isHidden = true
            
            self.stopAnimation()
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.startAnimation()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        self.stopAnimation()
        
    }
    
}
