//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Tushar Katyal on 20/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController , UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    // outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            return cell
        }
        
        return AvatarCell()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Actions
    @IBAction func backPressed(_ sender: Any) { dismiss(animated: true, completion: nil)
    }
    @IBAction func segmentControlChanged(_ sender : Any) {
        
    }
}
