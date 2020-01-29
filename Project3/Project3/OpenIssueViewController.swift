//
//  OpenIssueViewController.swift
//  Project3
//
//  Created by Yangjun Bie on 1/26/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import UIKit
import Foundation

class OpenIssueViewController: IssueViewController {
    
    override var url: URL{
        get {
            return URL(string: "https://api.github.com/repos/Ranchero-Software/NetNewsWire/issues?state=open")!
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenTableCell", for: indexPath) as!IssueTableViewCell
        // Configure the cell...
        //cell.textLabel?.text = String(indexPath.row)
        cell.titleLabel?.text = issues[indexPath.row].title
        cell.usernameLabel?.text = "@" + issues[indexPath.row].user.login

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showOpenDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as!IssueDetailViewController
                controller.selectedIssue = issues[indexPath.row]
            }
        }
    }
}
