//
//  PreferencesWindow.swift
//  SlackStatusBar
//
//  Created by Eric Brown on 07/14/2017.
//  Copyright © 2017 Eric Brown. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    var delegate: PreferencesWindowDelegate?
    @IBOutlet weak var tokenTextField: NSTextField!

    override var windowNibName : String! {
        return "PreferencesWindow"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        tokenTextField.stringValue = token
    }

    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(tokenTextField.stringValue, forKey: "token")
        delegate?.preferencesDidUpdate()
    }
}
