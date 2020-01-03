//
//  EventItem.swift
//  FlowLight
//
//  Created by Layer on 2019/12/3.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

class Event: NSObject, NSSecureCoding, Identifiable {
    static var supportsSecureCoding: Bool = true
    //每个事件
//    class Event: NSObject, NSCoding, Identifiable {     //每个事件
    var title: String = ""              //标题
    var date: Date = Date()             //日期
    var type: String = "默认"            //分类
    var note: String = ""               //备注
    var isCover: Bool = false           //封面
    var remind: Int = 0                 //提醒
    var num: Int = 0                    //排序
    var checked: Bool = false           //选中
    
    init(title: String, date: Date, type: String, note: String, isCover: Bool, remind:Int) {
        self.title = title
        self.date = date
        self.type = type
        self.note = note
        self.isCover = isCover
        self.remind = remind
    }

    func encode(with coder: NSCoder) {//压缩
        coder.encode(self.title, forKey: "title")
        coder.encode(self.date, forKey: "date")
        coder.encode(self.type, forKey: "type")
        coder.encode(self.note, forKey: "note")
        coder.encode(self.isCover, forKey: "isCover")
        coder.encode(self.remind, forKey: "remind")
//        coder.encode(self.num, forKey: "num")
        coder.encode(self.checked, forKey: "checked")
        }
        
    required init(coder: NSCoder) {//解压
        self.title = coder.decodeObject(forKey: "title") as? String ?? "ErrorTitle"
        self.date = coder.decodeObject(forKey: "date") as? Date ?? Date()
        self.type = coder.decodeObject(forKey: "type") as? String ?? "ErrorType"
        self.note = coder.decodeObject(forKey: "note") as? String ?? "ErrorNote"
        //我也不知道为啥Bool解压必须指定否则记录不了
        self.isCover = coder.decodeBool(forKey: "isCover") //as? Bool ?? false
        self.remind = coder.decodeObject(forKey: "remind") as? Int ?? 0
//        self.num = coder.decodeObject(forKey: "num") as? Int ?? 0
        self.checked = coder.decodeBool(forKey: "checked") //as? Bool ?? false
        }
}

var emptyEvent: Event = Event(title: "", date: Date(), type: "默认", note: "", isCover: false, remind: 0)

struct EventItem: View {
    @ObservedObject var main: Main      //被观察者
    @Binding var eventIndex: Int        //界面跳转数据绑定
    @State var checked: Bool = false    //是否被选中
    @State var offsetX: Bool = false    //是否偏移
    var body: some View {
        HStack {
            Button(action: {
                showMode = true//展示模式
                            
                //editingMode = true                                //编辑模式打开
                editingEvent = self.main.events[self.eventIndex]    //参数传递
                editingIndex = self.eventIndex                      //参数传递
                
                self.main.eventEditTitle = editingEvent.title
                self.main.eventEditDate = editingEvent.date
                self.main.eventEditType = editingEvent.type
                self.main.eventEditNote = editingEvent.note
                self.main.eventEditIsCover = editingEvent.isCover
                self.main.eventEditRemind = editingEvent.remind
                self.main.eventEditChecked = editingEvent.checked

                self.checked = self.main.eventEditChecked
                self.main.eventEditChecked = self.checked
                
                editingMode = true
//                self.main.eventEdit = true
                self.main.eventShow = true
//                needUpdate = true
                //print(self.checked)
            }) {
                HStack {
                    VStack {//最左矩形
                        Rectangle()
                            .fill(Color("theme"))
                            .frame(width: 8)
                    }
                    Spacer()
                        .frame(width: 10)
                    VStack {//中间显示
                        Spacer()
                            .frame(width: 12)
                        HStack {//中间标题
                            Text(main.events[eventIndex].title)
                                .font(Font.headline)
                                .foregroundColor(Color("todoItemTitle"))
                            Spacer()
                        }
                        Spacer()
                            .frame(width: 4)
                        HStack {//中间时间
                            Image(systemName: "clock")
                            .resizable()
                            .frame(width: 12, height: 12)
                            Text(formatter.string(from: self.main.events[eventIndex].date))
                                .font(.subheadline )
                            Spacer()
                        }.foregroundColor(Color("todoItemSubTitle"))
                        Spacer()
                            .frame(height: 12)
                    }
                }
            }
//            .sheet(isPresented: $main.eventEdit, content: {
//                EventShow(main: self.main)
//            })
            Button(action: {//最右选择侧框
                self.offsetX.toggle()
            }) {
                HStack {
                    Spacer()
                        .frame(width: 12)
                    VStack {
                        Spacer()
//                        Image(systemName: self.checked ? "checkmark.square.fill" : "square")
//                            .resizable()
//                            .frame(width: 24, height: 24)
                        Text(days(Date(), self.main.events[self.eventIndex].date))
                            .offset(x: self.offsetX ? 63 : 0)
                            .padding()
                        Spacer()
                    }
                    Spacer()
                        .frame(width: 12)
                }
            }.onAppear {
                self.checked = self.main.events[self.eventIndex].checked
            }
            if self.offsetX {
                Button(action: {
                    self.main.events[self.eventIndex].checked.toggle()
                    self.checked = self.main.events[self.eventIndex].checked
                    do {
                        let archivedData = try
                            NSKeyedArchiver.archivedData(withRootObject: self.main.events, requiringSecureCoding: false)
                        UserDefaults.standard.set(archivedData, forKey: "events")//存用户数据
//                        let archivedData = try
//                            NSKeyedArchiver.archivedData(withRootObject: self.main, requiringSecureCoding: false)
//                        UserDefaults.standard.set(archivedData, forKey: "main")//存用户数据
                    } catch {
                        print("Error")
                    }
                    self.offsetX.toggle()
                }) {
                    Text("标记").padding()
                        .foregroundColor(Color.red)
                        .animation(.easeIn)
                    
                }.offset(x: 64)
            }
        }.background(Color(self.checked ? "todoItem-bg-checked" : "todoItem-bg"))
            .animation(.spring())//无脑动画
            .offset(x: self.offsetX ? -66 : 0)
            .onAppear() {
                self.checked = self.main.events[self.eventIndex].checked
        }
    }
}

struct EventItem_Previews: PreviewProvider {
    static var previews: some View {
        EventItem(main: Main(), eventIndex: .constant(0))
    }
}

func days(_ Date1: Date, _ Date2: Date) -> String {//倒计时
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
    if components.day! >= 0 {
        return String("还有 " + String(components.day!) + " 天" )
    }
    else {
        return String("已过 " + String(0 - components.day!) + " 天" )
    }
}
