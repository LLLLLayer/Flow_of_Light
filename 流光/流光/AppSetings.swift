//
//  AppSetings.swift
//  FlowLight
//
//  Created by Layer on 2019/12/6.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

struct AppSetings: View {
    @ObservedObject var main: Main      //被观察者
    @State var showCover = true
    @State var doRemind = false
    
    @State var alertShow = false //未完成功能提示
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.main.appSet = false
                }) {
                    Image(systemName: "chevron.compact.left")
                    Text("返回")
                }.padding()
                Spacer()
                Text("设置")
                Spacer()
                Button(action: {
                    self.main.goHelp = true
                }) {
                    Image(systemName: "lightbulb")
                }.padding()
                    .sheet(isPresented: $main.goHelp, content: { Help(main: self.main) } )
            }
            List {
                HStack {//主题
                    Image(systemName: "paintbrush")
                    Text("主题")
                    Spacer()
                    Button(action: {
                        self.alertShow = true
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .alert(isPresented: $alertShow, content: {
                        Alert(title: Text("抱歉"),
                              message: Text("作者偷懒啦！相关功能还在完善中..."),
                              primaryButton: .destructive(Text("OK")) { print("QAQ") },
                              secondaryButton: .cancel())
                    })
                }
                HStack {//排序
                    Image(systemName: "list.dash")
                    Text("排序")
                    Spacer()
                    Button(action: {
                        self.alertShow = true
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .alert(isPresented: $alertShow, content: {
                        Alert(title: Text("抱歉"),
                              message: Text("作者偷懒啦！相关功能还在完善中..."),
                              primaryButton: .destructive(Text("OK")) { print("QAQ") },
                              secondaryButton: .cancel())
                    })
                }
                HStack {//分类
                    Image(systemName: "tag")
                    Text("分类")
                    Spacer()
                    Button(action: {
                        print(self.main.settings.typeList)
                        self.main.goTypeSet = true
                    }) {
                        Image(systemName: "chevron.right")
                    }.sheet(isPresented: $main.goTypeSet, content: { TypeSet(main: self.main, nowTypeList: self.main.settings.typeList) } )
                }
                HStack {//提醒
                    Image(systemName: "bell")
                    Text("提醒")
                    Spacer()
                    Button(action: {
                        self.alertShow = true
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .alert(isPresented: $alertShow, content: {
                        Alert(title: Text("抱歉"),
                              message: Text("作者偷懒啦！相关功能还在完善中..."),
                              primaryButton: .destructive(Text("OK")) { print("QAQ") },
                              secondaryButton: .cancel())
                    })
                }
                HStack {//封面
                     Toggle(isOn: $showCover) {
                         Image(systemName: "flag")
                         Text("封面显示")
                     }
                 }
                 HStack {//提醒
                     Toggle(isOn: $doRemind) {
                         Image(systemName: "alarm")
                         Text("提醒开关")
                     }
                 }
                HStack {//备份
                    Image(systemName: "icloud.and.arrow.up")
                    Text("备份到iCloud")
                    Spacer()
                    Button(action: {
                        self.alertShow = true
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .alert(isPresented: $alertShow, content: {
                        Alert(title: Text("抱歉"),
                              message: Text("作者偷懒啦！相关功能还在完善中..."),
                              primaryButton: .destructive(Text("OK")) { print("QAQ") },
                              secondaryButton: .cancel())
                    })
                }
                HStack {//恢复
                    Image(systemName: "icloud.and.arrow.down")
                    Text("从iCloud恢复")
                    Spacer()
                    Button(action: {
                        self.alertShow = true
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .alert(isPresented: $alertShow, content: {
                        Alert(title: Text("抱歉"),
                              message: Text("作者偷懒啦！相关功能还在完善中..."),
                              primaryButton: .destructive(Text("OK")) { print("QAQ") },
                              secondaryButton: .cancel())
                    })
                }
                HStack {//密码保护
                    Image(systemName: "lock.shield")
                    Text("密码保护")
                    Spacer()
                    Button(action: {
                        self.alertShow = true
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .alert(isPresented: $alertShow, content: {
                        Alert(title: Text("抱歉"),
                              message: Text("作者偷懒啦！相关功能还在完善中..."),
                              primaryButton: .destructive(Text("OK")) { print("QAQ") },
                              secondaryButton: .cancel())
                    })

                }
                HStack {//评价
                    Image(systemName: "heart")
                    Text("在App Store上评价")
                    Spacer()
                    Button(action: {
                        self.alertShow = true
                    }) {
                        Image(systemName: "chevron.right")
                    }
                    .alert(isPresented: $alertShow, content: {
                        Alert(title: Text("抱歉"),
                              message: Text("作者偷懒啦！相关功能还在完善中..."),
                              primaryButton: .destructive(Text("OK")) { print("QAQ") },
                              secondaryButton: .cancel())
                    })
                }
            }
            Spacer()
        }
        
    }
}

struct AppSetings_Previews: PreviewProvider {
    static var previews: some View {
        AppSetings(main: Main())
    }
}
