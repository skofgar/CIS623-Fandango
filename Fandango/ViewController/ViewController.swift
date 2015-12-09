//
//  ViewController.swift
//  Fandango
//
//  Copyright © 2015 CFR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SpeechKitDelegate, SKRecognizerDelegate {

    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var searchInputView: UIView!
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var mainLogo: UIImageView!
    @IBOutlet weak var mainLogoMark: UIImageView!
    
    var movieTableViewController: MoviesTableViewController?
    var isSearching = false
    var upwards = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpeechKit.setupWithID(Constants.APP_ID, host: Constants.HOST, port: Constants.PORT, useSSL: Constants.USE_SSL, delegate: self)

        self.movieTableViewController = self.childViewControllers[0] as! MoviesTableViewController
        
        let defaultMoviesToLoad = ["incredibles", "7", "8", "9"]
        let movies = LanguageParser.sharedInstance.parse(defaultMoviesToLoad)
        self.movieTableViewController?.movies = movies
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var voiceSearch: SKRecognizer?
    func someAction()
    {
        if (!isSearching) {
            self.voiceSearch = SKRecognizer(type: SKTvRecognizerType, detection: UInt(SKShortEndOfSpeechDetection), language:"en-US", delegate: self)
        }
        
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
    
    
    
    func rotateIcon() {
        
        let duration = 1.0
        let delay = 0.0

        let options = UIViewAnimationOptions.CurveLinear
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.microphoneButton.setImage(UIImage(named: "cancel_button"), forState: .Normal)
            self.microphoneButton.imageView?.transform = CGAffineTransformRotate((self.microphoneButton.imageView?.transform)!, CGFloat(M_PI_2*2))
            self.upwards = !self.upwards
            }, completion: {
                (value: Bool) in
                if (value && (self.isSearching || !self.upwards)) {
                    self.rotateIcon();
                } else {
                    self.microphoneButton.setImage(UIImage(named: "voice_button"), forState: .Normal)
                }
        })
    }
    
    // MARK: - SKRecognizer
    
    func recognizerDidBeginRecording(recognizer: SKRecognizer!)
    {
        //The recording has started
        isSearching = true
        rotateIcon()
        print("recording has started")
    }
    
    func recognizerDidFinishRecording(recognizer: SKRecognizer!)
    {
        //The recording has stopped
        print("recording stopped")
    }
    
    func recognizer(recognizer: SKRecognizer!, didFinishWithResults results: SKRecognition!)
    {
        isSearching = false
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
    
    func animateLogo() {
        
        let duration = 0.5
        let delay = 0.0 // delay will be 0.0 seconds (e.g. nothing)
        let options = UIViewAnimationOptions.CurveEaseInOut // change the timing curve to `ease-in ease-out`
        let TOP_INSET_MOVIES: CGFloat = 80
        let TOP_INSET_MOVIE_CONTAINER_AFTER_ANIMATION = self.tableViewContainer.frame.origin.y - TOP_INSET_MOVIES
        
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.mainLogo.alpha = 0
            self.mainLogoMark.alpha = 1
            }, completion: nil)

        UIView.animateWithDuration(duration, delay: duration, options: options, animations: {
            self.mainLogoMark.transform = CGAffineTransformMakeScale(0.4, 0.4)
            self.mainLogoMark.frame.origin.x = self.view.frame.origin.x+16
            self.mainLogoMark.frame.origin.y = self.view.frame.origin.y+16
            
            
            self.tableViewContainer.frame.origin.y = TOP_INSET_MOVIES
            self.tableViewContainer.frame.size.height += TOP_INSET_MOVIE_CONTAINER_AFTER_ANIMATION
            }, completion: nil)
    }
}

