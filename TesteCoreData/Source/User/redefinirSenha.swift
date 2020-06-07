//
//  redefinirSenha.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 05/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit

class redefinirSenha: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var bttRedefinir: UIButton!
    @IBOutlet weak var txtAtual: UITextField!
    @IBOutlet weak var lblAviso: UILabel!
    @IBOutlet weak var txtNova: UITextField!
    var defaults = UserDefaults()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        bttRedefinir.layer.cornerRadius = 30
        txtAtual.layer.cornerRadius = 28
        txtNova.layer.cornerRadius = 28
        txtAtual.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtNova.attributedPlaceholder = NSAttributedString(string: "Senha", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtAtual.delegate = self
        txtNova.delegate = self
    }
    
    
    @IBAction func bttReset(_ sender: Any) {
        defaults.removeObject(forKey: "cadastrou")
    }
    
    @IBAction func bttVoltar(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func bttRedefinir(_ sender: UIButton) {
        verifica()
    }
    
    func verifica(){
        if(txtAtual.text != defaults.value(forKey: "senha") as? String){
            lblAviso.isHidden = false
            txtAtual.text = ""
        } else {
            defaults.set(txtNova.text, forKey: "senha")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        lblAviso.isHidden = true
        return false
    }
}
