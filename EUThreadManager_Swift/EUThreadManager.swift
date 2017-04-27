//
//  EUThreadManager.swift
//  EUThreadManagerSwift
//
//  Created by Vitaliy Yarkun on 4/23/17.
//  Copyright © 2017 Vitaliy Yarkun. All rights reserved.
//

import Foundation

enum TaskPriorityExecution {
    case kUserInitiatedPriorityExecution
    case kDefaultPriorityExecution
    case kUtilityPriorityExecution
    case kBackgroundPriorityExecution
}

typealias simpleTask = ()->()

class EUThreadManager {
    
    private init() {
        
    }
    
    static let sharedInstance = EUThreadManager()
    
    //MARK: Public methods
    func run(task: @escaping simpleTask, with priority: TaskPriorityExecution, and resultMethod: @escaping simpleTask) {
        
        switch priority {
        case .kUserInitiatedPriorityExecution:
            runUserInitiatedPriority(task, with: resultMethod)
            break
        case .kDefaultPriorityExecution:
            runDefaultPriority(task, with: resultMethod)
            break
        case .kUtilityPriorityExecution:
            runUtilityPriority(task, with: resultMethod)
            break
        default:
            runBackgroundPriority(task, with: resultMethod)
            break
        }
    }
    
    private func runUserInitiatedPriority(_ task: @escaping simpleTask, with resultMethod: @escaping simpleTask) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            task()
            DispatchQueue.main.async {
                resultMethod()
            }
        }
    }
    
    private func runDefaultPriority(_ task: @escaping simpleTask, with resultMethod: @escaping simpleTask) {
        
        DispatchQueue.global(qos: .default).async {
            task()
            DispatchQueue.main.async {
                resultMethod()
            }
        }
    }
    
    private func runUtilityPriority(_ task: @escaping simpleTask, with resultMethod: @escaping simpleTask) {
        
        DispatchQueue.global(qos: .utility).async {
            task()
            DispatchQueue.main.async {
                resultMethod()
            }
        }
    }
    
    private func runBackgroundPriority(_ task: @escaping simpleTask, with resultMethod: @escaping simpleTask) {
        
        DispatchQueue.global(qos: .background).async {
            task()
            DispatchQueue.main.async {
                resultMethod()
            }
        }
    }
}
