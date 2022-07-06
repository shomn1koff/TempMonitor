//
//  DetailViewController.swift
//  TempMonitor
//
//  Created by Алексей Шомников on 04.05.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var fanSpeedLabel: UILabel!
    @IBOutlet weak var pumpSpeedLabel: UILabel!
    var computer: Computer?
    
    private let drawer: GraphViewProtocol = GraphView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.graphPoints = (computer?.tempsForDraw[0])!
        graphView.backgroundColor = self.view.backgroundColor
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        speedLabel.text = "\(Int(slider.value)) %"
        // Do any additional setup after loading the view.
        if let computer = computer {
            if computer.isEmergencyShutdown {
                stateLabel.text = "Работа ЭВМ аварийно завершена"
            } else if computer.warningState {
                stateLabel.text = "Температура близка к критической"
            } else {
                stateLabel.text = "Температура в норме"
            }
            tempLabel.text = "Текущая температура: \(computer.temps.cpuTemp ?? 0) °C"
        }
        fanSpeedLabel.text = "Скорость вентиляторов: \(computer?.fanSpeed ?? 0) об/мин"
        pumpSpeedLabel.text = "Скорость помпы: \(computer?.pumpSpeed ?? 0)%"
    }
    
    
    @IBAction func sliderSpeedValueChanged(_ sender: UISlider) {
        speedLabel.text = "\(Int(sender.value)) %"
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

