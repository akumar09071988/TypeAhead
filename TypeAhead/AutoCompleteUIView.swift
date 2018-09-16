//
//  ToolTipUIView.swift
//  TypeAhead
//
//  Created by Abhishek Kumar on 8/31/18.
//  Copyright © 2018 Abhishek Kumar. All rights reserved.
//

import Foundation
import UIKit

protocol AutoCompleteDelegate {
    func updateListForText(inputText: String, completion: @escaping([String]) -> ())
    func getSelectedValue(selectedValue: String)
}

class AutoCompleteUIView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    //property
    var textField: UITextField?
    var tableView: UITableView?
    var tableDataSource = [String]()
    var delegate: AutoCompleteDelegate?
    
    

    
    static func createAutoCompleteViewFor(textField: UITextField) -> AutoCompleteUIView {
        let autoCompleteView = AutoCompleteUIView(textField: textField)
        
        return autoCompleteView
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(textField: UITextField) {
        self.init(frame: CGRect.zero)
        
        
        self.textField = textField
        // setting this as textfield delegate is not calling any function so we are using this
        self.addTextFieldTargets()
        
        
    }
    
    private func addTextFieldTargets() {
        self.textField?.addTarget(self, action: #selector(self.textFieldDidChange),
                                  for: UIControlEvents.editingChanged)
        self.textField?.addTarget(self,
                                  action: #selector(self.textFieldEditBegin),
                                  for: UIControlEvents.editingDidBegin)
        
        self.textField?.addTarget(self,
                                 action: #selector(self.textFieldEditEnd),
                                 for: UIControlEvents.editingDidEnd)
        
        self.textField?.addTarget(self,
                                  action: #selector(self.textFieldEditEndExit),
                                  for: UIControlEvents.editingDidEndOnExit)
    }
    
    private func addTableViewToView() {
        if self.tableView == nil {
            self.tableView = UITableView(frame: CGRect.zero)
            self.tableView?.dataSource = self
            self.tableView?.delegate = self
        }
        guard let tempTableView = self.tableView,
        let tempTextField = self.textField else {return}
        tempTableView.frame.origin.x = tempTextField.frame.origin.x
        tempTableView.frame.origin.y = tempTextField.frame.origin.y + tempTextField.frame.size.height
        tempTableView.frame.size.height = 300;
        tempTableView.frame.size.width = tempTextField.frame.width;
        tempTableView.tableFooterView = UIView()
        //tempTableView.backgroundColor = UIColor.red
        if self.subviews.contains(tempTableView) {
            
        } else {
            self.textField?.superview?.addSubview(tempTableView)
            tempTableView.reloadData()
        }
    }
    
    //Text field methods
    @objc open func textFieldDidChange() {
        print(self.textField?.isFirstResponder)
        print(self.textField?.text)
        if (self.tableView == nil) {
            addTableViewToView()
        }
        if let text = self.textField?.text {
            self.searchData(text)
            self.tableView?.reloadData()
        }
        
    }
    
    @objc open func textFieldEditBegin() {
       print("edit begin")
        addTableViewToView()
    }
    
    @objc open func textFieldEditEnd() {
        print("edit end")
    }
    
    @objc open func textFieldEditEndExit() {
        print("edit end exit")
    }
    
    //MARK: table view datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count > 5 ? 5 : tableDataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if (tableView.dequeueReusableCell(withIdentifier: "simpleCell") != nil) {
            cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell")!
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: "simpleCell")
        }
        cell.textLabel?.text = tableDataSource[indexPath.row]
        cell.detailTextLabel?.text = "data "
        cell.backgroundColor = UIColor.clear
        return cell;
    }
    
    //MARK: tableview delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = tableDataSource[indexPath.row]
        if let delegate = self.delegate, delegate.getSelectedValue != nil {
            delegate.getSelectedValue(selectedValue: text)
            self.textField?.text = text
            self.tableView?.removeFromSuperview()
            self.tableView = nil
        }
    }
    
    
    //MARK: private functions
    private func searchData(_ text: String) {
        tableDataSource = [String]()
        if let delegate = self.delegate, delegate.updateListForText != nil {
            //tableDataSource = delegate.updateListForText(inputText: text)
            delegate.updateListForText(inputText: text) {(list) in
                self.tableDataSource = list
            }
        }
        print(tableDataSource.count)
        
    }
    
    
    
    
}
