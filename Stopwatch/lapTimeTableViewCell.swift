//
//  lapTimeTableViewCell.swift
//  Stopwatch
//
//  Created by Adam Czech on 6/29/19.
//  Copyright © 2019 Adam Czech. All rights reserved.
//

import UIKit

class lapTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var lapCell: UILabel!
 
    func setLapLabel(time: String) {
        lapCell.text = time
    }
}
