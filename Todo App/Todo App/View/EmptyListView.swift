//
//  EmptyListView.swift
//  Todo App
//
//  Created by Iwy2th on 20/06/2023.
//

import SwiftUI

struct EmptyListView: View {
  // MARK: - PROPERTIES
  @State private var isAnimating: Bool = false
  let images: [String] = [
    "illustration-no1",
    "illustration-no2",
    "illustration-no3"
  ]
  let tips: [String] = [
    "Use your time wisely,",
    "Slow and steady wins the race.",
    "Keep is short and sweet.",
    "Put hard tasks first.",
    "Reward yourself after work",
    "Collect tasks ahead of time.",
    "Each night schedule for tomorrow."

  ]
  // MARK: - BODY
  var body: some View {
    ZStack {
      VStack(alignment: .center, spacing: 20) {
        Text("\" \(tips.randomElement() ?? self.tips[0])\"")
          .italic()
          .layoutPriority(0.5)
        Image("\(images.randomElement() ?? self.images[0])")
          .resizable()
          .scaledToFit()
          .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
          .layoutPriority(1)
      }//: VSTACK
      .padding(.horizontal)
      .opacity(isAnimating ? 1 : 0)
      .offset(y: isAnimating ? 0 : -50)
      .animation(.easeOut(duration: 1.5), value: isAnimating)
      .onAppear {
        self.isAnimating.toggle() 
      }
    }//: ZSTACK
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .background(Color("ColorBase"))
    .ignoresSafeArea()
  }
}
// MARK: - PREVIEW
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
        .environment(\.colorScheme, .dark)
    }
}
