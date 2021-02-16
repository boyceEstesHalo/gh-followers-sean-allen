//
//  Follower.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/15/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}
