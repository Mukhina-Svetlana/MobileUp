//
//  ViewController.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 31.03.2022.
//

import UIKit
import VK_ios_sdk
class ViewController: UIViewController {
    
    override func loadView() {
        view = FirstView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
    }

}

