//
//  ViewController.swift
//  ValueTrackingSlider
//
//  Created by Mohammed on 21/07/2022.
//

import UIKit

class ViewController: UIViewController  , ASValueTrackingSliderDataSource, ASValueTrackingSliderDelegate{
    func sliderWillDisplayPopUpView(_ slider: ASValueTrackingSlider?) {
        
    }
    
    
    func slider(_ slider: ASValueTrackingSlider?, stringForValue value: Float) -> String? {
            var value = value
            value = roundf(value)
            var s: String?
            if value < -10.0 {
                s = "❄️Brrr!⛄️"
            } else if value > 29.0 && value < 50.0 {
                s = "😎 \(slider?.numberFormatter?.string(from: NSNumber(value: value)) ?? "") 😎"
            } else if value >= 50.0 {
                s = "I’m Melting!"
            }
            return s
        }
    
    @IBOutlet weak var slider2: ASValueTrackingSlider!
    @IBOutlet weak var slider3: ASValueTrackingSlider!
    
    
    
    @IBAction func showTics(_ sender: Any) {
        slider2.placeTicMarksAt(ticArray: [2,4,5,6,8])
        slider2.setIsTickType(TickType : true)
        
    }
    
    @IBAction func RemoveTics(_ sender: Any) {
       // slider2.placeTicMarksAt(ticArray: [2,4,5,6,8])
        slider2.setIsTickType(TickType : false)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider2.delegate = self
        self.slider2.font =  UIFont(name: "Futura-CondensedExtraBold", size: 26)
        slider2.popUpViewAnimatedColors = [UIColor.blue , UIColor.red, UIColor.orange]
        self.slider2.showPopUpView(animated: true)
        slider2.value = 5
        slider2.thumbTintColor = #colorLiteral(red: 0, green: 0.6692362428, blue: 0, alpha: 0.2844960387)

        
        
        
        let tempFormatter = NumberFormatter()
        tempFormatter.positiveSuffix = "°C"
        tempFormatter.negativeSuffix = "°C"

        slider3.dataSource = self
        slider3.numberFormatter = tempFormatter
        slider3.minimumValue = Float(truncating: -20.0 as NSNumber)
        slider3.maximumValue = Float(truncating: 60.0 as NSNumber)
        slider3.popUpViewCornerRadius = 16.0

        slider3.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 26)
        slider3.textColor = UIColor(white: 0.0, alpha: 0.5)
        
        slider3.setPopUpViewAnimatedColors([UIColor.blue, UIColor.systemBlue , UIColor.green , UIColor.yellow , UIColor.red] , withPositions: [-20,0,5,25,60])
    }


}

