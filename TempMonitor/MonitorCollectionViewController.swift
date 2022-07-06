//
//  MonitorCollectionViewController.swift
//  TempMonitor
//
//  Created by Алексей Шомников on 23.04.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

let itemsPerRow: CGFloat = 2
let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

var computers: [Computer] = [
    Computer(warningState: false, temps: (43, 41, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
    Computer(warningState: false, temps: (50, 80, 30), fanSpeed: 200, pumpSpeed: 20),
]


class MonitorCollectionViewController: UICollectionViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.global().async {
//            for _ in 1...30 {
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//                testNormal(computer: computers)
//                Thread.sleep( forTimeInterval: 1 )
//            }
            for _ in 1...300 {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                testGrowTemperature(computer: computers)
                Thread.sleep( forTimeInterval: 1 )
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! ComputerCell
            detailVC.computer = cell.computer
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return computers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "computerCell", for: indexPath) as! ComputerCell
        // Configure the cell
        
        //cell.computerImageView.image = UIImage(named: "Computer")
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 10
        let computer = computers[indexPath.item]
        cell.computer = computer
        if computer.isEmergencyShutdown {
            cell.backgroundColor = .systemRed
        }
        
        
        if computer.warningState {
            cell.warningImageView.isHidden = false
        } else {
            cell.warningImageView.isHidden = true
        }
        
        if let cpuTemp = computer.temps.cpuTemp, let gpuTemp = computer.temps.gpuTemp {
            cell.tempsLabel.text = "cpu: \(cpuTemp), gpu: \(gpuTemp)"
        } else {
            cell.tempsLabel.text = "liquid: \(computer.temps.liquidTemp ?? 0)"
        }
        cell.computerNameLabel.text = "PC \(indexPath.item)"
        
        return cell
    }

    // MARK: UICollectionViewDelegate

  
    
}

extension MonitorCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = floor(availableWidth / itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
