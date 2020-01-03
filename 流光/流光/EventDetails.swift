//
//  EventDetails.swift
//  FlowLight
//
//  Created by Layer on 2019/12/3.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

struct EventDetails: View {
    @ObservedObject var main: Main
    @State var confirmingCancel: Bool = false
    
    @State var showTypeActonSheet: Bool = false
    @State var showRemindActonSheet: Bool = false
    
    @State var isCover: Bool
    
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    if confirmingCancel {
                        Button(action: {
                            self.confirmingCancel = false
                        }) {
                            Text("继续编辑")
                                .padding()
                        }
                        Button(action: {
                            //UIApplication.shared.keyWindow?.endEditing(true)
                            self.confirmingCancel = false
                            self.main.eventEdit = false
                        }) {
                            Text("放弃修改")
                                .padding()
                        }

                    }
                    else {
                        Button(action: {//取消键
                            //关键盘和页面
                            if (!editingMode && self.main.eventEditTitle == "" ||
                                editingMode && editingEvent.title == self.main.eventEditTitle &&
                                editingEvent.date == self.main.eventEditDate) {
                                //UIApplication.shared.keyWindow?.endEditing(true)
                                self.main.eventEdit = false
                            } else {//用户确认
                                self.confirmingCancel = true
                            }
                        }) {
                            Image(systemName: "chevron.compact.left")
                            Text("取消")
                        }.padding()
                    }
                    Spacer()
                    if !confirmingCancel {
                        Button(action: {
                            //UIApplication.shared.keyWindow?.endEditing(true)
                            if self.isCover == true {
                                for event in self.main.events {
                                    event.isCover = false
                                }
                            }
                            if editingMode {
                                self.main.events[editingIndex].title = self.main.eventEditTitle
                                self.main.events[editingIndex].date = self.main.eventEditDate
                                self.main.events[editingIndex].type = self.main.eventEditType
                                self.main.events[editingIndex].note = self.main.eventEditNote
                                
                                self.main.eventEditIsCover = self.isCover
                                self.main.events[editingIndex].isCover = self.main.eventEditIsCover
                                
                                self.main.events[editingIndex].remind = self.main.eventEditRemind
                                self.main.events[editingIndex].checked = self.main.eventEditChecked
                            } else {
                                let newEvevt = Event(title: self.main.eventEditTitle, date: self.main.eventEditDate, type: self.main.eventEditType, note: self.main.eventEditNote, isCover: self.main.eventEditIsCover, remind: self.main.eventEditRemind)
                                newEvevt.num = self.main.events.count
                                self.main.events.append(newEvevt)
                            }
                            self.main.sort()
                            do {
                                try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.main.events, requiringSecureCoding: false), forKey: "events")
//                                try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.main, requiringSecureCoding: false), forKey: "main")
                            }
                            catch {
                                print("Error")
                            }
                            
                            self.confirmingCancel = false
                            self.main.eventEdit = false
                            self.main.eventShow = false //编辑完成后退出显示界面，因为直接刷新排序后展示页面被更改，会显示错误信息
                        }) {
                            if editingMode {
                                Text("完成")
                                    .padding()
                            } else {
                                Text("添加")
                                    .padding()
                            }
                        }.disabled(main.eventEditTitle == "")
                    }
                }//h
                HStack {
                    Text("标题：").padding()
                    TextField(editingMode == true ? self.main.eventEditTitle : "请在此输入标题" , text: $main.eventEditTitle).padding()
//                    SATextField(tag: 0, text: editingEvent.title, placeholder: "请在此输入标题", changeHandler: { (newString) in
//                        self.main.eventEditTitle = newString
//                    }) {
//                    }
//                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
//                    .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text("日期：").padding()
                    Spacer()
                }
                DatePicker(selection: $main.eventEditDate, displayedComponents: .date, label: { () -> EmptyView in }).padding()
                HStack {
                    Text("类型：").padding()
                    Spacer()
                    Button(action: {
                        self.showTypeActonSheet = true
                    }) {
                        Text(self.main.eventEditType)
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .actionSheet(isPresented: $showTypeActonSheet, content: {TypeSheet})
                    .foregroundColor(Color("todoItemTitle"))
                }
                HStack {
                    Text("备注：").padding()
                    TextField(editingMode == true ? (self.main.eventEditNote == "" ? "无" : self.main.eventEditNote) : "请在此输入备注", text: $main.eventEditNote).padding()
//                    SATextField(tag: 0, text: editingEvent.note, placeholder: "请在此输入备注", changeHandler: { (newString) in
//                        self.main.eventEditNote = newString
//                    }) {
//                    }
//                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
//                    .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    //Spacer()
                    
                    Toggle(isOn: $isCover) {
                        Text("封面：")
                    }.padding()
                }
                HStack {
                    Text("提醒：").padding()
                    Spacer()
                    Button(action: {
                        self.showRemindActonSheet = true
                    }) {
                        if self.main.eventEditRemind == 0 {
                            Text("从不提醒")
                        }
                        else if self.main.eventEditRemind == 1 {
                            Text("每日提醒")
                        }
                        else if self.main.eventEditRemind == 3 {
                            Text("每三日提醒")
                        }
                        else if self.main.eventEditRemind == 7 {
                            Text("每周提醒")
                        }
                        else {
                            Text("每月提醒")
                        }
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .actionSheet(isPresented: $showRemindActonSheet, content: {RemindSheet})
                    .foregroundColor(Color("todoItemTitle"))
                }
                if editingMode == true {//编辑模式下可删除
                    Button(action: {
                        print(editingIndex)
                        self.main.eventEdit = false
                        self.main.events.remove(at: editingIndex)
                        self.main.sort()
                        needUpdate = true
                        do {
                            let archivedData = try
                                NSKeyedArchiver.archivedData(withRootObject: self.main.events, requiringSecureCoding: false)
                            UserDefaults.standard.set(archivedData, forKey: "events")//存用户数据
                        } catch {
                            print("Error")
                        }
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("删除")
                                .padding()
                            }
                        }.foregroundColor(Color.red)
                    .padding()
                }
                Spacer()
            }//v
        }//z
    }
    
    private var TypeSheet: ActionSheet {
//        let action = ActionSheet(title: Text("类型"),
//                                 message: Text("请选择类型"),
//                                 buttons:
//            [.default(Text("默认"),action: {
//                self.main.eventEditType = "默认"
//                self.showTypeActonSheet = false
//            }),
//             .default(Text("生活"),action: {
//                self.main.eventEditType = "生活"
//                 self.showTypeActonSheet = false
//             }),
//             .default(Text("工作"),action: {
//                self.main.eventEditType = "工作"
//                 self.showTypeActonSheet = false
//             }),
//             .default(Text("学习"),action: {
//                self.main.eventEditType = "学习"
//                 self.showTypeActonSheet = false
//             }),
//            .cancel(Text("取消"), action: {
//                self.showTypeActonSheet = false
//            })
//        ])
//        return action
        if self.main.settings.typeList.count == 4 {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.eventEditType = "全部"
                    self.showTypeActonSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.eventEditType = "默认"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[1])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[2])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[3])"
                    self.showTypeActonSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.showTypeActonSheet = false
                 })
                ])
            return action
        }
        else if self.main.settings.typeList.count == 5 {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.eventEditType = "全部"
                    self.showTypeActonSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.eventEditType = "默认"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[1])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[2])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[3])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[4])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[4])"
                    self.showTypeActonSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.showTypeActonSheet = false
                 })
                ])
            return action
        }
        else if self.main.settings.typeList.count == 6 {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.eventEditType = "全部"
                    self.showTypeActonSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.eventEditType = "默认"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[1])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[2])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[3])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[4])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[4])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[5])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[5])"
                    self.showTypeActonSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.showTypeActonSheet = false
                 })
                ])
            return action
        }
        else {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.eventEditType = "全部"
                    self.showTypeActonSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.eventEditType = "默认"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[1])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[2])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[3])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[4])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[4])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[5])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[5])"
                    self.showTypeActonSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[6])"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[6])"
                    self.showTypeActonSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.main.eventEditType = "\(self.main.settings.typeList[7])"
                    self.showTypeActonSheet = false
                 })
                ])
            return action
        }
    }
    
    private var RemindSheet: ActionSheet {
        let action = ActionSheet(title: Text("提醒频率"),
                                 message: Text("请选择提醒频率"),
                                 buttons:
            [.default(Text("从不提醒"),action: {
                self.main.eventEditRemind = 0
                self.showRemindActonSheet = false
            }),
             .default(Text("每日提醒"),action: {
                self.main.eventEditRemind = 1
                 self.showRemindActonSheet = false
             }),
             .default(Text("每三日提醒"),action: {
                self.main.eventEditRemind = 3
                 self.showRemindActonSheet = false
             }),
             .default(Text("每周提醒"),action: {
                self.main.eventEditRemind = 7
                 self.showRemindActonSheet = false
             }),
             .default(Text("每月提醒"),action: {
                self.main.eventEditRemind = 30
                 self.showRemindActonSheet = false
             }),
            .cancel(Text("取消"), action: {
                self.showRemindActonSheet = false
            })
        ])
        return action
    }
    
}

struct EventDetails_Previews: PreviewProvider {
    static var previews: some View {
        EventDetails(main: Main(), isCover: true)
    }
}
