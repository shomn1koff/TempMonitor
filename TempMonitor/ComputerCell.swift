//
//  ComputerCell.swift
//  TempMonitor
//
//  Created by Алексей Шомников on 24.04.2022.
//

import UIKit

class ComputerCell: UICollectionViewCell {

    @IBOutlet weak var computerNameLabel: UILabel!
    @IBOutlet weak var tempsLabel: UILabel!
    @IBOutlet weak var warningImageView: UIImageView!
    
    var computer: Computer?
    
}

class Computer {
    var warningState: Bool
    var isEmergencyShutdown: Bool = false
    
    var temps: (cpuTemp: Int?, gpuTemp: Int?, liquidTemp: Int?)
    var fanSpeed: Int
    var pumpSpeed: Int
    
    var tempsForDraw: [[Int]] = [[40],[40],[40]]
    
    
    init(warningState: Bool, temps: (cpuTemp: Int?, gpuTemp: Int?, liquidTemp: Int?), fanSpeed: Int, pumpSpeed: Int) {
        self.warningState = warningState
        self.temps = temps
        self.fanSpeed = fanSpeed
        self.pumpSpeed = pumpSpeed
    }
    
    func overheatProtection() {
        if let cpuTemp = self.temps.cpuTemp, let gpuTemp = self.temps.gpuTemp {
            if (cpuTemp > 80 || gpuTemp > 80) {
                self.warningState = true
            } else {
                self.warningState = false
            }
            
            if (cpuTemp > 100 || gpuTemp > 100) {
                self.isEmergencyShutdown = true
            }
        } else if let liquidTemp = self.temps.liquidTemp {
            if liquidTemp > 50 {
                self.warningState = true
            } else {
                self.warningState = false
            }
            if liquidTemp > 80 {
                self.isEmergencyShutdown = true
            }
        }
    }
}





func testNormal(computer: [Computer]) {
    
    for computer in computers {
        computer.overheatProtection()
        if  computer.isEmergencyShutdown {
            return
        }
        /*
        if (0...1).randomElement() == 0 {
            computer.temps.cpuTemp = nil
        } else {
            computer.temps.cpuTemp = 0
        }
        */
        if let _ = computer.temps.cpuTemp, let _ = computer.temps.gpuTemp {
            computer.temps.cpuTemp = Array(40...50).randomElement()
            computer.tempsForDraw[0].append(computer.temps.cpuTemp!)
            computer.temps.gpuTemp = Array(40...50).randomElement()
            computer.tempsForDraw[1].append(computer.temps.gpuTemp!)
        } else {
            computer.temps.liquidTemp = Array(30...35).randomElement()
            computer.tempsForDraw[2].append(computer.temps.liquidTemp!)
        }
        
        
        
        
    }
}

func testGrowTemperature(computer: [Computer]) {
    for computer in computers {
        computer.overheatProtection()
        if  computer.isEmergencyShutdown {
            return
        }
        if let _ = computer.temps.cpuTemp, let _ = computer.temps.gpuTemp {
            computer.temps.cpuTemp! += 2
            computer.tempsForDraw[0].append(computer.temps.cpuTemp!)
            computer.temps.gpuTemp! += 2
            computer.tempsForDraw[1].append(computer.temps.gpuTemp!)
        } else {
            computer.temps.liquidTemp! += 2
            computer.tempsForDraw[2].append(computer.temps.liquidTemp!)
        }
        
        
        
        
    }
}


