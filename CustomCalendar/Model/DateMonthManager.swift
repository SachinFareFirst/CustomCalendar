//
//  DateMonthManager.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import SwiftUI

class DateMonthManager {
    
    
    var datePickerViewModel: DatePickerViewModel
    let monthOffset: Int
    let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    var offset = DateComponents()
    var monthsArray: [[Date]] {
        //print(monthArray())
        return monthArray()
        
    }
    let cellWidth = UIScreen.main.bounds.width/9
 
    
  //  private let indiaLocale = Locale(identifier: "en_IN")
    
    init(datePickerViewmModel: DatePickerViewModel, monthOffset: Int) {
        self.datePickerViewModel = datePickerViewmModel
        self.monthOffset = monthOffset
        offset.calendar?.locale = .current
    }
    
//    func formatDate(of date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.locale = .current
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
//        return formatter.string(from: date)
//    }

    func isThisMonth(date: Date) -> Bool {
        return self.datePickerViewModel.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
    }
   
   func dateTapped(date: Date) {
       if self.isEnabled(date: date) {
           switch self.datePickerViewModel.mode {
               
           case 0:
               if self.datePickerViewModel.selectedDate != nil &&
                    self.datePickerViewModel.calendar.isDate(self.datePickerViewModel.selectedDate ?? Date(), inSameDayAs: date) {
                   self.datePickerViewModel.selectedDate = nil
               } else {
                   self.datePickerViewModel.selectedDate = date
               }
           case 1:
               self.datePickerViewModel.startDate = date
               self.datePickerViewModel.endDate = nil
               self.datePickerViewModel.mode = 2
           case 2:

               self.datePickerViewModel.endDate = date
               if self.isStartDateAfterEndDate() {
                   self.datePickerViewModel.endDate = nil
                   self.datePickerViewModel.startDate = nil
               }
               self.datePickerViewModel.mode = 1
//           case 3:
//               if self.rkManager.selectedDateContain(date: date) {
//                   if let ndx = self.rkManager.selectedDatesFindIndex(date: date) {
//                       rkManager.selectedDates.remove(at: ndx)
//                   }
//               } else {
//                   self.rkManager.selectedDates.append(date)
//               }
               
           default:
               self.datePickerViewModel.selectedDate = date
           }
       }
   }
    
   func monthArray() -> [[Date]] {
       var rowArray = [[Date]]()
       //print(numberOfDays())
       for row in 0 ..< (numberOfDays() / 7) {
           var columnArray = [Date]()
           for column in 0 ... 6 {
               let dateIndex = self.getDateAtIndex(index: (row * 7) + column)
               // print(row)
               columnArray.append(dateIndex)
           }
           rowArray.append(columnArray)
       }
       return rowArray
   }
   
   func getMonthHeader() -> String {
       let headerDateFormatter = DateFormatter()
       headerDateFormatter.calendar = datePickerViewModel.calendar
       headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: datePickerViewModel.calendar.locale)
       return headerDateFormatter.string(from: firstOfMonthForOffset()).uppercased()
   }
   
   func getDateAtIndex(index: Int) -> Date {
       
       let firstOfMonth = firstOfMonthForOffset()
       let weekday = datePickerViewModel.calendar.component(.weekday, from: firstOfMonth)
       var startOffset = weekday - datePickerViewModel.calendar.firstWeekday
       startOffset += startOffset >= 0 ? 0 : 7
       var dateComponents = DateComponents()
       dateComponents.calendar?.locale = .current
       dateComponents.day = index - startOffset
       return datePickerViewModel.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
   }
   
   func numberOfDays() -> Int {
       
       let firstOfMonth = firstOfMonthForOffset()
       guard let rangeOfWeeks = datePickerViewModel.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth) else {
          return 0
       }
       return (rangeOfWeeks.count) * 7
   }
   
   func firstOfMonthForOffset() -> Date {

       //offset.calendar = rkManager.calendar
       offset.month = monthOffset
      // print(rkManager.calendar.date(byAdding: offset, to: firstDateMonth()),"firstMonthForOffser")
       return datePickerViewModel.calendar.date(byAdding: offset, to: firstDateMonth())!
   }
   
   func formatDate(date: Date) -> Date {
       let components = datePickerViewModel.calendar.dateComponents(calendarUnitYMD, from: date)
       return datePickerViewModel.calendar.date(from: components)!
   }
   
   func formatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
       let refDate = formatDate(date: referenceDate)
       let clampedDate = formatDate(date: date)
       return refDate == clampedDate
   }
   
   func firstDateMonth() -> Date {
       var components = datePickerViewModel.calendar.dateComponents(calendarUnitYMD, from: datePickerViewModel.minimumDate)
       components.day = 1
       guard let firstDateMonth = datePickerViewModel.calendar.date(from: components) else {
           return Date()
       }
     //  print(firstDateMonth)
       return firstDateMonth
       
   }
   
   // MARK: - Date Property Checkers
   
   func isToday(date: Date) -> Bool {
       return formatAndCompareDate(date: date, referenceDate: Date())
   }
    
   func isSpecialDate(date: Date) -> Bool {
       return isSelectedDate(date: date) ||
           isStartDate(date: date) ||
           isEndDate(date: date) ||
           isOneOfSelectedDates(date: date)
   }
   
   func isOneOfSelectedDates(date: Date) -> Bool {
       return self.datePickerViewModel.selectedDateContain(date: date)
   }

   func isSelectedDate(date: Date) -> Bool {
       if datePickerViewModel.selectedDate == nil {
           return false
       }
      // print(rkManager.selectedDate,"selec")
       return formatAndCompareDate(date: date, referenceDate: datePickerViewModel.selectedDate ?? Date())
   }
   
   func isStartDate(date: Date) -> Bool {
       if datePickerViewModel.startDate == nil {
           return false
       }
       return formatAndCompareDate(date: date, referenceDate: datePickerViewModel.startDate ?? Date())
   }
   
   func isEndDate(date: Date) -> Bool {
       if datePickerViewModel.endDate == nil {
           return false
       }
       return formatAndCompareDate(date: date, referenceDate: datePickerViewModel.endDate ?? Date())
   }
   
   func isBetweenStartAndEnd(date: Date) -> Bool {
       if datePickerViewModel.startDate == nil {
           return false
       } else if datePickerViewModel.endDate == nil {
           return false
       } else if datePickerViewModel.calendar.compare(date, to: datePickerViewModel.startDate ?? Date(), toGranularity: .day) == .orderedAscending {
           return false
       } else if datePickerViewModel.calendar.compare(date, to: datePickerViewModel.endDate ?? Date(), toGranularity: .day) == .orderedDescending {
           return false
       }
       return true
   }
   
   func isOneOfDisabledDates(date: Date) -> Bool {
       return self.datePickerViewModel.disabledDatesContains(date: date)
   }
   
   func isEnabled(date: Date) -> Bool {
       let clampedDate = formatDate(date: date)
       if datePickerViewModel.calendar.compare(clampedDate, to: datePickerViewModel.minimumDate, toGranularity: .day) == .orderedAscending || datePickerViewModel.calendar.compare(clampedDate, to: datePickerViewModel.maximumDate, toGranularity: .day) == .orderedDescending {
           return false
       }
       return !isOneOfDisabledDates(date: date)
   }
   
   func isStartDateAfterEndDate() -> Bool {
      
       if datePickerViewModel.startDate == nil {
           return false
       } else if datePickerViewModel.endDate == nil {
           return false
       }
       
       //MARK: comparing 2 dates with precision of day
       else if datePickerViewModel.calendar.compare(datePickerViewModel.endDate ?? Date(), to: datePickerViewModel.startDate ?? Date(), toGranularity: .day) == .orderedDescending {
           return false
       }
       return true
   }
}
