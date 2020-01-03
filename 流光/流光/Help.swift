//
//  Help.swift
//  流光
//
//  Created by Layer on 2019/12/28.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI
import WebKit

struct Help: View {
    @ObservedObject var main: Main
    @State var goWeb = false
    var body: some View {
        ScrollView {
            HStack {
                Button(action: {
                    self.main.goHelp = false
                }) {
                    Image(systemName: "chevron.compact.left")
                    Text("返回")
                }.padding()
                Spacer()
            }
            Text("帮助").font(.system(.largeTitle)).padding()
            HStack {
                Text("产品简介：").padding()
                Spacer()
            }
            Text("        流光——帮助用户记录、管理日程，并提醒用户进行合理日程安排。为重要的日子提供倒计时功能。").padding()
            HStack {
                Text("产品定位：").padding()
                Spacer()
            }
            Text("        日程记录、安排、管理和重要事件倒计时工具类，时间管理工具。").padding()
            HStack {
                Text("项目地址：").padding()
                Spacer()
            }
            Button(action: {
                self.goWeb = true
            }) {
                VStack {
                    Text("https://github.com/LLLLLayer/Flow_of_Light")
                    Text("（单击网址访问）")
                }
            }.padding()
             .sheet(isPresented: $goWeb, content: { WebViewPage() })
            VStack {
                Text("        若您在使用本产品时有任何疑问或者建议，")
                HStack {
                    Text("    欢迎通过邮件联系：")
                    Spacer()
                }
                Text("Layer@cug.edu.cn").padding()
                HStack {
                    Text("谢谢！").padding()
                    Spacer()
                }
            }
            HStack {
                Spacer()
                Text("2019年12月").padding()
            }
        }
    }
}

struct WebViewPage : UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let req = URLRequest(url: URL(string: "https://github.com/LLLLLayer/Flow_of_Light")!)
        uiView.load(req)
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help(main: Main())
    }
}
