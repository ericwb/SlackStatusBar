//
//  SlackAPI.swift
//  SlackStatusBar
//
//  Created by Eric Brown on 07/14/2017.
//  Copyright © 2017 Eric Brown. All rights reserved.
//

import Foundation

enum Presence: String {
    case auto = "auto"
    case away = "away"
}

class SlackAPI {
    let token = UserDefaults.standard.string(forKey: "token") ?? ""

    func sendStatus(statusText: String, statusEmoji: String) -> Void {
        let profile = "{ \"status_text\": \"\(statusText)\", \"status_emoji\": \"\(statusEmoji)\" }"
        let escapedProfile = profile.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
        let urlString = "https://slack.com/api/users.profile.set?token=\(token)&profile=\(escapedProfile!)"
        let url = URL(string: "\(urlString)")

        let task = URLSession.shared.dataTask(with: url!) { data, response, err in
            if let error = err {
                NSLog("slack API error: \(error)")
            }

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 401:
                    NSLog("slack API returned an 'unauthorized' response. Did you set your token?")
                default:
                    NSLog("slack API returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))

                    let result = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
                    NSLog("Result", result!)
                }
            }
        }
        task.resume()
    }

    func sendPresence(presence: Presence) -> Void {
        let urlString = "https://slack.com/api/users.setPresence?token=\(token)&presence=\(presence)"
        let url = URL(string: "\(urlString)")

        let task = URLSession.shared.dataTask(with: url!) { data, response, err in
            if let error = err {
                NSLog("slack API error: \(error)")
            }

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 401:
                    NSLog("slack API returned an 'unauthorized' response. Did you set your token?")
                default:
                    NSLog("slack API returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))

                    let result = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
                    NSLog("Result", result!)
                }
            }
        }
        task.resume()
    }
}
