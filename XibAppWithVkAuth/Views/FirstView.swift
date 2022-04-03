//
//  FirstView.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 04.04.2022.
//

import UIKit

class FirstView: UIView {
    
    private var authService: AuthService?
    
    lazy private var label: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mobile Up     Gallery"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 50)
        return label
    }()
    
    lazy private var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginVKbtn), for: .touchUpInside)
        button.setTitle("Вход через VK", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 7
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    init(){
        super.init(frame: .zero)
        authService = SceneDelegate.shared().authService
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FirstView {
    
    private func configuration() {
        self.addSubview(button)
        self.addSubview(label)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    @objc
    private func loginVKbtn() {
        authService?.wakeUpSession()
       }

}
