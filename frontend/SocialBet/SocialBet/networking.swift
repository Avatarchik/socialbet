//
//  networking.swift
//  SocialBet
//

// This file contains helper functions for sending GET and POST requests

import Foundation
import Alamofire

/* ALAMOFIRE COPYRIGHT INFORMATION
 
 Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

// container for HTTP responses from GET and POST requests
struct HTTPResponse {
    var error: Error? = nil     // request error information
    var data: Data? = nil       // the JSONified response
    var success: Bool? = nil    // True if success
    var failure: Bool? = nil    // True if failure
}

// send a GET request
// arguments:   uri for the endpoint (including query string)
//              callback function of your design
func sendGET(uri: String, callback: @escaping (HTTPResponse) -> Void){
    // form the request url
    guard let url = URL(string: "http://" + common.domain + ":" + common.port + uri) else {
        callback(HTTPResponse())
        return
    }
    
    // Instantiate a return variable
    var httpresponse = HTTPResponse()
    
    // Populate the return variable with the contents of the request
    Alamofire.request(url, method:.get, encoding: URLEncoding.default).responseString { response in
        switch response.result {
        case .success:
            httpresponse.error = response.error
            httpresponse.data = response.data
            httpresponse.success = true
            callback(httpresponse)
        case .failure:
            httpresponse.error = response.error
            httpresponse.data = response.data
            httpresponse.success = false
            callback(httpresponse)
        }
    }
}

// send a POST request
// arguments:   uri for the endpoint (including query string)
//              dictionary of parameters to pass to the server
//              callback function of your design
func sendPOST(uri: String, parameters: Dictionary<String, String>, callback: @escaping (HTTPResponse) -> Void){
    // form the request url
    guard let url = URL(string: "http://" + common.domain + ":" + common.port + uri) else {
        callback(HTTPResponse())
        return
    }
    
    // create a variable that will be passed to the completion handler
    // this is kind of like a return value but it is asynchonous and safe
    var httpresponse = HTTPResponse()
    
    // Populate the return variable with the contents of the request
    Alamofire.request(url, method:.post, parameters:parameters, encoding: URLEncoding.queryString).responseString { response in
        switch response.result {
            case .success:
                httpresponse.error = response.error
                httpresponse.data = response.data
                httpresponse.success = true
                callback(httpresponse)
            case .failure:
                httpresponse.error = response.error
                httpresponse.data = response.data
                httpresponse.success = false
                callback(httpresponse)
       }
    }
}
