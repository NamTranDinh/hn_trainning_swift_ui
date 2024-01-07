//
//  ContentView.swift
//  MyApp
//
//  Created by NAM TRAN on 06/01/2024.
//

import SwiftUI

struct MyAppView : View {
    @State private var count: Int = 0
    @State private var isOn: Bool = false
    @State private var value: Double = 50
    
    var body: some View {
        
        VStack {
            //            CounterView(count: count)
            //            ToggleView(isOn: isOn)
            //            SliderView(value: value)
            //            TextFieldView()
            //            DragGestureView()
            //            PickerView()
            //            DatePickerView(selectedDate: Date.now)
            //            SheetView()
            PopoverView()
        }.padding()
    }
}

#Preview {
    MyAppView()
}

struct CounterView: View {
    @State var count: Int;
    
    init(count: Int) {
        self.count = count
    }
    
    var body: some View {
        VStack {
            Text(String(count))
                .font(.system(size: 36))
                .bold()
                .padding(.bottom, 36)
            
            HStack(alignment: .center, spacing: 42.0){
                Button(action: {
                    self.count += 1
                }, label: {
                    Text("ADD")
                }).buttonStyle(.borderedProminent)
                
                Button(action: {
                    self.count = 0
                }, label: {
                    Text("RESET")
                }).buttonStyle(.borderedProminent)
                
                Button(action: {
                    self.count -= 1
                }, label: {
                    Text("MINUS")
                }).buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ToggleView: View {
    
    @State private var isOn: Bool
    
    init(isOn: Bool) {
        self.isOn = isOn
    }
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }, label: {
            Toggle(isOn: $isOn, label: {
                Text("Developer Mode")
            })
        })
    }
}

struct SliderView: View {
    
    @State private var value: Double
    
    init(value: Double) {
        self.value = value
    }
    
    
    var body: some View {
        VStack{
            Text("\(value, specifier: "%.1f")")
                .font(.system(size: 36))
                .bold()
                .padding(.bottom, 36)
            
            Slider(
                value: $value,
                in: 0...100
            )
        }
    }
}

struct TextFieldView: View {
    @State var loginController: String = "";
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $loginController)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(Color.black)
                .padding()
        }
    }
}


struct DragGestureView: View {
    @State private var isDragging = false
    @State private var positionCurr = CGSize.zero
    @State private var positionNew = CGSize.zero
    
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.isDragging = true
                self.positionCurr = CGSize(
                    width: self.positionNew.width + value.translation.width,
                    height: self.positionNew.height + value.translation.height
                )
            }
            .onEnded { value in
                self.isDragging = false
                self.positionCurr = CGSize(
                    width: self.positionNew.width + value.translation.width,
                    height: self.positionNew.height + value.translation.height
                )
                self.positionNew = self.positionCurr
            }
    }
    
    
    var body: some View {
        Circle()
            .offset(positionCurr)
            .fill(self.isDragging ? Color.red : Color.blue)
            .frame(width: 100, height: 100, alignment: .center)
            .gesture(drag)
    }
}


struct PickerView: View {
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }
    
    
    @State private var selectedFlavor: Flavor = .chocolate
    
    var body: some View {
        VStack {
            Text(selectedFlavor.rawValue.capitalized)
                .font(.system(size: 36))
                .bold()
                .padding(.bottom, 36)
            
            List {
                Picker("No Style", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized).tag(flavor.hashValue)
                    }
                }
                
                Picker("inline", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized).tag(flavor.hashValue)
                    }
                }
                .pickerStyle(.inline)
                
                Picker("Menu", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized).tag(flavor.hashValue)
                    }
                }
                .pickerStyle(.menu)
                
                
                Picker("Palette", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized).tag(flavor.hashValue)
                    }
                }
                .pickerStyle(.palette)
                
                Picker("Wheel", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized).tag(flavor.hashValue)
                    }
                }
                .pickerStyle(.wheel)
                
                Picker("NavigationLink", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized).tag(flavor.hashValue)
                    }
                }
                .pickerStyle(.navigationLink)
                
            }
        }
    }
}


struct DatePickerView: View {
    
    @State var selectedDate: Date
    
    let secondsFromStart = Date.now.addingTimeInterval(20)
    let minutesFromStart = Date.now.addingTimeInterval(20 * 60)
    let hoursFromStart = Date.now.addingTimeInterval(5 * 60 * 60)
    let daysFromStart = Date.now.addingTimeInterval(24 * 60 * 60)
    let monthsFromStart = Date.now.addingTimeInterval(5 * 24 * 60 * 60)
    let yearsFromStart = Date.now.addingTimeInterval(365 * 24 * 60 * 60)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                Text(self.selectedDate, style: .date)
                    .font(.system(size: 36))
                    .bold()
                
                Text(self.selectedDate, style: .time)
                    .font(.system(size: 36))
                
                Divider()
                
                DatePicker("Compact", selection: $selectedDate)
                    .datePickerStyle(.compact)
                
                DatePicker("Graphical", selection: $selectedDate)
                    .datePickerStyle(.graphical)
                
                DatePicker("Wheel", selection: $selectedDate)
                    .datePickerStyle(.wheel)
            }
        }
    }
}

struct SheetView: View {
    @State private var showingSheet = false
    @State private var showingActionSheet = false
    
    var body: some View {
        VStack {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showingSheet) {
                Text("This app was brought to you by Hacking with Swift")
                    .presentationDetents([.fraction(0.15)])
            }
            
            Button("Show ActionSheet") {
                showingActionSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Resume Workout Recording"),
                    message: Text("Choose a destination for workout data"),
                    buttons: [
                        .cancel(),
                        .destructive(
                            Text("Overwrite Current Workout"),
                            action: {}
                        ),
                        .default(
                            Text("Append to Current Workout"),
                            action: {}
                        )
                    ]
                )
            }
        }
    }
}

struct PopoverView: View {
    @State private var isShowingPopover = false
    
    
    var body: some View {
        VStack {
            Button("Show Popover") {
                self.isShowingPopover = true
            }
            .popover(isPresented: $isShowingPopover, arrowEdge: .leading) {
                Text("Popover Content")
                    .padding()
        }
        }
    }
}
