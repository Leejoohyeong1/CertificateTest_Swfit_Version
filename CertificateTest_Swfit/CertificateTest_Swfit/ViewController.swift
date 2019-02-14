//
//  ViewController.swift
//  CertificateTest_Swfit
//
//  Created by 이주형 on 11/02/2019.
//  Copyright © 2019 이주형. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cer : CertificateTest = CertificateTest()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        one()
        two()
        three()
    }
    
    func one(){
        cer.getSubjectList { (date) in
            for item in date{
                print(item.subject!,"\t",item.value!)
            }
        }
    }
    
    
    func two(){
        cer.geteDtailSubjectList { (date) in
            for item in date{
                print(item.dbname!,"\t",item.text!)
            }
        }
    }
    
    func three(){
        cer.geteDtailSubjectDateList { (date) in
            for item in date{
                print(item.subject!,"\t",item.value!)
            }
        }
    }


}

