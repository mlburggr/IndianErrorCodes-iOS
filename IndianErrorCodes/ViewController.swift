//
//  ViewController.swift
//  IndianErrorCodes
//
//  Created by Maxwell Burggraf on 7/26/15.
//  Copyright (c) 2015 Maxwell Burggraf. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var pickerData = [""]

    @IBOutlet weak var SPNField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var FMIPicker: UIPickerView!
    
    var sqlLiteDb = SQLiteDatabase()
    
    
    @IBAction func outputTextViewEdited(sender: UITextField) {
        var spnText = SPNField.text
        
        let spn = Expression<String>("SPN")
        let fmi = Expression<String>("FMI")
        let indianErrorCodes = SQLiteDatabase.getTable();
        
        var resultFMIs = [String]()
        
        
        for error in indianErrorCodes {
            if(error[spn] == spnText){
                resultFMIs.append(error[fmi])
            }
        }
        
        if(resultFMIs.count != 0){
            resultFMIs.insert("Select an FMI", atIndex: 0);
        } else {
             outputTextView.text = "No errors found for the given SPN"
        }
        
        pickerData = resultFMIs
        FMIPicker.reloadAllComponents()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        SPNField.resignFirstResponder()
        return true
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        let indianErrorCodes = SQLiteDatabase.getTable();
        let spn = Expression<String>("SPN")
        let fmi = Expression<String>("FMI")
        let component = Expression<String>("Component")
        let condition = Expression<String>("Condition")
        let mil = Expression<String>("MIL")
        var componentText = ""
        var conditionText = ""
        var milText = ""
        

        
        for error in indianErrorCodes {
            if(pickerData == []){ return }
            
            if(error[fmi] == pickerData[row] && SPNField.text == error[spn]){
                componentText = error[component]
                conditionText = error[condition]
                milText = error[mil]
            }
        }
        
        if(componentText == "" && conditionText == "" && milText == ""){
            outputTextView.text = ""
        } else {
        outputTextView.text = "Component: \(componentText) \n Condition: \(conditionText) \n MIL: \(milText)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FMIPicker.delegate = self
        FMIPicker.dataSource = self
        
        SQLiteDatabase.setupDb()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

