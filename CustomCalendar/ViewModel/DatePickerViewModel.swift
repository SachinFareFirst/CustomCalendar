//
//  DatePickerViewModel.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import SwiftUI

class DatePickerViewModel: ObservableObject {
    
    var dateModel = DateModel()
    @Published var calendar = Calendar.current
    @Published var timezone = TimeZone.current
    @Published var minimumDate: Date = Date()
    @Published var maximumDate: Date = Date().addingTimeInterval(60*60*24*365)
    @Published var disabledDates: [Date] = [Date]()
    @Published var selectedDates: [Date] = [Date]()
    @Published var selectedDate: Date? = nil
    @Published var mode: Int = 1

    init(calendar: Calendar , minimumDate: Date, maximumDate: Date,   mode: Int ) {
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.mode = mode
    }
    
    var colors = ColorSetting()

    var startDate: Date?{
        get {
            guard let start = dateModel.startDate ?? calendar.date(byAdding: .day, value: 1, to: Date()) else {
                return Date()
            }
            return start
        }
        
        set {
            dateModel.startDate = newValue
        }
        
    }
    var endDate: Date?{
        get {
            return dateModel.endDate
            
        }
        
        set {
            dateModel.endDate = newValue
        }
        
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "E,MMM dd"
        return formatter
    }
    
    //  This checks whether the dateInList from the selectedDates array is the same day as the date passed to the function.
    func selectedDateContain(date: Date) -> Bool{
        if let _ = selectedDates.first(where: { dateInList in
            calendar.isDate(dateInList, inSameDayAs: date)
        }) {
            return true
        }
        return false
    }
    
    func selectedDatesFindIndex(date: Date) -> Int? {
        return selectedDates.firstIndex  { dateInList in
            calendar.isDate(dateInList, inSameDayAs: date)
        }
    }
    
    func disabledDatesContains(date: Date) -> Bool {
        if let _ = disabledDates.first(where: { dateInList in calendar.isDate(dateInList, inSameDayAs: date) }) {
            return true
        }
        return false
    }
    
    func disabledDatesFindIndex(date: Date) -> Int? {
        return disabledDates.firstIndex(where: { dateInList in calendar.isDate(dateInList, inSameDayAs: date) })
    }

    
}
