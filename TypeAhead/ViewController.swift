//
//  ViewController.swift
//  TypeAhead
//
//  Created by Abhishek Kumar on 6/15/18.
//  Copyright © 2018 Abhishek Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    var autoCompleteView: AutoCompleteUIView?
    
    //lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.autoCompleteView = AutoCompleteUIView.createAutoCompleteViewFor(textField: textField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additlabel1ional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    


}

