//
//  EventList.swift
//  FlowLight
//
//  Created by Layer on 2019/12/3.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

var exampleEvents: [Event] = [
    Event(title: "Christmas", date: Date(), type: "默认", note: "Merry Christmas!", isCover: true, remind: 0),
    Event(title: "New Year's Day", date: Date(), type: "默认", note: "Happy New Year！", isCover: false, remind: 0),
    Event(title: "My birthday", date: Date().addingTimeInterval(200000), type: "默认", note: "", isCover: false, remind: 0),
    Event(title: "Her birthday", date: Date().addingTimeInterval(200000), type: "默认", note: "", isCover: false, remind: 0),
    Event(title: "Anniversary", date: Date().addingTimeInterval(500000), type: "默认", note: "", isCover: false, remind: 0)
]

struct EventList: View {
    @ObservedObject var main: Main
    var body: some View {
//        NavigationView {
        VStack {
            ScrollView {//滚动查看
                ForEach(self.main.events) { event in
//                ForEach(self.main.eventsCopy) { event in
//                    if (self.main.curType == "全部" ? true : (event.type == self.main.curType)) {
                    if (self.main.curType == "全部") {
                        VStack {//小日期标题
                                if event.num == 0 || formatter.string(from: self.main.events[event.num].date) != formatter.string(from: self.main.events[event.num - 1].date) {
                                        HStack {
                                            Spacer().frame(width: 30)
                                            Text(date2Word(date: self.main.events[event.num].date))
                                            Spacer()
                                        }
                                    }
                                    HStack {//显示事件
                                        Spacer().frame(width: 10)
                                        EventItem(main: self.main, eventIndex: .constant(event.num))
                                            .cornerRadius(10)
                                            .clipped()
                                            .shadow(color: Color("todoItemShadow"), radius: 5)
                                        Spacer().frame(width: 10)
                                    }
                                    Spacer().frame(height: 10)
                            }
                    }
                    else if(event.type == self.main.curType) {
                        VStack {
                                    HStack {//小日期标题
                                        Spacer().frame(width: 30)
                                        Text(date2Word(date: self.main.events[event.num].date))
                                        Spacer()
                                    }
                            }
                                    HStack {//显示事件
                                        Spacer().frame(width: 10)
                                        EventItem(main: self.main, eventIndex: .constant(event.num))
                                            .cornerRadius(10)
                                            .clipped()
                                            .shadow(color: Color("todoItemShadow"), radius: 5)
                                        Spacer().frame(width: 10)
                                    }
                                    Spacer().frame(height: 10)
                    }
                }
                Spacer().frame(height: 10)
                HStack {
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList(main: Main())
    }
}
