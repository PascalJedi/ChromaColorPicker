//
//  ViewController.swift
//  ChromaColorPicker-Demo
//
//  Created by Cardasis, Jonathan (J.) on 8/11/16.
//  Copyright © 2016 Jonathan Cardasis. All rights reserved.
//

import UIKit
import ChromaColorPicker
import SwifterSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var colorDisplayView: UIView!
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var hexField: UITextField!

    var colorPicker: ChromaColorPicker!

    //--------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        hexField.delegate = self

        /* Calculate relative size and origin in bounds */
        let pickerSize = CGSize(width: view.bounds.width*0.8, height: view.bounds.width*0.8)
        let pickerOrigin = CGPoint(x: view.bounds.midX - pickerSize.width/2, y: view.bounds.midY - pickerSize.height/2)

        /* Create Color Picker */
        colorPicker = ChromaColorPicker(frame: CGRect(origin: pickerOrigin, size: pickerSize))
        colorPicker.delegate = self
        colorPicker.activeColor = UIColor.green
        
        /* Customize the view (optional) */
        colorPicker.padding = 10
        colorPicker.stroke = 10 //stroke of the rainbow circle
        colorPicker.currentAngle = Float.pi
        
        /* Customize for grayscale (optional) */
        colorPicker.supportsShadesOfGray = true // false by default
        //colorPicker.colorToggleButton.grayColorGradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.gray.cgColor] // You can also override gradient colors
        
        
        colorPicker.hexLabel.textColor = UIColor.white
        
        /* Don't want an element like the shade slider? Just hide it: */
        //colorPicker.shadeSlider.hidden = true
        
        self.view.addSubview(colorPicker)

        self.colorPicker.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = self.colorPicker.topAnchor.constraint(equalTo: pickerLabel.bottomAnchor, constant: 22)
        let verticalConstraint = self.colorPicker.bottomAnchor.constraint(equalTo: hexField.topAnchor, constant: -22)
        let widthConstraint = self.colorPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let heightConstraint = self.colorPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        colorPicker.setNeedsDisplay()
    }

}

//--------------------------------------------------------------------------

// - MARK: ChromaColorPickerDelegate Delegates

extension ViewController: ChromaColorPickerDelegate{
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        //Set color for the display view
        colorDisplayView.backgroundColor = color
        hexField.text = color.hexString

        //Perform zesty animation
        UIView.animate(withDuration: 0.2,
                animations: {
                    self.colorDisplayView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                }, completion: { (done) in
                UIView.animate(withDuration: 0.2, animations: { 
                    self.colorDisplayView.transform = CGAffineTransform.identity
                })
        }) 
    }
}

//--------------------------------------------------------------------------

// - MARK: UITextFieldDelegate Delegates

extension ViewController: UITextFieldDelegate{

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return string.isValidHexadecimal || (string.count <= 7)
    }

    //--------------------------------------------------------------------------

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    //--------------------------------------------------------------------------

    func isValidCSSHex(hex: String) -> Bool {
        return hex.range(of: "#([a-fA-F0-9]{3}){1,2}\\b", options: .regularExpression) != nil
    }

    //--------------------------------------------------------------------------

    @IBAction func hexEditEnded(_ sender: Any) {
        var tempColor: UIColor = .red
        let hexString = hexField.text!
        if self.isValidCSSHex(hex: hexString) {
            let colorFromHex = UIColor.init(hexString: hexField.text!)
            tempColor = colorFromHex!
            colorPicker.activeColor = tempColor
            colorPicker.shadeSliderChoseColor(colorPicker.shadeSlider, color: tempColor)
            hexField.textColor = UIColor.black
        } else {
            hexField.textColor = UIColor.red
            self.displayHexEntryErrorDialog()
        }
    }

    //--------------------------------------------------------------------------

    func displayHexEntryErrorDialog() {

        // create the alert
        let alert = UIAlertController(title: "Hex Entry Error", message: "The format for the Hex field is #FFF or #FFFFFF.", preferredStyle: .alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}

//--------------------------------------------------------------------------

// - MARK: String Extension

public extension String {
    /**
     A Boolean value indicating whether a string only contains hexadecimal characters.
     */
    public var isValidHexadecimal: Bool {
        let chars = CharacterSet(charactersIn: "0123456789ABCDEFabcdef").inverted
        guard self.count != 0, self.rangeOfCharacter(from: chars, options: .caseInsensitive, range: nil) == nil else {
            return false
        }
        return true
    }
}

