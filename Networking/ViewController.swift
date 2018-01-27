//
//  ViewController.swift
//  Networking
//
//  Created by Evgeniy Kolenkov on 27.01.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import UIKit

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
        deleteFirstTodo()
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
}

