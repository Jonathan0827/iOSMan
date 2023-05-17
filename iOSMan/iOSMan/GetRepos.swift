//
//  GetRepos.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import Foundation


func getRepos(_ GithubUserName: String) {
//    let app = Octokit()
    let username = GithubUserName // set the username
//    Octokit().user(name: username) { response in
//      switch response {
//        case .success(let user):
//          Octokit().repositories() { response in
//            switch response {
//              case .success(let repository):
//                print(repository)
//              case .failure(let error):
//                print(error)
//            }
//          }
//        case .failure(let error):
//          print(error)
//      }
//    }
//    URLSession.fetchData(at: URL(string: "https://api.github.com/user/repos")!)
    executeSh("open ./")
}

