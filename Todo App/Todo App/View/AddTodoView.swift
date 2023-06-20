import SwiftUI
import CoreData
struct AddTodoView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext)  var managedObjectContext
  @Environment(\.presentationMode) var presentationMode
  @State private var name: String = ""
  @State private var priority: String = "Normal"
  @State private var errorShowing: Bool = false
  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  let priorities = ["High", "Normal", "Low"]
  // MARK: - BODY
  var body: some View {
    NavigationView {
      VStack {
        VStack(alignment: .leading, spacing: 20) {
          // MARK: - TODO NAME
          TextField("Todo", text: $name)
            .padding()
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(9)
            .font(.system(size: 24, weight: .bold, design: .default))
          // MARK: - TODO PRIORITY PICKER
          Picker("Priority", selection: $priority) {
            ForEach(priorities, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          // MARK: - SAVE BUTTON
          Button {
            if self.name != "" {
              let todo = Todo(context: self.managedObjectContext)
              todo.name = self.name
              todo.priority = self.priority

              do {
                try self.managedObjectContext.save()
              } catch {
                print(error)
              }
            } else {
              self.errorShowing = true
              self.errorTitle = "Invalid Name"
              self.errorMessage = "Make sure to enter something for\nthe new todo item."
              return
            }
            self.presentationMode.wrappedValue.dismiss()
          } label: {
            Text("Save")
              .font(.system(size: 24, weight: .bold, design: .default))
              .padding()
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(.blue)
              .cornerRadius(9)
              .foregroundColor(.white)
              .overlay(
                RoundedRectangle(cornerRadius: 9)
                  .stroke(.white, lineWidth: 1)
              )
              .shadow(color: .gray, radius: 2, x: 0, y: 2)
          }//: SAVE BUTTON
        } //: VSTACk
        .padding(.horizontal)
        .padding(.vertical, 30)

        Spacer()
      }//: VSTACK
      .navigationTitle("New Todo")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(trailing: Button(action: {
        self.presentationMode.wrappedValue.dismiss()
      }, label: {
        Image(systemName: "xmark")
      }))
      .alert(isPresented: $errorShowing) {
        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
    }//: NAVIGATION
  }
}
// MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
