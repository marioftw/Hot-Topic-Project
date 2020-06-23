//
//  LibraryCollectionViewController.swift
//  Vitality
//
//  Created by Mario Aguirre on 23/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let colors: [UIColor] = [#colorLiteral(red: 0.9553055167, green: 0.5355370045, blue: 0.399112761, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]
    let titles = ["Surgeries", "Excercises"]
    let descriptions = ["Search for your surgery.", "Find an excercise to do"]
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sections = 1
        if section == 1 {
            sections = self.titles.count
        return sections
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
            cell.titleLabel.text = self.titles[indexPath.row]
            cell.descriptionLabel.text = self.descriptions[indexPath.row]
            let color = self.colors[indexPath.row]
            cell.gradientView.firstColor = color
            cell.gradientView.secondColor = color
            cell.gradientView.backgroundColor = self.colors[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
        let width = view.safeAreaLayoutGuide.layoutFrame.size.width
        
        let device = UIDevice.current
        
        
        if device.userInterfaceIdiom == .pad {
            if indexPath.section == 0 {
                return CGSize(width: width, height: height * 0.25)
            } else if indexPath.section == 1 {
                return CGSize(width: width * 0.06, height: width * 0.06)
            } else {
                return CGSize(width: width * 0.31, height: height * 0.25)
            }
        }
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 150)
        } else if indexPath.section == 1 {
            if device.orientation.isLandscape {
                return CGSize(width: width * 0.1, height: width * 0.1)
            }
            return CGSize(width: width * 0.13, height: width * 0.13)
        } else {
            if device.orientation.isLandscape {
                return CGSize(width: width * 0.47, height: height * 0.4)
            }
            return CGSize(width: width * 0.9, height: height * 0.22)
        }
    }
}
