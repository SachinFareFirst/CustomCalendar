//
//  DatePickerView.swift
//  CustomCalendar
//
//  Created by Sachin H K on 21/11/24.
//

import SwiftUI
import Foundation

struct DatePickerView: View {
    
    var datePickerViewModel = DatePickerViewModel(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365),mode: 1)
    
    var body: some View {
        VStack (spacing:0){
                HStack {
                    ForEach(getWeekdayHeaders(calendar: datePickerViewModel.calendar), id: \.self) {
                        weekday in
                        Text(weekday)
                            .font(.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width/8)
                            .foregroundStyle(datePickerViewModel.colors.weekdayHeaderColor)
                        
                    }
                }
                .padding(.vertical)
                .background(Rectangle().fill((datePickerViewModel.colors.textBackColor)))
                
                ScrollView {
                    ForEach( 0..<numberOfMonths()) {
                        index in
                        DateMonthView(monthVM: DateMonthManager(datePickerViewmModel: datePickerViewModel, monthOffset: index)).environmentObject(datePickerViewModel)
                    }
                }
            }
    }
    
    func numberOfMonths() -> Int {
        return (datePickerViewModel.calendar.dateComponents([.month], from: datePickerViewModel.minimumDate, to: maximumDateMonthLastDay()).month ?? 0) + 1
    }
    
    func maximumDateMonthLastDay() -> Date {
        
        var components = datePickerViewModel.calendar.dateComponents([.year, .month, .day], from: datePickerViewModel.maximumDate)
            
        components.month = (components.month ?? 0) + 1
            components.day = 0
        
        return datePickerViewModel.calendar.date(from: components) ?? Date()
    }

    func getWeekdayHeaders(calendar: Calendar) -> [String] {
        let formatter = DateFormatter()
        //Gives every week in short form in a string
        var weekdaySymbols = formatter.shortWeekdaySymbols
        let weekdaySymbolsCount = weekdaySymbols?.count ?? 0
        
        for _ in 0 ..< (1 - calendar.firstWeekday + weekdaySymbolsCount) {
            guard let lastObject = weekdaySymbols?.last else {
                return [String()]
            }
            weekdaySymbols?.removeLast()
            weekdaySymbols?.insert(lastObject, at: 0)
        }
        return weekdaySymbols ?? []
    }
}


#Preview {
    DatePickerView()
}
