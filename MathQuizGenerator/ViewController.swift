//
//  ViewController.swift
//  MathQuizGenerator
//
//  Created by Yu Sun on 6/6/17.
//  Copyright © 2017 Yu Sun. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet weak var numQuestions: NSPopUpButton!
    @IBOutlet weak var QuestionType: NSPopUpButton!
    @IBOutlet weak var Max: NSTextField!
    @IBOutlet weak var preview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let htmlString = "<html><body><h1>Set up and click \"Go!\".</h1></body></html>"
        let myURL = URL(string: "")
        preview.loadHTMLString(htmlString, baseURL: myURL)
    }

    @IBAction func onPrint(_ sender: Any) {
        // Generate PDF file
        // Do nothing for now
    }
    
    @IBAction func onGo(_ sender: Any) {
        // Generate HTML page and show it in preview
        let numQs = Int(numQuestions.titleOfSelectedItem!)
        let qTypeStr = QuestionType.titleOfSelectedItem!
        let max = Max.integerValue
        var htmlString = "<html><body><table><tbody style=\"font-size: x-large\">"
        for index in 1...numQs! {
            if index % 3 == 1 {
                htmlString += "<tr>"
            }
            
            // Generate one question
            let sum = arc4random_uniform(UInt32(max - 25)) + 25
            let num1 = arc4random_uniform(sum - 20) + 10
            let num2 = sum - num1
            
            // Construct equation
            let coinFlip = arc4random_uniform(2)
            if (coinFlip == 0 && qTypeStr == "Addition and Subtraction") || qTypeStr == "Addition" {
                // Test addition
                htmlString += "<td>" + String(num1) + "</td><td>+</td><td>" + String(num2) + "</td><td>=</td>"
            } else {
                // Test subtraction
                htmlString += "<td>" + String(sum) + "</td><td>-</td><td>" + String(num1) + "</td><td>=</td>"
            }
            
            htmlString += "<td style=\"padding-right: 5em;\">______</td>"
            
            if index % 3 == 0 {
                htmlString += "</tr>"
            }
        }
        htmlString += "</tbody></table></body></html>"
        let myURL = URL(string: "")
        preview.loadHTMLString(htmlString, baseURL: myURL)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

