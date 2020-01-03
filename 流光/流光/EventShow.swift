//
//  EventShow.swift
//  FlowLight
//
//  Created by Layer on 2019/12/3.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

struct EventShow: View {
    @ObservedObject var main: Main      //被观察者
    //@Binding var eventIndex: Int        //界面跳转数据绑定
    
    static let coverDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
        formatter.dateStyle = .long
    return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                //标题
                Button(action: {//返回
                    showMode = false
                    self.main.eventShow = false
                }) {
                    HStack {
                        Image(systemName: "chevron.compact.left")
                        Text("返回")
                    }
                }.padding()
                Spacer()
                Button(action: {//编辑
                    self.main.eventEdit = true
                }) {
                    HStack {
                        Text("编辑")
                        }
                }.padding()
            }
            //分类
            Spacer().frame(height: 130)
            if coverDays(Date(), self.main.events[editingIndex].date) >= 0 {
                HStack {
                    Text("还有").offset(y: 50)
                    Text(coverDaysString(Date(), self.main.events[editingIndex].date))
                        .font(.system(size: 150))
                    Text("天").offset(y: 50)
                }
            }
            else {
                HStack {
                    Text("已过").offset(y: 50)
                    Text(coverDaysString(Date(), self.main.events[editingIndex].date))
                            .font(.system(size: 150))
                    Text("天").offset(y: 50)
                }
            }
            Text( self.main.events[editingIndex].title).padding()
                .frame(width: UIScreen.main.bounds.width)
            Text("\(self.main.events[editingIndex].date, formatter: Self.coverDateFormatter)")
            Text(self.main.eventEditNote)
                .font(.callout)
                .fontWeight(.thin)
                .padding(50)
            Text(getRemindString(self.main.events[editingIndex].remind))
                .font(.callout)
                .fontWeight(.thin)
                .padding(50)
            
            Button(action: {//分享
                
            }) {
                Image(systemName: "square.and.arrow.up")
                .resizable()
                .frame(width: 20, height: 25)
            }
            .padding()
            Spacer()
        }
    }
}

struct EventShow_Previews: PreviewProvider {
    static var previews: some View {
        EventShow(main: Main())
    }
}

func getRemindString(_ remind: Int) -> String {
    if remind == 0 {
        return "从不提醒"
    }
    else if remind == 1 {
        return "每日提醒"
    }
    else if remind == 3 {
        return "每三日提醒"
    }
    else if remind == 7 {
        return "每周提醒"
    }
    else {
        return "每月提醒"
    }
}
