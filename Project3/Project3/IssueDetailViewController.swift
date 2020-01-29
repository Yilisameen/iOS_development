//
//  IssueDetailViewController.swift
//  Project3
//
//  Created by Yangjun Bie on 1/26/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {

    @IBOutlet var titleIssue: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var creationTime: UILabel!
    @IBOutlet var stateImage: UIImageView!
    @IBOutlet var discription: UITextView!
    
    var selectedIssue: GithubIssue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleIssue.text = selectedIssue?.title
        username.text = "@" + (selectedIssue?.user.login)!
        discription.text = selectedIssue?.body
        if selectedIssue?.state == "open"{
            stateImage.image = UIImage(named: "icon-open")
        }
        else{
            stateImage.image = UIImage(named: "icon-close")
        }
        creationTime.text = FormatConvert(selectedIssue!.createdAt)
    }
    
    func FormatConvert(_ originalFormat: String) -> String {
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = RFC3339DateFormatter.date(from: originalFormat)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date!)
    }

}
