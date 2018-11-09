//
//  networking.swift
//  SocialBet
//

// This file contains helper functions for sending GET and POST requests

import Foundation

struct GETResponse {
    var error: Error? = nil
    var data: Data? = nil
    var response: URLResponse? = nil
}

struct POSTResponse {
    var error: Error? = nil
    var data: Data? = nil
    var response: URLResponse? = nil
}

// sends a GET request to the provided URI
// returns response information about the GET request
func sendGET(uri: String) -> GETResponse {
    // instantiate a container to return information about the GET request
    var getresponse = GETResponse()
    
    // perform the GET request and populate the return object
    guard let url = URL(string: domain + uri) else { return GETResponse() }
    
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
        if let response = response {
            getresponse.response = response
        }
        
        if let error = error {
            getresponse.error = error
        }
        
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                getresponse.data = json as? Data
            } catch {
                print(error)
            }
        }
        
    }.resume()
    
    // return the request information
    return getresponse
}

// -sends a POST request containing the JSONification of the provided parameters dictionary to the
//  provided URI
// -returns response information about the POST request
func sendPOST(uri: String, parameters: Dictionary<String, String>) ->  POSTResponse{
    // instantiate a container to return information about the POST request
    var postresponse = POSTResponse()
    
    // perform the POST request and populate the return object
    guard let url = URL(string: domain + uri) else { return POSTResponse() }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        return POSTResponse()
    }
    request.httpBody = httpBody
    
    // pass the request into the task
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
            postresponse.response = response
        }
        
        if let error = error {
            postresponse.error = error
        }
        
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                postresponse.data = json as? Data
            } catch {
                print(error)
            }
        }
        
    }.resume()
    
    // return the request information
    return postresponse
}
