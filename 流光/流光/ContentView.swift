//
//  ContentView.swift
//  FlowLight
//
//  Created by Layer on 2019/12/3.
//  Copyright © 2019 Layer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Home(main: Main())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
