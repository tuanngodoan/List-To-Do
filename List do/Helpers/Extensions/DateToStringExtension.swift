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
        var dateString = ""
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        dateString = formatter.string(from: date)
       return dateString
    }
    
}
