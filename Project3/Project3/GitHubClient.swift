//
//  ClientIssue.swift
//  Project3
//
//  Created by Yangjun Bie on 1/27/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import Foundation

struct GitHubUser : Codable{
    let login: String
}

struct GithubIssue : Codable{
    let title: String?
    let createdAt: String
    let body: String?
    let state: String
    let user: GitHubUser
}

class GitHubClient {
    
    static func fetchIssues(completion: @escaping ([GithubIssue]?, Error?) -> Void, _ url: URL) {

      // Create a data task
        let task = URLSession.shared.dataTask(with: url) { data, _, error in

        guard let data = data, error == nil else {
          // If we are missing data, send back no data with an error
          DispatchQueue.main.async { completion(nil, error) }
          return
        }

        // Safely try to decode the JSON to our custom struct
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          let githubissues = try decoder.decode([GithubIssue].self, from: data)

          // If we're successful, send back our releases with no error
          DispatchQueue.main.async { completion(githubissues, nil) }

        } catch (let parsingError) {
          DispatchQueue.main.async { completion(nil, parsingError) }
        }
      }

      // Start the task (it begins suspended)
      task.resume()
    }
}
