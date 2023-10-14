

import Foundation


extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfWeek: Date {
        var components = DateComponents()
        components.day = -7
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var yesterday : Date {
        var components = DateComponents()
        components.day = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    
}

func createPredicateForMonths(year: Int) -> [NSPredicate] {
    
   var predicates: [NSPredicate] = []
   let calender = Calendar.current
    
    for month in 1...12 {
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        let startDate = calender.date(from: startDateComponents)!
        let endDateComponents = DateComponents(year: year, month: month + 1, day: 1)
        let endDate = calender.date(from: endDateComponents)!
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@ ", startDate as NSDate, endDate as NSDate)
        
        predicates.append(predicate)
        
    }

    
    return predicates
}
