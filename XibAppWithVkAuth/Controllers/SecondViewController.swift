//
//  SecondViewController.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 01.04.2022.
//

import UIKit
import VK_ios_sdk
class SecondViewController: UIViewController {
    
    private let cellID = "MyCell"
    private let datePhotos = GetDatePhotos()
    private let networkService = NetworkService()
    
    private var arrayDate = [Int]()
    private var arrayPhotos = [String]()
    
    static var selectedDate = 0
    static var urlSelectedPhoto: String?
    

    lazy private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.frame.width - 3)/2, height: 200)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        return layout
    }()
    lazy private var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .secondarySystemBackground
        navigationItem.backButtonTitle = ""
        title = "Mobile Up Gallery"
        let button1 = UIBarButtonItem(title: "Выход", style: .done, target: self, action: #selector(exitVK))
        self.navigationItem.rightBarButtonItem  = button1
        navigationController?.navigationBar.tintColor = .black
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        view.addSubview(collectionView)
        getArrays()
    }
}

extension SecondViewController {
    private func getArrays() {
        networkService.request { model in
            for i in model {
                self.arrayDate.append(i.date)
                self.arrayPhotos.append(i.urlPhoto)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    @objc
    private func exitVK() {
        self.navigationController?.popToRootViewController(animated: true)
        VKSdk.forceLogout()
    }
}

extension SecondViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CustomCollectionViewCell else {return UICollectionViewCell()}
        cell.imageCell.set(imageURL: arrayPhotos[indexPath.row])
        return cell
    }
    
}
extension SecondViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newViewController = ThirdViewController()
        //show(newViewController, sender: nil)
        navigationController?.pushViewController(newViewController, animated: true)
        SecondViewController.selectedDate = arrayDate[indexPath.row]
        SecondViewController.urlSelectedPhoto = arrayPhotos[indexPath.row]
    }
}

