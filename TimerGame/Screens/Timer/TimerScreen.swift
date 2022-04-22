//
//  TimerScreen.swift
//  TimerGame
//
//  Created by Cristian Rojas on 22/04/2022.
//

import SwiftUI
import SwiftUItilities

struct TimerScreen: View {

  @State var startPosition: CGPoint = .zero

  @State var isDragging: Bool = true
  @State var needleRotation: Double = .zero
  @State var x: CGFloat = .zero
  @State var y: CGFloat = .zero
  
  private let frameSize: CGFloat =  200
  
  @State var value: CGFloat = .zero
  
  @State var locations: [CGPoint] = []
  
  var body: some View {
    
    VStack(spacing: 24) {
      Circle()
        .opacity(0.2)
        .size(frameSize)
        .overlay(ticks)
        .overlay(base)
//        .overlay(center)
        .overlay(needle)
        
      debugView
    }
  }

  
  var debugView: some View {
    VStack(spacing: 12) {
      Text("\(needleRotation) °")
      Text("startX: \(startPosition.x)")
      Text("x: \(x)")
      Text("y: \(y)")
      Text("swipeDirection: \((x - startPosition.x).isPositive ? "Right" : "Left")")
      Text("Reset")
        .onTap {
          needleRotation = .zero
          x = .zero
          y = .zero
          locations = []
        }
      HStack {
        Text("+")
          .onTap { needleRotation += 1 }
        Text("-")
          .onTap { needleRotation -= 1 }
      }
    }
  }
  
  var base: some View {
    Circle()
      .foregroundColor(.gray)
      .size(frameSize * 0.8)
    
  }
  
  var center: some View {
    Circle()
      .foregroundColor(.white)
      .size(40)
//      .overlay(needle)
      .overlay(
        Circle()
          .foregroundColor(.white)
          .size(25)
          .shadow(color: .black, radius: 6, x: 2, y: -1)
      )
  }
  
  var needle: some View {
    Rectangle()
      .cornerRadius(4)
      .width(6)
      .height(frameSize * 0.85)
      .offset(y: -frameSize * 0.85/2)
      .shadow(color: .black, radius: 6, x: 2, y: -1)
      .rotationEffect(.init(degrees: needleRotation))
      .gesture(needleGesture)
  }
  
  var needleGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        
        let newDrag = value.location
        if let previousLocation = locations.last {
          
          print("previous: \(previousLocation)")
          print("location: \(value.location)\n")
          
          handleRotation(
            previousDrag: previousLocation,
            newDrag: newDrag
          )
          
        } else {
          print("@todo")
        }
        
        locations.append(value.location)
        
        
        
      }
      .onEnded { value in
        print("end dragging")
      }
  }

  
  func handleRotation
  (previousDrag: CGPoint, newDrag: CGPoint) {
   
    let swipedRight = previousDrag.x < newDrag.x
    let swipedDown  = previousDrag.y < newDrag.y
    
    if swipedDown {
      print("Swiped down")
    } else {
      print("Swiped up")
    }
    
    if swipedRight {
      print("Swiped right")
    } else {
      print("Swiped left")
    }
    
  }
  
  func increase() {
    needleRotation += 1
  }
  
  func decrease() {
    needleRotation -= 1
  }
  
  var ticks: some View {
    ForEach(0..<60) { tick in
      self.tick(at: tick)
    }
  }
  
  func tick(at tick: Int) -> some View {
    VStack {
      Rectangle()
        .fill(Color.primary)
        .opacity(tick % 5 == 0 ? 1 : 0.4)
        .frame(width: 2, height: tick % 5 == 0 ? 15 : 7)
      Spacer()
    }
    .rotationEffect(Angle.degrees(Double(tick)/(60) * 360))
  }
}

extension Array {
  func getOrNil(index: Int) -> Element? {
    guard let maxIndex = self.indices.max() else { return nil }
    if maxIndex < index {
      return nil
    } else {
      return self[index]
    }
  }
}

extension CGFloat {
  var isPositive: Bool {
    self > 0
  }
  
  var isNegative: Bool {
    self < 0
  }
}

struct TimerScreen_Previews: PreviewProvider {
  static var previews: some View {
    TimerScreen()
  }
}
