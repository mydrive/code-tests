//
//  ViewController.swift
//  MyDrive_CurrencyConverter
//
//  Created by Robin Spinks on 01/11/2016.
//  Copyright © 2016 Robin Spinks. All rights reserved.
//

/**
 ## The reasons I don't use .xib files
 
 I can, and will, use .xib files if asked to, but I don't use them in my own projects for these reasons:
 
 - Change Tracking
 There are dates and codes in .xib files, which are changed every time a developer views them in xcode, 
 which can obscure actual changes in git or similar systems.
 
 Merging changes is also very difficult with .xib files - especially storyboards, 
 which are basically massive xml wrappers containing multiple .xib files.
 
 I have worked as part of a team where three developers made changes to a story board, 
 which were difficult to merge together.
 
 - Readability
 .xib files are huge xml files, which - without loading into xcode -
 are generally very difficult to read for those not extremely familiar with them.
 
 This makes identification of changes difficult because it is difficult to visualise the layout 
 or see what the changes actually are (if any), without loading the .xib into interface builder; 
 for example, when browsing the git repo using a browser.
 
 To see all the settings in a .xib file you have to load it into xcode 
 and check all the little settings for every object.
 
 All non-default settings are clearly laid out when objects are defined in code.
 
 - Flexibility
 Object sizing and placement defined in code can be very flexible, 
 such as using percentages of the view, or other objects in the view, for sizing or placement.
 
 - Debugging
 It's difficult to find little inconsistencies in .xib files that may be causing a problem 
 as you have to select every little piece and carefully inspect all it's little options, 
 whereas any non-default settings are easily identifiable in code.
 */

import UIKit

var titleLabel : UILabel!
var quantityField : UITextField!
var fromPicker : UIPickerView!
var toPicker : UIPickerView!
var resultLabel : UILabel!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        createObjects()
        configureObjects()
        layoutObjects(within: view.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Overridden to capture view rotation
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layoutObjects(within: size)
    }

    /**
     Create all objects in the view
     */
    func createObjects () {
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        
        quantityField = UITextField()
        view.addSubview(quantityField)
        
        fromPicker = UIPickerView()
        view.addSubview(fromPicker)
        
        resultLabel = UILabel()
        view.addSubview(resultLabel)
        
        toPicker = UIPickerView()
        view.addSubview(toPicker)
    }
    
    /**
     Configure objects in the view
     All non-default settings are found here
     */
    func configureObjects () {
        titleLabel.text = "MyDrive Currency Converter"
        titleLabel.textAlignment = .center
        
        quantityField.backgroundColor = UIColor.lightGray
        quantityField.keyboardType = .numberPad
        quantityField.placeholder = "quantity"
        quantityField.addTarget(self, action: #selector(setResult), for: [.editingDidEnd, .editingDidEndOnExit])
        
        resultLabel.text = "="
        
        fromPicker.dataSource = self
        fromPicker.delegate = self
        
        toPicker.dataSource = self
        toPicker.delegate = self
    }
    
    /**
     Lays out all the objects in the view within a given size
     This method is separated so it can be called from different places,
     such as viewDidLoad() and viewWillTransition().
     */
    func layoutObjects (within size: CGSize) {
        let viewHeight : CGFloat = size.height
        let viewWidth : CGFloat = size.width
        let margin: CGFloat = (viewWidth + viewHeight)/100
        
        titleLabel.frame = CGRect(x: margin,
                                  y: topMargin,
                                  width: viewWidth - 2*margin,
                                  height: standardControlHeight)
        
        quantityField.frame = CGRect(x: margin,
                                     y: titleLabel.frame.maxY + margin,
                                     width: viewWidth/2 - 1.5*margin,
                                     height: standardControlHeight)
        
        fromPicker.frame = CGRect(x: viewWidth/2 + 0.5*margin,
                                  y: titleLabel.frame.maxY + margin,
                                  width: viewWidth/2 - 1.5*margin,
                                  height: standardPickerHeight)
        
        resultLabel.frame = CGRect(x: margin,
                                   y: fromPicker.frame.maxY + margin,
                                   width: viewWidth/2 - 1.5*margin,
                                   height: standardControlHeight)
        
        toPicker.frame = CGRect(x: viewWidth/2 + 0.5*margin,
                                y: fromPicker.frame.maxY + margin,
                                width: viewWidth/2 - 1.5*margin,
                                height: standardPickerHeight)
    }
    
    /**
     Calculates the result of converting the value of the quantity field between currencies
     and displays the value in the results label
     */
    func setResult () {
        let fromCurrency : String = currencies[fromPicker.selectedRow(inComponent: 0)]
        let toCurrency : String = currencies[toPicker.selectedRow(inComponent: 0)]
        
        if let initialValue : Float = Float(quantityField.text!) {
            if initialValue > 0 {
                let resultingValue : Float = DataHandler.sharedInstance.exchangeRate(from: fromCurrency, to: toCurrency) * initialValue
                resultLabel.text = String(format: "= %.2f", resultingValue)
            }
        }
    }
}

extension ViewController: UIPickerViewDelegate {
    
    /**
     Sets the title for the given picker view row
     
     - parameters:
        - pickerView: The picker view
        - row: The row of the picker view
        - component: The component of the picker view
     
     - returns: The title for the row
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }
    
    /**
     Responds to the selection of a picker view row
     
     - parameters:
         - pickerView: The picker view
         - row: The row of the picker view
         - component: The component of the picker view
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setResult()
    }
}

extension ViewController: UIPickerViewDataSource {
    
    /**
     Sets the number of components in the picker view
     
     - parameter pickerView: The picket view
     
     - Returns: The number of components
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**
     Sets the number of rows in a picker view component
     
     - parameters:
         - pickerView: The picker view
         - component: The component
     
     - Returns: The number of rows
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
}
