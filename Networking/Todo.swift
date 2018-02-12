//
//  Todo.swift
//  Networking
//
//  Created by Evgeniy Kolenkov on 11.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation

class Todo {
    
    var title: String
    var id: Int?
    var userId: Int
    var completed: Bool
    
    init?(title: String, id: Int?, userId: Int, completed: Bool) {
        self.title = title
        self.id = id
        self.userId = userId
        self.completed = completed
    }
    
    convenience init?(json: [String: Any]) {
        guard
            let title = json["title"] as? String,
            let userId = json["userId"] as? Int,
            let completed = json["completed"] as? Bool
            else {
                return nil
        }
        let id = json["id"] as? Int
        self.init(title: title, id: id, userId: userId, completed: completed)
    }
    
    func toJson() -> [String: Any] {
        var json = [String: Any]()
        json["title"] = self.title
        json["userId"] = self.userId
        json["completed"] = self.completed
        return json
    }
}
