//
//  CustomImageView.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 02.04.2022.
//

import UIKit

class CustomImageView: UIImageView {
    
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        let tast = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    self!.image = UIImage(data: data)
                }
            }

            }
        tast.resume()
    }
}
