//
//  ViewController.swift
//  Networking
//
//  Created by Evgeniy Kolenkov on 27.01.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let myCompletionHandler : (Data?, URLResponse?, Error?) -> Void = {(data, response, error) in
        if let response = response {
            //                print(response)
        }
        if let error = error {
            print(error)
        }
        guard let responseData = data else {
            print("error: did not receive data")
            return
        }
        do {
            guard let todo =  try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
            }
            print("The todo is: " + todo.description)
            guard let todoTitle = todo["title"] as? String else {
                print("Could not get todo title from JSON")
                return
            }
            print("The title is: " + todoTitle)
        } catch let exception {
            print(exception)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // createNewTodo()
        //deleteFirstTodo()
        getFirstTodoWithAlamofire()
    }
    
    func getFirstTodo() {
        
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error : cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: myCompletionHandler)
        task.resume()
    }
    
    func createNewTodo() {
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        guard let todosURL = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        var todosURLRequest = URLRequest(url: todosURL)
        todosURLRequest.httpMethod = "POST"
        let newTodo : [String: Any] = ["title": "My First todo", "completed": false, "userId": 1]
        let jsonTodo : Data
        // if you sure:
        //  jsonTodo = try! JSONSerialization.data(withJSONObject: newTodo, options: [])
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            todosURLRequest.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: todosURLRequest, completionHandler: myCompletionHandler)
        task.resume()
    }
    
    func deleteFirstTodo() {
        
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        guard let url = URL(string: todoEndpoint) else {
            print("Error : cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: urlRequest, completionHandler: myCompletionHandler)
        task.resume()
    }
    
//    func getFirstTodoWithAlamofire() {
//        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
//        Alamofire.request(TodoRouter.get(1)).responseJSON { (response) in
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling GET on /todos/1")
//                    print(response.result.error!)
//                    return
//                }
//                guard let json = response.result.value as? [String: Any] else {
//                    print("didn't get todo object as JSON from API")
//                    print("Error: \(response.result.error)")
//                    return
//                }
//                guard let todoTitle = json["title"] as? String else { print("Could not get todo title from JSON")
//                    return
//                }
//                print("The title is: " + todoTitle)
//        }
//    }
    
//    func postWithAlamofire() {
//        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
//        let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
//        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo, encoding: JSONEncoding.default)
//            .responseJSON { response in
//            guard response.result.error == nil else {
//                // got an error in getting the data, need to handle it print("error calling POST on /todos/1") print(response.result.error!)
//                return
//            }
//            // make sure we got some JSON since that's what we expect
//            guard let json = response.result.value as? [String: Any] else { print("didn't get todo object as JSON from API")
//                print("Error: (response.result.error)")
//                return
//            }
//            // get and print the title
//            guard let todoTitle = json["title"] as? String else { print("Could not get todo title from JSON")
//                return
//            }
//            print("The title is: " + todoTitle)
//        }
//    }
//
//    func deleteWithAlamofire()  {
//        let firstTodoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
//        Alamofire.request(firstTodoEndpoint, method: .delete).responseJSON { response in
//                guard response.result.error == nil else {
//                    // got an error in getting the data, need to handle it
//                    print("error calling DELETE on /todos/1")
//                    print(response.result.error!)
//                    return
//                }
//                print("DELETE ok")
//        }
//    }

    
    func deleteWithAlamofire()  {
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
    
    
    func postWithAlamofire() {
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
        Alamofire.request(TodoRouter.create(newTodo))
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
    
    func getFirstTodoWithAlamofire() {
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(TodoRouter.get(1)).responseJSON { (response) in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /todos/1")
                print(response.result.error!)
                return
            }
            guard let json = response.result.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            guard let todoTitle = json["title"] as? String else { print("Could not get todo title from JSON")
                return
            }
            print("The title is: " + todoTitle)
        }
    }
}


