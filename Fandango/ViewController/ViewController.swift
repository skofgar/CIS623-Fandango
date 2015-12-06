//
//  ViewController.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpeechKitDelegate, SKRecognizerDelegate {

    
    @IBOutlet weak var searchInputView: UIView!
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var mainLogo: UIImageView!
    @IBOutlet weak var mainLogoMark: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpeechKit.setupWithID(Constants.APP_ID, host: Constants.HOST, port: Constants.PORT, useSSL: Constants.USE_SSL, delegate: self)
        someAction()
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let duration = 1.0
//        let delay = 0.0 // delay will be 0.0 seconds (e.g. nothing)
//        let options = UIViewAnimationOptions.CurveEaseInOut // change the timing curve to `ease-in ease-out`
//        
//        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
//            self.mainLogo.alpha = 0
//            self.mainLogoMark.alpha = 1
//            
//            }, completion: { finished in
//                UIView.animateWithDuration(duration, animations: {
//                    self.mainLogoMark.transform = CGAffineTransformMakeScale(0.4, 0.4)
//                    self.mainLogoMark.frame.origin.x = self.view.frame.origin.x+16
//                    self.mainLogoMark.frame.origin.y = self.view.frame.origin.y+16
//                })
//        })
//    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var voiceSearch: SKRecognizer?
    func someAction()
    {
        self.voiceSearch = SKRecognizer(type: SKTvRecognizerType, detection: UInt(SKShortEndOfSpeechDetection), language:"en-US", delegate: self)
        
    }
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        someAction()
    }
    
    // MARK: - SpeechKitDelegate
    
    //    func setupWithId(ID: String, host: String, port: Int64, useSSL:Bool, delegate:AnyObject) {
    //        print("hello")
    //    }
    //
    //    func setupWithId(ID: String, host: String, port: Int64, useSSL:Bool, certSummary:String, certData: String, delegate:AnyObject) {
    //        print("hello")
    //    }
    //
    //    func destroy() {
    //        print("hello")
    //    }
    //
    //    var sessionID: String?
    //
    //    func setEarcon(earcon:SKEarcon, forType type:SKEarconType) {
    //        print("hello")
    //    }
    
    
    
    // MARK: - SKRecognizer
    
    func recognizerDidBeginRecording(recognizer: SKRecognizer!)
    {
        //The recording has started
        print("recording has started")
    }
    
    func recognizerDidFinishRecording(recognizer: SKRecognizer!)
    {
        //The recording has stopped
        print("recording stopped")
    }
    
    func recognizer(recognizer: SKRecognizer!, didFinishWithResults results: SKRecognition!)
    {
        var concatenatedString = ""
        //The voice recognition process has understood something
        for value in results.results {
            print("Input: " , value)
            concatenatedString += (value as! String) + "\n"
        }
        textInputField.text = concatenatedString
        
        print(LanguageParser.sharedInstance.parse(results.results as! [String]))
    }
    
    func recognizer(recognizer: SKRecognizer!, didFinishWithError error: NSError!, suggestion: String!)
    {
        //an error has occurred
        print("error")
    }
    
    func animateLogo() {
        
        let duration = 0.7
        let delay = 0.0 // delay will be 0.0 seconds (e.g. nothing)
        let options = UIViewAnimationOptions.CurveLinear // change the timing curve to `ease-in ease-out`
        
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.mainLogo.alpha = 0
            self.mainLogoMark.alpha = 1
            }, completion: nil)

        UIView.animateWithDuration(duration, delay: duration, options: options, animations: {
            self.mainLogoMark.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.mainLogoMark.frame.origin.x = self.view.frame.origin.x+16
            self.mainLogoMark.frame.origin.y = self.view.frame.origin.y+16
            }, completion: nil)
    }
}

