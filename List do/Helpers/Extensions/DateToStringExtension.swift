//
//  DateToString.swift
//  List do
//
//  Created by Doãn Tuấn on 3/10/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import Foundation

extension Date{
    
    func  dateToString(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return  dateFormatter.string(from: date)
       
    }
    
    func stringToDate(dateString: String)->Date{
    
        if dateString.characters.count == 0 {
            return Date(timeIntervalSinceNow: 0.0)
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/d/yy, h:mm a"
            return dateFormatter.date(from: dateString)!
        }
    }
    
}
