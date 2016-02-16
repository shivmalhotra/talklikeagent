//
//  ViewController.swift
//  TextToSpeech
//
//  Created by Shiv Malhotra on 11/21/14.
//  Copyright (c) 2014 Shiv Malhotra. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var pitchSlider: UISlider!
    
    let synth = AVSpeechSynthesizer()
    
    var myUtterance = AVSpeechUtterance(string: "")
    var utteranceRate:Float = 0.25 // default rate
    var utterancePitch:Float = 1.0 // default pitch
    var utteranceLang = "en-GB" // default accent
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //give the textView rounded corners
        textView.layer.cornerRadius = 7.5;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //clear text with button
    @IBAction func clear(sender: AnyObject) {
        textView.text = ""
        
        utteranceRate = 0.25
        rateSlider.value = utteranceRate
        
        utterancePitch = 1.0
        pitchSlider.value = utterancePitch
    }
    
    //modify rate value
    @IBAction func rateValChanged(sender: AnyObject) {
        utteranceRate = sender.value
    }
    
    //modify pitch value
    @IBAction func pitchValChanged(sender: AnyObject) {
        utterancePitch = sender.value
    }
    
    //stop speech
    @IBAction func stopSpeech(sender: AnyObject) {
        synth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
    
    //start speech
    @IBAction func textToSpeech(sender: AnyObject) {
        myUtterance = AVSpeechUtterance(string: textView.text)
        myUtterance.rate = utteranceRate
        myUtterance.pitchMultiplier = utterancePitch
        myUtterance.voice = AVSpeechSynthesisVoice(language: utteranceLang)
        
        synth.speakUtterance(myUtterance)
    }

    @IBAction func randomizeEverything(sender: AnyObject) {

      utterancePitch = (randomFloat() * 1.5) + 0.5 // get random float between 0.5 and 2.0
      pitchSlider.value = utterancePitch
        
      utteranceRate = randomFloat() // get random float between 0 and 1.0
      rateSlider.value = utteranceRate

    }
    
    func randomFloat() -> Float {
        return Float(arc4random()) / Float(UINT32_MAX)
    }
    
    
    // when you touch outside the text view the editing ends - keyboard is hidden
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    //both methods below prevent from app rotating to landscape view
    override func shouldAutorotate() -> Bool {
        return false
    }
    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return UIInterfaceOrientation.Portrait.rawValue
//    }

}

