//
//  SettingsView.swift
//  Todo App
//
//  Created by Iwy2th on 20/06/2023.
//

import SwiftUI

struct SettingsView: View {
  // MARK: - PROPERTIES
  @Environment(\.presentationMode) var presentationMode
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack(alignment: .center, spacing: 0) {
        // MARK: - FORM
        Form {
          // MARK: - SECTION 3
          Section(header: Text("Follow us on social media")) {
            FormRowLinkView(icon: "globe", color: .pink, text: "Github", link: "https://github.com/iwy2th")
            FormRowLinkView(icon: "link", color: .blue, text: "Twitter", link: "https://twitter.com/iwy2th")
            FormRowLinkView(icon: "play.rectangle", color: .red, text: "Youtube", link: "https://youtube.com/iwy2th")
          }
          .padding(.vertical, 3)
          // MARK: - SECTION 4
          Section(header: Text("About the application")) {
            FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
            FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iphone, iPad")
            FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Iwy2th")
            FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Alant")
            FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.1.2")
          }
          .padding(.vertical, 3)
        }//: FORM
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        // MARK: - FOOTER
        Text("Copyright © All rights reserved.\nBetter Apps Less Code")
          .multilineTextAlignment(.center)
          .font(.footnote)
          .padding()
          .foregroundColor(Color.secondary)
      }//: VSTACK
      .navigationBarItems(trailing: Button(action: {
        presentationMode.wrappedValue.dismiss()
      }, label: {
        Image(systemName: "xmark")
      }))
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.inline)
      .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
    }//: NAVIGATION
  }
}
// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
