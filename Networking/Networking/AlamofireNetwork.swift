//
//  AlamofireNetwork.swift
//  Networking
//
//  Created by Evgeniy Kolenkov on 11.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetwork {
    
    class func getFirstTodoWithAlamofire() {
        
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(todoEndpoint).responseJSON { (response) in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /todos/1")
                print(response.result.error!)
                return
            }
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(String(describing: response.result.error))")
                return
            }
            guard let todoTitle = json["title"] as? String else { print("Could not get todo title from JSON")
                return
            }
            print("The title is: " + todoTitle)
        }
    }
    
    class  func postWithAlamofire() {
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo, encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it print("error calling POST on /todos/1") print(response.result.error!)
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else { print("didn't get todo object as JSON from API")
                    print("Error: (response.result.error)")
                    return
                }
                // get and print the title
                guard let todoTitle = json["title"] as? String else { print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
        }
    }
    
    class  func deleteWithAlamofire()  {
        let firstTodoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(firstTodoEndpoint, method: .delete).responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling DELETE on /todos/1")
                print(response.result.error!)
                return
            }
            print("DELETE ok")
        }
    }
    class func getFirstTodoWithAlamofire1() {
        // let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(TodoRouter.get(1)).responseJSON { (response) in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /todos/1")
                print(response.result.error!)
                return
            }
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(String(describing: response.result.error))")
                return
            }
            // let todoObject = Todo(json: json)
            guard let todoTitle = json["title"] as? String else { print("Could not get todo title from JSON")
                return
            }
            print("The title is: " + todoTitle)
        }
    }
    
    class func postWithAlamofire1() {
        // let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        guard let newtodo1 = Todo(title: "myTitle", id: nil, userId: 1, completed: true) else {return}
        // let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
        Alamofire.request(TodoRouter.create(newtodo1.toJson())).responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it print("error calling POST on /todos/1") print(response.result.error!)
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else { print("didn't get todo object as JSON from API")
                    print("Error: (response.result.error)")
                    return
                }
                // get and print the title
                guard let todoTitle = json["title"] as? String else { print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
        }
    }
    
    class func deleteWithAlamofire1()  {
        Alamofire.request(TodoRouter.delete(1)).responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling DELETE on /todos/1")
                print(response.result.error!)
                return
            }
            print("DELETE ok")
        }
    }
}
