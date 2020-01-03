//
//  Title.swift
//  FlowLight
//
//  Created by Layer on 2019/12/3.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

struct Title: View {
    @ObservedObject var main: Main
    @State var showSheet = false
    var Size: CGFloat = 30
    var body: some View {
        HStack {
            Button(action: {//设置键
                self.main.appSet = true //打开设置
                        }) {
                ZStack {
                    Group {
                        Circle()
                            .fill(Color("btnAdd-bg"))
                        }.frame(width: self.Size, height: self.Size)
                    Group {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: self.Size, height: self.Size)
                            .foregroundColor(Color("theme"))
                    }
                }
            }
            .sheet(isPresented: $main.appSet, content: {AppSetings(main: self.main)})
            .padding()
            
            Spacer()
            Button(action: {//分类键
                self.showSheet = true
            }) {
                VStack {
                    Text("流光")
                        .font(.headline)
                        .fontWeight(.ultraLight)
                        .foregroundColor(Color("todoItemTitle"))
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color("theme"))
                }
            }.actionSheet(isPresented: $showSheet, content: { typeSheet })
            Spacer()
            Button(action: {//添加键
                editingMode = false
                editingEvent = emptyEvent
                needUpdate = true
                self.main.eventEditTitle = ""
                self.main.eventEditDate = Date()
                self.main.eventEditType = "默认"
                self.main.eventEditNote = ""
                self.main.eventEditIsCover = false
                self.main.eventEditRemind = 0
                self.main.eventEdit = true
            }){
                ZStack {
                    Group {
                        Circle()
                            .fill(Color("btnAdd-bg"))
                        }.frame(width: self.Size, height: self.Size)
                    Group {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: self.Size, height: self.Size)
                            .foregroundColor(Color("theme"))
                    }
                }
            }.padding()
            .sheet(isPresented: $main.eventEdit, content: {
                EventDetails(main: self.main, isCover: editingMode == true ? self.main.eventEditIsCover : false)
            })
        }
    }
    private var typeSheet: ActionSheet {
//        let action = ActionSheet(title: Text("类型"),
//                                 message: Text("请选择显示日程的类型"),
//                                 buttons:
//            [
//             .default(Text("全部"), action: {
//                self.main.curType = "全部"
//                self.showSheet = false
//                }),
//             .default(Text("默认"), action: {
//                self.main.curType = "默认"
//                self.showSheet = false
//             }),
//             .default(Text("生活"), action: {
//                self.main.curType = "生活"
//                self.showSheet = false
//             }),
//             .default(Text("工作"), action: {
//                self.main.curType = "工作"
//                self.showSheet = false
//             }),
//             .default(Text("学习"), action: {
//                self.main.curType = "学习"
//                self.showSheet = false
//             }),
//             .cancel(Text("取消"), action: {
//                self.showSheet = false
//             })
//            ])
        //写下改变
        if self.main.settings.typeList.count == 4 {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.curType = "全部"
                    self.showSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.curType = "默认"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[1])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[2])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[3])"
                    self.showSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.showSheet = false
                 })
                ])
            print(self.main.curType)
            return action
        }
        else if self.main.settings.typeList.count == 5 {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.curType = "全部"
                    self.showSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.curType = "默认"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[1])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[2])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[3])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[4])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[4])"
                    self.showSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.showSheet = false
                 })
                ])
            print(self.main.curType)
            return action
        }
        else if self.main.settings.typeList.count == 6 {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.curType = "全部"
                    self.showSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.curType = "默认"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[1])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[2])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[3])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[4])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[4])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[5])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[5])"
                    self.showSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.showSheet = false
                 })
                ])
            print(self.main.curType)
            return action
        }
        else {
            let action = ActionSheet(title: Text("类型"),
                                     message: Text("请选择显示日程的类型"),
                                     buttons:
                [
                 .default(Text("全部"), action: {
                    self.main.curType = "全部"
                    self.showSheet = false
                    }),
                 .default(Text("默认"), action: {
                    self.main.curType = "默认"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[1])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[1])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[2])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[2])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[3])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[3])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[4])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[4])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[5])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[5])"
                    self.showSheet = false
                 }),
                 .default(Text("\(self.main.settings.typeList[6])"), action: {
                    self.main.curType = "\(self.main.settings.typeList[6])"
                    self.showSheet = false
                 }),
                 .cancel(Text("取消"), action: {
                    self.showSheet = false
                 })
                ])
            print(self.main.curType)
            return action
        }
//        return action
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(main: Main())
    }
}
