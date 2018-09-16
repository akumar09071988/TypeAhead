//
//  ViewController.swift
//  TypeAhead
//
//  Created by Abhishek Kumar on 6/15/18.
//  Copyright © 2018 Abhishek Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AutoCompleteDelegate {
    
    @IBOutlet weak var textField: UITextField!
    var autoCompleteView: AutoCompleteUIView?
    
    //TODO: delete
    var data = [String]()
    
    //lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.autoCompleteView = AutoCompleteUIView.createAutoCompleteViewFor(textField: textField)
        self.autoCompleteView?.delegate = self as? AutoCompleteDelegate
        
        for i in 1...100 {
            self.data.append("\(i)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additlabel1ional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Autcomplete delegate
    func updateListForText(inputText: String, completion: @escaping ([String]) -> ()) {
        var result = [String]()
        for i in 0..<data.count {
            if (data[i].contains(inputText)) {
                result.append(data[i])
            }
        }
        completion(result)
    }
    
    func getSelectedValue(selectedValue: String) {
        print(selectedValue)
    }


}

