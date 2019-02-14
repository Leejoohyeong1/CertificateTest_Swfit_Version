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
    case details​ubjectList = "http://www.comcbt.com/cbt/s_view1.php"
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

struct dtailSubject {
    var _dbname: String? = nil
    
    var dbname: String?{
        get {
            return _dbname
        }
        set(newVal) {
            _dbname = newVal
        }
    }
    
    var _text: String? = nil
    var text: String?{
        get {
            return _text
        }
        set(newVal) {
            _text = newVal
        }
    }
    
    
    init(dbname:String, text:String) {
        self.dbname = dbname
        self.text = text
    }
}


class CertificateTest {
    
    
    init() {
        
    }
    
    func getSubjectList(completion: @escaping([subject])->()) {
        let parameters: Parameters = ["hack_number": 0]
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
    
    
    
    func geteDtailSubjectList(completion: @escaping([dtailSubject])->()) {
        var list: [dtailSubject] = []
        let parameters: Parameters = ["hack_number": 0,"imsidbname":"기사"]
        
        Alamofire.request(TestURL.details​ubjectList.rawValue, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
        .validate { request, response, data in            
            // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
            return .success
        }
        .responseString { response in
            
            do{
                let doc: Document = try SwiftSoup.parse(String(data: response.data!, encoding: String.Encoding.utf8)!)
                let select: Elements = try doc.select("select[name=dbname] option")
                for option: Element in select.array() {
                    list.append(dtailSubject(dbname: try option.val(), text: try option.text()))
                }
                return completion(list)
            }catch{
                print("오류났다")
            }
        }
    }
    
    func geteDtailSubjectDateList(completion: @escaping([subject])->()) {
        let parameters: Parameters = ["hack_number": 0,"imsidbname":"기사","dbname":"kt"]
        var list :[subject] = []
        Alamofire.request(TestURL.three.rawValue, method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                
                return .success
            }
            .responseString { response in
                
                do{
                    let doc: Document = try SwiftSoup.parse(String(data: response.data!, encoding: String.Encoding.utf8)!)
                    let select: Elements = try doc.select("select[name=tablename] option")
                    for option: Element in select.array() {
                        list.append(subject(subject: try option.text(), valse: try option.val()))
                    }
                    return completion(list)
                }catch{
                    print("오류났다")
                }
        }
                    
    }
}
 
