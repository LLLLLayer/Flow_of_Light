//
//  Home.swift
//  FlowLight
//
//  Created by Layer on 2019/12/3.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

var showMode: Bool = false          //展示模式开关
var editingMode: Bool = false       //编辑模式开关

var editingEvent: Event = emptyEvent//正在编辑的事件的备份
var editingIndex: Int = 0           //正在编辑的事件的编号
var needUpdate: Bool = false         //更新

class Main: ObservableObject {
    //监听
    @Published var events: [Event] = []         //@Published监听变化实时更新
    
    @Published var eventShow: Bool = false      //是否显示详细事件
    @Published var eventEdit: Bool = false      //是否显示编辑事件
    
    @Published var  appSet: Bool = false          //系统设置
    //被编辑事件
    @Published var eventEditTitle: String = ""
    @Published var eventEditDate: Date = Date()
    @Published var eventEditType: String = "默认"
    @Published var eventEditNote: String = ""
    @Published var eventEditIsCover: Bool = false
    @Published var eventEditRemind: Int = 0
    
    @Published var eventEditChecked: Bool = false

    @Published var curType: String = "全部"
    
    //设置相关的变量
    @Published var goHelp: Bool = false
    @Published var goTypeSet: Bool = false
    @Published var settings:userSeting = userSeting([])
    
    @Published var predate = ""
    
    
    
    func sort() {//自定义日期排序
        self.events.sort(by: {
            $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970
        })
        for i in 0..<self.events.count {//排序赋值
            self.events[i].num = i
        }
    }
}

class userSeting: NSObject, NSSecureCoding, Identifiable {
    static var supportsSecureCoding: Bool = true
    
    var typeList: [String] = ["默认","生活","工作","学习"]
    
    init(_ setStr: [String]) {
        self.typeList = setStr
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.typeList, forKey: "typeList")
    }
    
    required init(coder: NSCoder) {
        self.typeList = coder.decodeObject(forKey: "typeList") as? [String] ?? ["默认","生活","工作","学习"]
    }
}

struct Home: View {
    @ObservedObject var main: Main
    var body: some View {
        VStack {
            Title(main: self.main)
            EventCover(main: self.main)
            EventList(main: self.main)
        }.onAppear {
        // ios12.0.0+被移除的方法，更新一下
        //                if let data = UserDefaults.standard.object(forKey: "events") as? Data {
        //                    let eventlist = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Event] ?? []
        //                    for event in eventlist {
        //                    self.main.events.append(event)
        //                    }
        //                    self.main.sort()
        //                } else {
        //                    self.main.events = exampleEvents
        //                    self.main.sort()
        //                    }
            if let data = UserDefaults.standard.object(forKey: "events") as? Data {
                do{
                    if let eventlist = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Event] {
                        for event in eventlist {
                            self.main.events.append(event)
                        }
                        self.main.sort()
                    }
                } catch {
                    print("Error")
                }
            }
            else {
                self.main.events = exampleEvents
                self.main.sort()
            }
        //系统设置的恢复
            if let data = UserDefaults.standard.object(forKey: "typeList") as? Data {
                do{
                    if let typeList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
                        self.main.settings.typeList = typeList
                    }
                } catch {
                    print("Error:typeList")
                }
                }
            else {
                self.main.settings.typeList = ["默认","生活","工作","学习","爱情"]
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(main: Main())
    }
}
