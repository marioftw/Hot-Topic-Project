//
//  HomeViewController.swift
//  Vitality
//
//  Created by Mario Aguirre on 19/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
//        navigationItem.titleView = UIImageView(image: UIImage(named: "VitalityLogo_1"))
        addNavBarImage()
    }
    
    //  Code from: https://stackoverflow.com/questions/24803178/navigation-bar-with-uiimage-for-title
    func addNavBarImage() {

        let navController = navigationController!

        let image = UIImage(named: Constants.Images.logoWordsOnly)
        let imageView = UIImageView(image: image)

        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height

        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 3 - (image?.size.height)! / 3

        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit

        navigationItem.titleView = imageView
    }
    
    @IBAction func logoutButton(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
}
