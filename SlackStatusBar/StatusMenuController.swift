//
//  StatusMenuController.swift
//  SlackStatusBar
//
//  Created by Eric Brown on 07/14/2017.
//  Copyright © 2017 Eric Brown. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!

    var autoMenuItem: NSMenuItem!
    var meetingMenuItem: NSMenuItem!
    var commuteMenuItem: NSMenuItem!
    var sickMenuItem: NSMenuItem!
    var vacationMenuItem: NSMenuItem!
    var remoteMenuItem: NSMenuItem!
    var awayMenuItem: NSMenuItem!
    var preferencesWindow: PreferencesWindow!

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    let slackAPI = SlackAPI()

    var timer: Timer!

    override func awakeFromNib() {
        let icon = NSImage(named: "slack")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        statusItem.menu?.autoenablesItems = false
        autoMenuItem = statusMenu.item(withTitle: "Auto")
        meetingMenuItem = statusMenu.item(withTitle: "In a Meeting")
        meetingMenuItem.isEnabled = false
        commuteMenuItem = statusMenu.item(withTitle: "Commuting")
        commuteMenuItem.isEnabled = false
        sickMenuItem = statusMenu.item(withTitle: "Out Sick")
        sickMenuItem.isEnabled = false
        vacationMenuItem = statusMenu.item(withTitle: "Vacationing")
        vacationMenuItem.isEnabled = false
        remoteMenuItem = statusMenu.item(withTitle: "Working Remotely")
        remoteMenuItem.isEnabled = false
        awayMenuItem = statusMenu.item(withTitle: "Away")
        awayMenuItem.isEnabled = false

        preferencesWindow = PreferencesWindow()

        timer = Timer.scheduledTimer(
            timeInterval: 60,
            target: self,
            selector: #selector(checkStatus),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func checkStatus() {
        print("checking status")
    }

    @IBAction func autoClicked(_ sender: NSMenuItem) {
        sender.state = 1 - sender.state

        if sender.state == 1 {
            // Turning auto mode ON
            slackAPI.sendPresence(presence: Presence.auto)

            // Disable all actions (gray out menu items)
            meetingMenuItem.isEnabled = false
            commuteMenuItem.isEnabled = false
            sickMenuItem.isEnabled = false
            vacationMenuItem.isEnabled = false
            remoteMenuItem.isEnabled = false
            awayMenuItem.isEnabled = false

            // Enable timer
            timer = Timer.scheduledTimer(
                timeInterval: 60,
                target: self,
                selector: #selector(checkStatus),
                userInfo: nil,
                repeats: true
            )
        } else {
            // Turning auto mode OFF

            // Disable timer
            timer.invalidate()

            // Enable all callbacks
            meetingMenuItem.isEnabled = true
            commuteMenuItem.isEnabled = true
            sickMenuItem.isEnabled = true
            vacationMenuItem.isEnabled = true
            remoteMenuItem.isEnabled = true
            awayMenuItem.isEnabled = true
        }
    }

    @IBAction func meetingClicked(_ sender: NSMenuItem) {
        slackAPI.sendStatus(statusText: "In a Meeting", statusEmoji: ":spiral_calendar_pad:")
    }

    @IBAction func commuteClicked(_ sender: NSMenuItem) {
        slackAPI.sendStatus(statusText: "Commuting", statusEmoji: ":bus:")
    }

    @IBAction func sickClicked(_ sender: NSMenuItem) {
        slackAPI.sendStatus(statusText: "Out Sick", statusEmoji: ":face_with_thermometer:")
    }

    @IBAction func vacationClicked(_ sender: NSMenuItem) {
        slackAPI.sendStatus(statusText: "Vacationing", statusEmoji: ":palm_tree:")
    }

    @IBAction func remoteClicked(_ sender: NSMenuItem) {
        slackAPI.sendStatus(statusText: "Working Remotely", statusEmoji: ":house_with_garden:")
    }

    @IBAction func awayClicked(_ sender: NSMenuItem) {
        slackAPI.sendPresence(presence: Presence.away)
    }

    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
}
