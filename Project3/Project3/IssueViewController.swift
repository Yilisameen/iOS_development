//
//  IssueViewController.swift
//  Project3
//
//  Created by Yangjun Bie on 1/27/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import UIKit
import Foundation

class IssueViewController: UITableViewController {
    var issues = [GithubIssue]()
    var issue: GithubIssue!
    var url: URL {
        get {
            return URL(string: "https://api.github.com/repos/Ranchero-Software/NetNewsWire/issues?state=closed")!
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            let title = NSLocalizedString("Pull to refresh", comment: "Pull to refresh")
            refreshControl.attributedTitle = NSAttributedString(string: title)
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            self.tableView.refreshControl = refreshControl
        }
        
        GitHubClient.fetchIssues (completion: { (issues, error) in
          // Ensure we have good data before anything else
          guard let issues = issues, error == nil else {
            print(error!)
            return
          }
          for issue in issues {
            self.issues.append(issue)
            print("""
                Title: \(issue.title ?? "No title")
                Author: \(issue.user.login)
                Date: \(issue.createdAt)
                Description: \(issue.body ?? "No body")
                State:\(issue.state)

              """)
          }
          self.tableView.reloadData()
        }, url)
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        self.tableView.reloadData()
        sender.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return issues.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
