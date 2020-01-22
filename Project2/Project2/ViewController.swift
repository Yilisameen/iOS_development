//
//  ViewController.swift
//  Project2
//
//  Created by Yangjun Bie on 1/20/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var animals = [Animal]()
    var sound: AVAudioPlayer?

    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var speciesLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // arrays of animals
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".mp3") {
                if item.hasPrefix("cat") {
                    animals.append(Animal(name: "Cici", species: "cat", age: 3, image: UIImage(named: "cat")!, soundPath: item))
                }
                else if item.hasPrefix("dog") {
                    animals.append(Animal(name: "Lily", species: "dog", age: 2, image: UIImage(named: "dog")!, soundPath: item))
                }
                else if item.hasPrefix("horse") {
                    animals.append(Animal(name: "Pipi", species: "horse", age: 5, image: UIImage(named: "horse")!, soundPath: item))
                }
            }
        }
        
        animals.shuffle()
        //print(animals)
        
        //next function
        scrollView.contentSize = CGSize(width: 1242, height: 600)
        scrollView.delegate = self
        for i in 0...2 {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: i*414, y: 100, width: 414, height: 100)
            button.setTitle(animals[i].name, for: .normal)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 25)
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            scrollView.addSubview(button)
        }
        for i in 0...2 {
            let imageView = UIImageView(image: animals[i].image)
            imageView.frame = CGRect(x: i*414, y: 200, width: 414, height: 400)
            imageView.contentMode = UIView.ContentMode(rawValue: 1)!
            scrollView.addSubview(imageView)
        }
        
        speciesLable.text = animals[0].species
    }
    
    @objc func buttonTapped(_ button: UIButton) {
           let i = button.tag
           let animal = animals[i]
           
           let alertController = UIAlertController(title: animal.name, message: animal.description, preferredStyle: .alert)
           
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
           alertController.addAction(cancelAction)

           let playSound = UIAlertAction(title: "Play Sound", style: .default) { (action) in
               print(animal.description)
               let path = Bundle.main.path(forResource: animal.soundPath, ofType: nil)!
               let url = URL(fileURLWithPath: path)
               do {
                self.sound = try AVAudioPlayer(contentsOf: url)
                self.sound?.play()
               }catch {
                   print("error with .mp3 file")
               }
           }
           alertController.addAction(playSound)

           self.present(alertController, animated: true)
           
       }
       
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = (scrollView.contentOffset.x)/207
        let f = floor((scrollView.contentOffset.x)/207)
        if f.truncatingRemainder(dividingBy: 2.0) == 0 {
            speciesLable.alpha = 1 - (offset - f)
        }
        else{
            speciesLable.alpha = offset - f
        }
        
        if offset < 1 {
            speciesLable.text = animals[0].species
        }
        else if offset>=1 && offset<3 {
            speciesLable.text = animals[1].species
        }
        else if offset >= 3 {
            speciesLable.text = animals[2].species
        }
        
    }
}


class Animal : CustomStringConvertible {
    var description: String = ""
    
    var name: String
    var species: String
    var age: Int
    var image: UIImage
    var soundPath: String
    
    init(name: String, species: String, age: Int, image: UIImage, soundPath: String) {
        self.name = name
        self.species = species
        self.age = age
        self.image = image
        self.soundPath = soundPath
        self.description = "\(name) is a \(age) years old \(species)."
    }
}

