//
//  Extension.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import SwiftUI

struct Extension {
    
    
    var date: Date
    var dateManager: DatePickerViewModel
    
    var isDisabled: Bool = false
    var isToday: Bool = false
    var isSelected: Bool = false
    var isBetweenStartAndEnd: Bool = false
    
    func getText() -> String {
        
        let day = formatDate(date: date, calendar: dateManager.calendar)
        return day
       
    }
    
    func getTextColor() -> Color {
        var textColor = dateManager.colors.textColor
        if isDisabled {
            textColor = dateManager.colors.disabledColor
        }
        else if isSelected {
            textColor = dateManager.colors.selectedColor
        }
        else if isToday {
            textColor = dateManager.colors.todayColor
        }
        else if isBetweenStartAndEnd {
            textColor = dateManager.colors.betweenStartAndEndColor
        }
        return textColor
    }
    
    func getBackgroundColor() -> Color {
        var backgroundColor = dateManager.colors.textBackColor
        if isBetweenStartAndEnd {
            backgroundColor = dateManager.colors.betweenStartAndEndBackColor
        }
        if isToday {
            backgroundColor = dateManager.colors.todayBackColor
        }
        if isDisabled {
            backgroundColor = dateManager.colors.disabledBackColor
        }
        if isSelected {
            
            backgroundColor = dateManager.colors.selectedBackColor
            //print("background ",backgroundColor)
        }
        return backgroundColor
    }
    
    func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.light
        if isDisabled {
            fontWeight = Font.Weight.thin
        } else if isSelected {
            fontWeight = Font.Weight.medium
        } else if isToday {
            fontWeight = Font.Weight.medium
        } else if isBetweenStartAndEnd {
            fontWeight = Font.Weight.medium
        }
        return fontWeight
    }
    
    func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringForm(date: date, formatter: formatter, calendar: calendar)
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }
    
    
    func stringForm(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar == calendar {
            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }
    
}
