//
//  TodoModel.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


class TodoModel: Object, Mappable {
    
    dynamic var todoId: Int = 0
    dynamic var name: String = ""
    dynamic var details: String = ""
    dynamic var notes: String = ""
    dynamic var completed: Bool = false
    dynamic var synced: Bool = false
    dynamic var dueDate = ""
    dynamic var startingDate = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String {
        return "todoId"
    }
    
    func mapping(map: Map) {
        todoId <- map["todoId"]
        name <- map["name"]
        details <- map["description"]
        notes <- map["notes"]
        completed <- map["completed"]
        synced <- map["synced"]
        dueDate <- map["dueDate"]
        startingDate <- map["startingDate"]
    }
}

extension TodoModel {
    static func dateFromString(_ dateAsString: String?) -> Date? {
        guard let string = dateAsString else { return nil }
        
        let dateformatter = DateFormatter()
        dateformatter.timeZone = TimeZone(identifier: "France/Paris")
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let val = dateformatter.date(from: string)
        return val
    }
    
    static func dateToString(_ dateIn: Date?) -> String? {
        guard let date = dateIn else { return nil }
        let dateformatter = DateFormatter()
        dateformatter.timeZone = TimeZone(identifier: "France/Paris")
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let val = dateformatter.string(from: date)
        return val
    }
}
