//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Mac on 9/28/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    // variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColums: CGFloat = 3
        if UIScreen.main.bounds.width > 320{
            numOfColums = 4
        }
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDemansion = ((collectionView.bounds.width - padding) - (numOfColums - 1) * spaceBetweenCells) / numOfColums
        return CGSize(width: cellDemansion, height: cellDemansion)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark{
        LocalUserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else{
            LocalUserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0{
            avatarType = AvatarType.dark
        }else{
            avatarType = .light
        }
        collectionView.reloadData()
    }
    
}
