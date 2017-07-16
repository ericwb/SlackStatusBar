//
//  SlackView.swift
//  SlackStatusBar
//
//  Created by Eric Brown on 07/14/2017.
//  Copyright © 2017 Eric Brown. All rights reserved.
//

import Cocoa

class SlackView: NSView {
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var cityTextField: NSTextField!
    @IBOutlet weak var currentConditionsTextField: NSTextField!
    
    func update(_ weather: String) {
        // do UI updates on the main thread
        DispatchQueue.main.async {
            //self.cityTextField.stringValue = weather.city
            //self.currentConditionsTextField.stringValue = "\(Int(weather.currentTemp))°F and \(weather.conditions)"
            //self.imageView.image = NSImage(named: weather.icon)
        }
    }
}
