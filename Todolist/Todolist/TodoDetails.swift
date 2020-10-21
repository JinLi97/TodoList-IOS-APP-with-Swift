//
//  TodoDetails.swift
//  Todolist
//
//  Created by JIN LI on 10/21/20.
//  Copyright © 2020 Test. All rights reserved.
//

import SwiftUI

struct TodoDetails: View {
    @ObservedObject var main: Main
    @State var confirmingCancel: Bool = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if confirmingCancel {
                        Button(action: {
                            self.confirmingCancel = false
                        }) {
                            Text("Editing")
                                .padding()
                        }
                        Button(action: {
                            UIApplication.shared.keyWindow?.endEditing(true)
                            self.confirmingCancel = false
                            self.main.detailsShowing = false
                        }) {
                            Text("Cancel")
                                .padding()
                        }
                    } else {
                        Button(action: {
                            if (!editingMode && self.main.detailsTitle == "" ||
                                editingMode && editingTodo.title == self.main.detailsTitle &&
                                editingTodo.dueDate == self.main.detailsDueDate) {
                                UIApplication.shared.keyWindow?.endEditing(true)
                                self.main.detailsShowing = false
                            } else {
                                self.confirmingCancel = true
                            }
                        }) {
                            Text("Cancel")
                                .padding()
                        }
                    }
                    Spacer()
                    if !confirmingCancel {
                        Button(action: {
                            UIApplication.shared.keyWindow?.endEditing(true)
                            if editingMode {
                                self.main.todos[editingIndex].title = self.main.detailsTitle
                                self.main.todos[editingIndex].dueDate = self.main.detailsDueDate
                            } else {
                                let newTodo = Todo(title: self.main.detailsTitle, dueDate: self.main.detailsDueDate)
                                newTodo.i = self.main.todos.count
                                self.main.todos.append(newTodo)
                            }
                            self.main.sort()
                            do {
                                try UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.main.todos, requiringSecureCoding: false), forKey: "todos")
                            } catch {
                                print("error")
                            }
                            self.confirmingCancel = false
                            self.main.detailsShowing = false
                        }) {
                            if editingMode {
                                Text("Finish")
                                    .padding()
                            } else {
                                Text("Add")
                                    .padding()
                            }
                        }.disabled(main.detailsTitle == "")
                    }
                }
                SATextField(tag: 0, text: editingTodo.title, placeholder: "What will you do?", changeHandler: { (newString) in
                    self.main.detailsTitle = newString
                }) {
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .foregroundColor(.white)
                DatePicker(selection: $main.detailsDueDate, displayedComponents: .date, label: { () -> EmptyView in
                })
                    .padding()
                Spacer()
            }
            .padding()
            .background(Color("todoDetails-bg").edgesIgnoringSafeArea(.all))
        }
    }
}



struct TodoDetails_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetails(main: Main())
    }
}

