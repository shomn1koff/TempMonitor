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

struct PotFunction {
    let firstValue = 10;
    let secondValue = 20;
    let thirdValue = 30;
    let fourthValue = 40;
    let fifthValue = 70;
    let sixthValue = 100;
}

struct TempsForLQ {
    let firstValue = 10;
    let secondValue = 35;
    let thirdValue = 40;
    let fourthValue = 50;
    let fifthValue = 70;
    let sixthValue = 80;
}

struct TempsForHW {
    let firstValue = 20;
    let secondValue = 48;
    let thirdValue = 55;
    let fourthValue = 66;
    let fifthValue = 70;
    let sixthValue = 100;
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
            switch cpuTemp {
            case 20:
                self.pumpSpeed = 10
            case 48:
                self.pumpSpeed = 20
            case 55:
                self.pumpSpeed = 30
            case 66:
                self.pumpSpeed = 40
            case 70:
                self.pumpSpeed = 70
            case 100:
                self.pumpSpeed = 100
            default:
                self.fanSpeed = self.pumpSpeed * 10
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
            switch self.temps.liquidTemp! {
            case 20:
                self.pumpSpeed = 10
            case 35:
                self.pumpSpeed = 20
            case 40:
                self.pumpSpeed = 30
            case 50:
                self.pumpSpeed = 40
            case 70:
                self.pumpSpeed = 70
            case 80:
                self.pumpSpeed = 100
            default:
                self.fanSpeed = self.pumpSpeed * 10
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
           
            // pot function 10 20 30 40 70 100
            // hwtemps      20 48 55 66 70 100
            // lqtemps      20 35 40 50 70 80
            
            
        } else {
            computer.temps.liquidTemp = Array(30...35).randomElement()
            computer.tempsForDraw[2].append(computer.temps.liquidTemp!)
            computer.pumpSpeed = Array(10...20).randomElement()!
            computer.pumpSpeed = Array(100...200).randomElement()!
            
        }
    }
}

func testGrowTemperature(computer: [Computer]) {
    computer[0].overheatProtection()
    if  computer[0].isEmergencyShutdown {
        return
    }
    if let _ = computer[0].temps.cpuTemp, let _ = computer[0].temps.gpuTemp {
        computer[0].temps.cpuTemp! += 1
        computer[0].tempsForDraw[0].append(computer[0].temps.cpuTemp!)
        computer[0].temps.gpuTemp! += 1
        computer[0].tempsForDraw[1].append(computer[0].temps.gpuTemp!)
       
        // pot function 10 20 30 40 70 100
        // hwtemps      20 48 55 66 70 100
        // lqtemps      20 35 40 50 70 80
        
    } else {
        computer[0].temps.liquidTemp! += 1
        computer[0].tempsForDraw[2].append(computer[0].temps.liquidTemp!)
    }
    for computer in computers[1...9] {
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


