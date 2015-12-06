//
//  SettingsTableViewController.swift
//  PtchPrfct
//
//  Created by Joseph Vallillo on 12/5/15.
//  Copyright © 2015 Joseph Vallillo. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    //MARK: - Model
    private let settings = Settings()
    
    //MARK: - Outlets
    @IBOutlet weak var slowRateLabel: UILabel!
    @IBOutlet weak var slowRateSlider: UISlider!
    @IBOutlet weak var highRateLabel: UILabel!
    @IBOutlet weak var highRateSlider: UISlider!
    @IBOutlet weak var highPitchLabel: UILabel!
    @IBOutlet weak var highPitchSlider: UISlider!
    @IBOutlet weak var lowPitchLabel: UILabel!
    @IBOutlet weak var lowPitchSlider: UISlider!
    @IBOutlet weak var distortLabel: UILabel!
    @IBOutlet weak var distortSlider: UISlider!
    @IBOutlet weak var echoLabel: UILabel!
    @IBOutlet weak var echoSlider: UISlider!

    //MARK: - Actions
    @IBAction func slowRateChanged(sender: UISlider) {
        slowRateLabel.text = slowRateSlider.value.description
        settings.slowRate = slowRateSlider.value
    }
    @IBAction func highRateChanged(sender: UISlider) {
        highRateLabel.text = highRateSlider.value.description
        settings.highRate = highRateSlider.value
    }
    @IBAction func highPitchChanged(sender: UISlider) {
        highPitchLabel.text = highPitchSlider.value.description
        settings.highPitch = highPitchSlider.value
    }
    @IBAction func lowPitchChanged(sender: UISlider) {
        lowPitchLabel.text = lowPitchSlider.value.description
        settings.lowPitch = lowPitchSlider.value
    }
    @IBAction func distortChanged(sender: UISlider) {
        distortLabel.text = distortSlider.value.description
        settings.distort = distortSlider.value
    }
    @IBAction func echoChanged(sender: UISlider) {
        echoLabel.text = echoSlider.value.description
        settings.echo = echoSlider.value
    }
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slowRateLabel.text = settings.slowRate.description
        slowRateSlider.value = settings.slowRate
        
        highRateLabel.text = settings.highRate.description
        highRateSlider.value = settings.highRate
        
        highPitchLabel.text = settings.highPitch.description
        highPitchSlider.value = settings.highPitch
        
        lowPitchLabel.text = settings.lowPitch.description
        lowPitchSlider.value = settings.lowPitch
        
        distortLabel.text = settings.distort.description
        distortSlider.value = settings.distort
        
        echoLabel.text = settings.echo.description
        echoSlider.value = settings.echo
    }
    
}
