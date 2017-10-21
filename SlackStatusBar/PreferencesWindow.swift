//
//  PreferencesWindow.swift
//  SlackStatusBar
//
//  Created by Eric Brown on 07/14/2017.
//  Copyright © 2017 Eric Brown. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindowController, NSWindowDelegate {

    private let viewControllers: [NSViewController] = [
        "GeneralPane",
        "CalendarsPane",
        "WiFiPane",
    ].map { (name: String) -> NSViewController in NSStoryboard(name: name, bundle: nil).instantiateInitialController() as! NSViewController }

    override var windowNibName : String! {
        return "PreferencesWindow"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.center()
        guard let leftmostItem = self.window?.toolbar?.items.first else { return }
        self.window?.toolbar?.selectedItemIdentifier = leftmostItem.itemIdentifier
        self.toolbarClicked(leftmostItem)
    }

    @IBAction func toolbarClicked(_ sender: NSToolbarItem) {
        guard let window = self.window else { return }

        // detect clicked icon and select the view to switch
        let newController = self.viewControllers[sender.tag]

        // remove current view from the main view
        window.contentViewController = nil

        // resize window to fit to new view
        var frame = window.frameRect(forContentRect: newController.view.frame)
        frame.origin = window.frame.origin
        frame.origin.y += window.frame.height - frame.height
        window.setFrame(frame, display: false, animate: true)

        // set window title
        window.title = sender.paletteLabel

        // add new view to the main view
        window.contentViewController = newController
    }
}
