//
//  CertificateTest.swift
//  CertificateTest_Swfit
//
//  Created by 이주형 on 11/02/2019.
//  Copyright © 2019 이주형. All rights reserved.
//

import Foundation
import SwiftSoup
import Alamofire

enum TestURL : String{
    case s​ubjectList = "http://www.comcbt.com/cbt/s_view.php"
    case two = "http://www.comcbt.com/cbt/s_view1.php"
    case three = "http://www.comcbt.com/cbt/s_view2.php"
}

struct subject {
    var _subject: String? = nil
    
    var subject: String?{
        get {
            return _subject
        }
        set(newVal) {
            _subject = newVal
        }
    }
    
    var _value: String? = nil
    var value: String?{
        get {
            return _value
        }
        set(newVal) {
            _value = newVal
        }
    }
    
    
    init(subject:String, valse:String) {
        self.subject = subject
        self.value = valse
    }
}


class CertificateTest {
    
    
    init() {
        
    }
    
    func getSubjectList(completion: @escaping([subject])->()) {
        let parameters = ["hack_number": 0]
        var list: [subject] = []
        Alamofire.request(TestURL.s​ubjectList.rawValue, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseString { response in
                
                do{
                    let doc: Document = try SwiftSoup.parse(String(data: response.data!, encoding: String.Encoding.utf8)!)
                    let select: Elements = try doc.select("select[name=imsidbname] option")
                    for option: Element in select.array() {
                        list.append(subject(subject: try option.text(),valse: try option.val()))
                    }
                    return completion(list)
                }catch{
                    print("오류났다")
                }
        }
    }
}
