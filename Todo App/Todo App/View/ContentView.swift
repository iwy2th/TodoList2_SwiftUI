//
//  ContentView.swift
//  Todo App
//
//  Created by Iwy2th on 20/06/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
  // MARK: - PROPERTIES
  @Environment(\.managedObjectContext)  var managedObjectContext
  @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)])
  var todos: FetchedResults<Todo>
  @State private var showingAddTodoView: Bool = false
  @State private var animatingButton: Bool = false
  // MARK: - BODY
  var body: some View {
    NavigationView {
      ZStack {
        List {
          ForEach(self.todos, id: \.self) { item in
            HStack {
              Text(item.name ?? "Unknown")
              Spacer()
              Text(item.priority ?? "Unknown")
            }
          }//: FOREACH
          .onDelete(perform: deleteTodo)
        }//: LIST
        .navigationTitle("Todo")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
          leading: EditButton()
//          trailing:
//        Button(action: {
//          // show add Todo View
//          self.showingAddTodoView.toggle()
//        }, label: {
//          Image(systemName: "plus")
//        })
//          .sheet(isPresented: $showingAddTodoView, content: {
//            AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
//          })
      )
        // MARK: - NO TODO ITEMS
        if todos.count == 0 {
         EmptyListView()
        }
      }//: ZSTACK
      .sheet(isPresented: $showingAddTodoView, content: {
        AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
      })
      .overlay (
        ZStack {
          Group {
            Circle()
              .fill(Color.blue)
              .opacity(self.animatingButton ? 0.2 : 0)
              .scaleEffect(self.animatingButton ? 1 : 0)
              .frame(width: 68, height: 68, alignment: .center)

            Circle()
              .fill(Color.blue)
              .opacity(self.animatingButton ? 0.15 : 0)
              .scaleEffect(self.animatingButton ? 1 : 0)
              .frame(width: 88, height: 88, alignment: .center)
          }
          .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animatingButton)
          Button(action: {
            // show add Todo View
            self.showingAddTodoView.toggle()
          }, label: {
            Image(systemName: "plus.circle.fill")
              .resizable()
              .scaledToFit()
              .background(Circle().fill(Color("ColorBase")))
              .frame(width: 48, height: 48, alignment: .center)
        })//: BUTTON
          .onAppear {
            self.animatingButton.toggle()
          }
        }//: ZSTACK
          .padding(.bottom, 15)
          .padding(.trailing, 15)
        , alignment: .bottomTrailing
      )
    }//: NAVIGATION
  }
  // MARK: - FUNC
  private func deleteTodo(at offsets: IndexSet) {
    for index in offsets {
      let todo = todos[index]
      managedObjectContext.delete(todo)
      do {
        try managedObjectContext.save()
      } catch {
        print(error)
      }
    }
  }
}
// MARK: - PREVIEW
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
