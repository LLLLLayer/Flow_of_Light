//
//  TypeSet.swift
//  流光
//
//  Created by Layer on 2019/12/28.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

struct TypeSet: View {
    @ObservedObject var main: Main
    @State var nowTypeList: [String]
    @State var saveError = false
    @State var deleteError = false
    @State var inputType = ""
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.main.goTypeSet = false
                }) {
                    Image(systemName: "chevron.compact.left")
                    Text("返回")
                }.padding()
                Spacer()
                Button(action: {
                    if self.nowTypeList.count < 4 {
                        self.saveError = true
                        return
                    }
                    self.main.settings.typeList = self.nowTypeList
                    do {//保存
                        try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.main.settings.typeList, requiringSecureCoding: false), forKey: "typeList")
                    }
                    catch {
                        print("Error")
                        return
                    }
                    //修改被删除的事件的类型
                    for event in self.main.events {
                        if self.main.settings.typeList.contains(event.type) == false {
                            event.type = "默认"
                        }
                    }
                    
                    self.main.curType = "全部"
                    self.main.settings.typeList = self.nowTypeList
                    self.main.goTypeSet = false
                }) {
                    Text("保存")
                }.padding()
                .alert(isPresented: $saveError, content: {
                    Alert(title: Text("保存失败！"),
                          message: Text("请至少设置四种类型！"),
                          primaryButton: .destructive(Text("OK")) {},
                          secondaryButton: .cancel())
                })
                .alert(isPresented: $deleteError, content: {
                    Alert(title: Text("删除失败！"),
                          message: Text("类型“默认”不允许删除！"),
                          primaryButton: .destructive(Text("OK")) {},
                          secondaryButton: .cancel())
                })
            }
            HStack {
                Text("添加：").padding()
                Spacer()
            }
            HStack {
                Text("名称：").padding()
                TextField("请在此输入类型名称", text: $inputType).padding()
            }
            Button(action: {
                self.nowTypeList.append(self.inputType)
                self.inputType = ""
            }) {
                Text("添加")
            }.padding()
                .disabled(self.inputType.count == 0 || self.nowTypeList.count == 7 ? true : false)
            HStack {
                Text("当前分类数量：").padding()
                Spacer()
                Text("\(self.nowTypeList.count) / 7").padding()
            }
            Text("（数量限制: 4～7 ）")
            List {
                ForEach(self.nowTypeList, id: \.self) { type in
                        Text(type)
                }
                .onDelete(perform: deleteItem)
                .onMove(perform: moveItem)
            }
            Spacer()
        }
    }
    func deleteItem(at offsets: IndexSet) {
        if let first = offsets.first {
            if first == 0 {
                self.deleteError = true
                return
            }
            nowTypeList.remove(at: first)
        }
        print(self.nowTypeList)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        nowTypeList.move(fromOffsets: source, toOffset: destination)
        print(self.nowTypeList)
    }
}

struct TypeSet_Previews: PreviewProvider {
    static var previews: some View {
        TypeSet(main: Main(),nowTypeList: ["0","1","2","3"])
    }
}
