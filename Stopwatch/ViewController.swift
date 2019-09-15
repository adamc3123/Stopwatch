//
//  ViewController.swift
//
//  Created by Adam Czech on 6/17/19.
//  Copyright © 2019 Adam Czech. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let INTERVAL = 0.02     // 10 milliseconds
    
    var timerInst = Timer()
    var currTime: Double = 0
    var running = false
    var laps: [lapTime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerLaps.delegate = self
        timerLaps.dataSource = self
        timerLaps.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    @IBOutlet weak var resetLapButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timerCount: UILabel!
    @IBOutlet weak var timerLaps: UITableView!
    
    //
    @IBAction func startStopTimer(_ sender: UIButton) {
        if !running {
            running = true
            updateButtonLabels()
            //startStopButton.setTitle("Stop", for: UIControl.State.normal)
            timerInst = Timer.scheduledTimer(timeInterval: INTERVAL, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)          
        }
        else {
            running = false
            //startStopButton.setTitle("Start", for: UIControl.State.normal)
            updateButtonLabels()
            if (timerInst.isValid) {
                timerInst.invalidate()
            }
        }
    }
    
    @IBAction func resetLapTimer(_ sender: UIButton) {
        if !running{
           
            //resetLapButton.setTitle("Reset", for: UIControl.State.normal)
            currTime = 0
            updateButtonLabels()
            laps.removeAll()
            timerLaps.reloadData()
            updateTimeLabel()
            
        }
        else {
            updateButtonLabels()
            let newLap = lapTime(laptime: currTime)
            laps.insert(newLap, at: 0)
            timerLaps.reloadData()
            //resetLapButton.setTitle("Lap", for: UIControl.State.normal)
        }
    }
    
    func updateButtonLabels() {
        if !running{
            startStopButton.setTitle("Start", for: UIControl.State.normal)
            resetLapButton.setTitle("Reset", for: UIControl.State.normal)
        }
        else {
            startStopButton.setTitle("Stop", for: UIControl.State.normal)
            resetLapButton.setTitle("Lap", for: UIControl.State.normal)
        }
    }
    
    @objc func updateTimeLabel() {
        if running {
            currTime += INTERVAL
        }
        timerCount.text = String(format:"%0.2f", currTime)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lap = laps[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapCell") as! lapTimeTableViewCell
        
        cell.setLapLabel(time: String(format:"%0.2f", lap.lapTime))
        
        return cell
    }
    
}
