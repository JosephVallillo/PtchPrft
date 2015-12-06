//
//  Settings.swift
//  PtchPrfct
//
//  Created by Joseph Vallillo on 12/5/15.
//  Copyright © 2015 Joseph Vallillo. All rights reserved.
//

import Foundation

class Settings: NSObject {
    
    //MARK: - User Defaults
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: - Structs
    private struct Defaults {
        static let SlowRate = "SlowRate"
        static let SlowRateDefaultValue: Float = 0.5
        
        static let HighRate = "HighRate"
        static let HighRateDefaultValue: Float = 1.5
        
        static let LowPitch = "LowPitch"
        static let LowPitchDefaultValue: Float = -1000.0
        
        static let HighPitch = "HighPitch"
        static let HighPitchDefaultValue: Float = 1000.0
        
        static let Distortion = "Distortion"
        static let DistortionDefaultValue: Float = 50.0
        
        static let Echo = "Echo"
        static let EchoDefaultValue: Float = 0.25
    }
    
    //MARK: - Properties
    var slowRate: Float {
        get { return get(Defaults.SlowRate, defaultValue: Defaults.SlowRateDefaultValue) }
        set { set(Defaults.SlowRate, value: newValue) }
    }
    var highRate: Float {
        get { return get(Defaults.HighRate, defaultValue: Defaults.HighRateDefaultValue) }
        set { set(Defaults.HighRate, value: newValue) }
    }
    
    var lowPitch: Float {
        get { return get(Defaults.LowPitch, defaultValue: Defaults.LowPitchDefaultValue) }
        set { set(Defaults.LowPitch, value: newValue) }
    }
    var highPitch: Float {
        get { return get(Defaults.HighPitch, defaultValue: Defaults.HighPitchDefaultValue) }
        set { set(Defaults.HighPitch, value: newValue) }
    }
    
    var distort: Float {
        get { return get(Defaults.Distortion, defaultValue: Defaults.DistortionDefaultValue) }
        set { set(Defaults.Distortion, value: newValue) }
    }
    
    var echo: Float {
        get { return get(Defaults.Echo, defaultValue: Defaults.EchoDefaultValue) }
        set { set(Defaults.Echo, value: newValue) }
    }
    
    //MARK: - Helper Functions
    private func set<T>(key: String, value: T) {
        userDefaults.setObject(value as? AnyObject, forKey: key)
    }
    
    private func get<T>(key: String, defaultValue:T) -> T {
        return userDefaults.objectForKey(key) as? T ?? defaultValue
    }
    
}