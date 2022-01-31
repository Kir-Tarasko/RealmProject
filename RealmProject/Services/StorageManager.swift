//
//  StorageManager.swift
//  RealmProject
//
//  Created by Кирилл Тараско on 28.01.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    // MARK: - Task List
    func save(taskLists: [TaskList]) {
        try! realm.write {
            realm.add(taskLists)
        }
    }
    
    func save(taskList: TaskList) {
        write {
            realm.add(taskList)
        }
    }
    
    func delete(taskList: TaskList) {
        write {
            realm.delete(taskList.tasks)
            realm.delete(taskList)
        }
    }
    
    func edit(taskList: TaskList, newValue: String) {
        write {
            taskList.name = newValue
        }
    }

    func done(taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
            
        }
    }

    // MARK: - Tasks
    func save(task: Task, to taskList: TaskList) {
        write {
            taskList.tasks.append(task)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
    func delete(task: Task) {
        write {
            realm.delete(task)
            
        }
    }
    
    func edit(task: Task, name: String, note: String)  {
        write {
            task.name = name
            task.note = note
        }
    }
    
    func done(task: Task) {
        write {
            task.isComplete.toggle()
        }
    }
    
   
    
}

