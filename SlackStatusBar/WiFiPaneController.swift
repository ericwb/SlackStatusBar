//
//  WifiView.swift
//  SlackStatusBar
//
//  Created by Eric Brown on 7/17/17.
//  Copyright © 2017 Eric Brown. All rights reserved.
//

import Cocoa

final class WiFiPaneController: NSViewController {
    @IBOutlet private var locationsController: NSArrayController?
    @IBOutlet private weak var tableView: NSTableView?

    @IBAction func addLocation(_ sender: Any?) {
        //self.endEditing()
        self.locationsController?.add(self)
    }

    /// remove selected file drop setting
    @IBAction func removeLocation(_ sender: Any?) {
        guard let selectedRow = self.tableView?.selectedRow, selectedRow != -1 else { return }
        //self.endEditing()
        // ask user for deletion
        //self.deleteSetting(at: selectedRow)
    }

}
