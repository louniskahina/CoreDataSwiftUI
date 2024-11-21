//
//  ContentView.swift
//  MyCoreDataProject
//
//  Created by Kahina Lounis on 20/11/2024.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Task.title, ascending: true)
        ]
    ) private var tasks: FetchedResults<Task>

    @State private var newTaskTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Champ textField pour ajouter une tâche
                TextField("Nouvelle tâche", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: addTask) {
                    Text("Ajouter (coreData)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                // Liste des tâches
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Text(task.title ?? "Sans titre")
                            Spacer()
                            if task.isCompleted {
                                Text("✓")
                                    .foregroundColor(.green)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleTaskCompletion(task)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("Ma liste de Tâches")
        }
    }

    private func addTask() {
        guard !newTaskTitle.isEmpty else { return }

        let newTask = Task(context: context)
        newTask.id = UUID()
        newTask.title = newTaskTitle
        newTask.isCompleted = false

        saveContext()
        newTaskTitle = ""
    }

    private func toggleTaskCompletion(_ task: Task) {
        task.isCompleted.toggle()
        saveContext()
    }

    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            context.delete(tasks[index])
        }
        saveContext()
    }

    // Sauvegarder les modifications dans Core Data
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(
                "Erreur lors de la sauvegarde dans Core Data : \(error.localizedDescription)"
            )
        }
    }
}

#Preview {
    ContentView()
}
