//
//  ContentView.swift
//  sample WatchKit Extension
//
//  Created by 川俣涼 on 2020/11/19.
//

import SwiftUI

struct ContentView: View {
    @State var secondScreenShow = false
    @State var timerVal = 1
    
    var body: some View {
        VStack {
            Text("タイマー \(timerVal) 秒").font(.body)
                Picker(selection: $timerVal, label: Text("")) /*@START_MENU_TOKEN@*/{
                    Text("1").tag(1)
                    Text("5").tag(5)
                    Text("10").tag(15)
                    Text("30").tag(30)
                    Text("60").tag(60)
                }/*@END_MENU_TOKEN@*/
            NavigationLink(destination: SecondView(secondScreenShow:
                                                    $secondScreenShow, timeVal: timerVal), isActive:
                                                    $secondScreenShow, label: {Text("Go")})
        }
    }
}

struct SecondView: View {
    @Binding var secondScreenShow:Bool
    @State var timeVal:Int
    var body: some View {
        if timeVal > 0 {
        VStack {
            ZStack {
                Text("\(timeVal)").font(.system(size: 40))
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            if self.timeVal > 0 {
                                self.timeVal -= 1
                            }
                        }
                    }
                Circle()
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(240))
                    .frame(width: 100, height:100)
                Circle()
                    .trim(from: CGFloat(self.timeVal / 100), to: 0.5)
                    .stroke(Color.red,style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(240))
                    .rotation3DEffect(Angle(degrees: 100), axis: (x: 0, y: 0, z: 0))
                    .frame(width: 100, height: 100)
            }
            Button(action: {
                self.secondScreenShow = false
            }, label: {
                Text("キャンセル")
                    .foregroundColor(Color.red)
            })
        }
        } else {
            Button(action: {
                self.secondScreenShow = false
            }, label: {
                Text("Done!")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.green)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
