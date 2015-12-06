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
    
    var movieTableViewController: MoviesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpeechKit.setupWithID(Constants.APP_ID, host: Constants.HOST, port: Constants.PORT, useSSL: Constants.USE_SSL, delegate: self)
        someAction()

        self.movieTableViewController = self.childViewControllers[0] as! MoviesTableViewController
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
        
        let movies = LanguageParser.sharedInstance.parse(results.results as! [String])
        print(movies)
        
        self.movieTableViewController?.movies = movies
    }
    
    func recognizer(recognizer: SKRecognizer!, didFinishWithError error: NSError!, suggestion: String!)
    {
        //an error has occurred
        print("error")
    }


}

