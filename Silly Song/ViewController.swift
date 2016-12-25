//
//  ViewController.swift
//  Silly Song
//
//  Created by Brenten Schlangen on 12/19/16.
//  Copyright © 2016 bschlangen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
        nameField.returnKeyType = UIReturnKeyType.done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if !(nameField.text?.isEmpty)! {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        }
    }
}

// Template containing the string for the silly song
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

/*******************************************************************
 *  Removes first letter and all letter until first vowel
 ******************************************************************/
func shortNameFromName(name: String) -> String {
    var vowels = "aeiou"
    var modName = name
    
    // Always remove first letter
    modName.remove(at: modName.startIndex)
    
    for letter in modName.characters {
        if vowels.characters.contains(letter) {
            // return if we hit a vowel
            return modName
        }
        else{
            // Remove the starting letter
            modName.remove(at: modName.startIndex)
        }
    }
    
    // Check for cases where the first letter is the ONLY vowel! (like Amy)
    if modName.isEmpty {
        return name.lowercased()
    }
    else {
        return modName
    }
}

/*******************************************************************
 *  Constructs the lyrics by combining a template and a name string
 ******************************************************************/
func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    var lyricsTemplate = lyricsTemplate
    
    // Swap out the full name inside the template
    lyricsTemplate = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    // Swap out the short name inside the template
    lyricsTemplate = lyricsTemplate.replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(name: fullName))
    return lyricsTemplate
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
