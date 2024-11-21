//
//  DateModel.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import Foundation

struct DateModel {
    
    var startDate: Date?
    var endDate: Date? =  Calendar.current.date(byAdding: .day, value: 2, to: Date())
    
}
