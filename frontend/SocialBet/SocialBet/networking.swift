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

// TODO, these objects are the same and could be treated as one networkresponse object

struct GETResponse {
    var error: Error? = nil
    var data: Data? = nil                       // the JSONified response
    var response: DataResponse<Any>? = nil      // the unparsed response
}

struct POSTResponse {
    var error: Error? = nil
    var data: Data? = nil                       // the JSONified response
    var response: DataResponse<Any>? = nil      // the unparsed response
}

func sendGET(uri: String) -> GETResponse {
    // form the request url
    let url = common.domain + ":" + common.port + uri
    
    // Instantiate a return variable
    var getresponse = GETResponse()
    
    // Populate the return variable with the contents of the request
    Alamofire.request(url).responseJSON { response in
        switch response.result {
        case .success:
            getresponse.response = response
            getresponse.data = response.data
        case .failure(let error):
            getresponse.error = error
        }
    }
    
    return getresponse
}

func sendPOST(uri: String, parameters: Dictionary<String, String>, callback: @escaping (POSTResponse) -> Void){
    // form the request url
    guard let url = URL(string: "http://" + common.domain + ":" + common.port + uri) else {
        callback(POSTResponse())
        return
    }
    
    // create a variable that will be passed to the completion handler
    // this is kind of like a return value but it is asynchonous and safe
    var postresponse = POSTResponse();
    
    // Populate the return variable with the contents of the request
    Alamofire.request(url, method:.post, parameters:parameters ,encoding: URLEncoding.queryString).responseString { response in
        switch response.result {
            case .success:
                postresponse.data = response.data
                callback(postresponse)
            case .failure:
                postresponse.error = response.error
                callback(postresponse)
       }
    }
}
