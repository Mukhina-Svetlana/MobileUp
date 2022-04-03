//
//  ThirdViewController.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 03.04.2022.
//

import UIKit

class ThirdViewController: UIViewController {
    
    private func dateFormater(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    lazy private var bigImage: UIImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        if let selectedPhoto = SecondViewController.urlSelectedPhoto {
            image.set(imageURL: selectedPhoto)
        } else {
            image.image = UIImage(systemName: "xmark")
        }
        image.contentMode = .scaleAspectFit
        return image
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        let timeResult = dateFormater(date: Double(SecondViewController.selectedDate))
        title = timeResult
        navigationController?.navigationBar.tintColor = .black
        let button1 = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(share))
        self.navigationItem.rightBarButtonItem  = button1
        configuration()
    }
}
extension ThirdViewController {
    private func configuration() {
        view.addSubview(bigImage)
        NSLayoutConstraint.activate([
            bigImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bigImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            bigImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bigImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    @objc
    private func share() {
        let shareController = UIActivityViewController(activityItems: [bigImage.image as Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                let alert = UIAlertController(title: "Успешно", message:  "Ваше фото добавлено в  Photo", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        present(shareController, animated: false, completion: nil)
    }
}
