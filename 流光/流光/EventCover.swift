//
//  EventCover.swift
//  FlowLight
//
//  Created by Layer on 2019/12/5.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

struct EventCover: View {
    @ObservedObject var main: Main
    
    static let coverDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
        formatter.dateStyle = .long
    return formatter
    }()
    
    var body: some View {
        Button(action: {
            editingEvent = self.main.events[show(self.main.events)]//传递
            editingIndex = show(self.main.events)
            
            self.main.eventEditTitle = editingEvent.title
            self.main.eventEditDate = editingEvent.date
            self.main.eventEditType = editingEvent.type
            self.main.eventEditNote = editingEvent.note
            self.main.eventEditIsCover = editingEvent.isCover
            self.main.eventEditRemind = editingEvent.remind
            self.main.eventEditChecked = editingEvent.checked

            editingMode = true
            
            self.main.eventShow = true//打开页面
        }){
            VStack {
                if show(self.main.events) != -1 {//存在可显示封面
                    if coverDays(Date(), self.main.events[show(self.main.events)].date) >= 0 {
                        HStack {
                            Text("还有").offset(y: 50)
                            Text(coverDaysString(Date(), self.main.events[show(self.main.events)].date))
                                .font(.system(size: 150))
                            Text("天").offset(y: 50)
                        }.frame(width: UIScreen.main.bounds.width)
                    }
                    else {
                        HStack {
                            Text("已过").offset(y: 50)
                            Text(coverDaysString(Date(), self.main.events[show(self.main.events)].date))
                                    .font(.system(size: 150))
                            Text("天").offset(y: 50)
                        }.frame(width: UIScreen.main.bounds.width)
                    }
                    Text(self.main.events[show(self.main.events)].title).padding().frame(width: UIScreen.main.bounds.width)
                    Text("\(self.main.events[show(self.main.events)].date, formatter: Self.coverDateFormatter)")
                    Spacer().frame(height: 50)
                }
            }.offset(y: -20)
            .foregroundColor(Color("todoItemTitle"))
                .sheet(isPresented: $main.eventShow, content: {EventShow(main: self.main)})
        }
    }
}

struct EventCover_Previews: PreviewProvider {
    static var previews: some View {
        EventCover(main: Main())
    }
}

func show(_ events: [Event]) -> Int{
    for i in 0..<events.count {
        //print(i)
        if events[i].isCover == true {
            return i
        }
    }
    return -1
}

func coverDays(_ Date1: Date, _ Date2: Date) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date1 = dateFormatter.date(from: dateFormatter.string(from: Date1))
    let date2 = dateFormatter.date(from: dateFormatter.string(from: Date2))
    guard date1 != nil, date2 != nil else {
                return -1
    }
    let components = NSCalendar.current.dateComponents([.day], from: date1!, to: date2!)
    guard components.day != nil else {
                return -1
    }
    return components.day!
}

func coverDaysString(_ Date1: Date, _ Date2: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date1 = dateFormatter.date(from: dateFormatter.string(from: Date1))
    let date2 = dateFormatter.date(from: dateFormatter.string(from: Date2))
    guard date1 != nil, date2 != nil else {
                return "Error"
    }
    let components = NSCalendar.current.dateComponents([.day], from: date1!, to: date2!)
    guard components.day != nil else {
                return "Error"
    }
    if components.day! >= 0{
        return String(components.day!)
    }
    else {
        return String(0 - components.day!)
    }
}
