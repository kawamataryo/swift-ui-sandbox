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
            Text("Timer \(timerVal) seconds").font(.body)
                Picker(selection: $timerVal, label: Text("")) /*@START_MENU_TOKEN@*/{
                    TimeTag(seconds: 1)
                    TimeTag(seconds: 5)
                    TimeTag(seconds: 10)
                    TimeTag(seconds: 30)
                    TimeTag(seconds: 60)
                }/*@END_MENU_TOKEN@*/
            NavigationLink(destination: SecondView(secondScreenShow:
                                                    $secondScreenShow, timeVal: timerVal, initialTime: timerVal), isActive:
                                                    $secondScreenShow, label: {Text("Start")})
        }
    }
}

struct TimeTag: View {
    var seconds:Int
    var body: some View {
        Text("\(seconds)").tag(seconds).font(.title2)
    }
}

struct SecondView: View {
    @Binding var secondScreenShow:Bool
    @State var timeVal:Int
    var initialTime:Int

    var body: some View {
        if timeVal > -1 {
        VStack {
            ZStack {
                Text("\(timeVal)").font(.system(size: 40))
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            if self.timeVal > -1 {
                                self.timeVal -= 1
                            }
                        }
                    }
                ProgressBar(progress: self.timeVal, initialTime: initialTime)
                    .frame(width: 90.0, height: 90.0)
            }
            Button(action: {
                self.secondScreenShow = false
            }, label: {
                Text("Cancel")
                    .foregroundColor(Color.red)
            })
            .padding(.top)
        }
        } else {
            Button(action: {
                self.secondScreenShow = false
            }, label: {
                Text("Done!")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.green)
            }).onAppear() {
                WKInterfaceDevice.current().play(.notification)
            }
        }
    }
}

struct ProgressBar: View {
    var progress: Int
    var initialTime: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(self.progress) / Float(self.initialTime), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
