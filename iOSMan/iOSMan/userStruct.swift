//
//  userStruct.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import Foundation

struct UserData: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool
    let name, company: String
    let blog: String
    let location: String
    let bio: String
    let publicRepos, publicGists, followers, following: Int
    let createdAt, updatedAt: Date

}
