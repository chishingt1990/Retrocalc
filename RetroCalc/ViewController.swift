//
//  ViewController.swift
//  RetroCalc
//
//  Created by Shuang Wu on 14/05/2017.
//  Copyright © 2017 Shuang Wu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Different options for different cases
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Minus = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnsound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftVarStr = ""
    var rightVarStr = ""
    var result = ""
    
    
    //This accesses the enumeration. So this variable is initialized with an empty operation.
    var currentOperation: Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnsound = AVAudioPlayer(contentsOf: soundUrl as URL)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numPressed (btn:UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func multiplyPressed (btn:UIButton){
        processOperation(op: Operation.Multiply)
    }
    
    @IBAction func dividePressed (btn:UIButton!){
        processOperation(op: Operation.Divide)
    }
    
    @IBAction func addPressed (btn:UIButton!){
        processOperation(op: Operation.Add)
    }
    
    @IBAction func minusPressed (btn:UIButton){
        processOperation(op: Operation.Minus)
    }
    
    @IBAction func equalPressed (btn:UIButton){
        processOperation(op: currentOperation)
    }

    func processOperation (op: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            //It's already the second operator, so when the second operator is pressed, we need to immediately calculate
            
            if runningNumber != "" {
            
                rightVarStr = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                }
                else if currentOperation == Operation.Divide {
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                }
                else if currentOperation == Operation.Add {
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                }
                else if currentOperation == Operation.Minus {
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                }
                
                leftVarStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        }
        else{ //if this is the first operator, we might not have to calculate until the second operator is pressed
            leftVarStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound (){
        if btnsound.isPlaying{
            btnsound.stop()
        }
        btnsound.play()
    }
    
    
    
}

