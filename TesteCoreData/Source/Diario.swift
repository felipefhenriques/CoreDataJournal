//
//  Diario.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 02/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Entrada: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textViewNota: UITextView!
    var objetoGerenciado: NSManagedObjectContext!
    @IBOutlet weak var viewNota: UIView!
    var entrada: NSManagedObject!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var bttAdicionar: UIButton!
    @IBOutlet weak var labelData: UILabel!
    var entradas: [NSManagedObject]!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
   
    
    override func viewDidLoad() {
        setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.isNavigationBarHidden = true
        textViewNota.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        estetica(view: viewNota, textView: textViewNota, labelData: labelData, botao: bttAdicionar)
    }
    
    func criarNovaEntrada(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd\nMMMM\nyyy"
        let stringData = formatter.string(from: date)
        let formatterLabel = DateFormatter()
        formatterLabel.dateFormat = "dd/MM/yyyy"
        let stringLabel = formatterLabel.string(from: date)
        
        let entidadeEntrada = NSEntityDescription.entity(forEntityName: "Teste4", in: self.objetoGerenciado)
        let objetoEntrada = NSManagedObject(entity: entidadeEntrada!, insertInto: self.objetoGerenciado)
        
        objetoEntrada.setValue(textViewNota.text, forKey: "corpoTexto")
        objetoEntrada.setValue(stringData, forKey: "criadoEm")
        objetoEntrada.setValue(stringLabel, forKey: "labelData")
        
        do {
            try objetoGerenciado.save()
        } catch let error as NSError {
            print("Não foi possível salvar a entrada \(error.description)")
        }
    }
    
    @IBAction func bttVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bttAdicionar(_ sender: UIButton) {
        criarNovaEntrada()
        self.navigationController?.popViewController(animated: true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func estetica(view: UIView, textView: UITextView, labelData: UILabel, botao: UIButton){
        view.layer.cornerRadius = 50
        textView.layer.cornerRadius = 50
        botao.layer.cornerRadius = 40
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        defineData(label: labelData)
    }
    
    
    func defineData(label: UILabel){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        label.text = formatter.string(from: date)
    }

}

