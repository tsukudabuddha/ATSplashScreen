//
//  ViewController.swift
//  ATSplashScreen
//
//  Created by tsukudabuddha on 05/12/2018.
//  Copyright (c) 2018 tsukudabuddha. All rights reserved.
//

import UIKit
import ATSplashScreen

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This is meant to represent the first view in your app
        let mainView = UITableView(frame: view.frame)
        mainView.backgroundColor = UIColor.darkGray
        view.addSubview(mainView)
        
        // Most Verbose Initializer
        let verboseView = SplashScreenView(imageColor: .black, imageSize: CGSize(width: 200, height: 200), imageName: "apple", transition: .shutter, lineOrientation: .horizontal)
        
        // Most Simple
        let _ = SplashScreenView(imageName: "apple")

        view.addSubview(verboseView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

