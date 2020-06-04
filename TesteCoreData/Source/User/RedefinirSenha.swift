//
//  RedefinirSenha.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 04/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit

class perguntaRandom: UIViewController, UITextFieldDelegate {
    var defaults = UserDefaults()
    var dicionario: [String: String] = [:]
    var vetorOpcoes = [String]()
    
    override func viewDidLoad() {
        dicionario = ((defaults.dictionary(forKey: "dicValor") as? [String: String])!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func carregaPergunta(){
        
        
    }
}
