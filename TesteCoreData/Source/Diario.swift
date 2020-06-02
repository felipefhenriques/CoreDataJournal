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

class Lista: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var labelOla: UILabel!
    @IBOutlet weak var bttNotaDiaria: UIButton!
    public var notas:[NSManagedObject] = []
    @IBOutlet weak var listaNotas: UITableView!
    var objetoGerenciado: NSManagedObjectContext?
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        listaNotas.delegate = self
        bttNotaDiaria.layer.cornerRadius = 40
        self.navigationController?.isNavigationBarHidden = true
        listaNotas.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      listaNotas.delegate = self
      super.viewWillAppear(animated)
      lerEntradas()
    }
    
    func lerEntradas(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")

        do {
          notas = try managedContext.fetch(fetchRequest)
//          for i in 0..<notas.count{
//              let entrada = self.notas[i]
//              print(entrada.value(forKey: "corpoTexto") as? String)
//          }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.listaNotas.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let nota = notas[indexPath.row]
        print("tentativa")
        print(cell.textLabel?.text = nota.value(forKeyPath: "criadoEm") as? String)
        print("tentativa2")
        print(cell.detailTextLabel?.text = nota.value(forKeyPath: "corpoTexto") as? String)
        return cell
    }
    
}

class Entrada: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textViewNota: UITextView!
    var objetoGerenciado: NSManagedObjectContext!
    @IBOutlet weak var viewNota: UIView!
    var entrada: NSManagedObject!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var bttAdicionar: UIButton!
    @IBOutlet weak var labelData: UILabel!
    var entradas: [NSManagedObject]!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        textViewNota.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        estetica(view: viewNota, textView: textViewNota, labelData: labelData, botao: bttAdicionar)
    }
    
    func criarNovaEntrada(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let stringData = formatter.string(from: date)
        
        let entidadeEntrada = NSEntityDescription.entity(forEntityName: "Entity", in: self.objetoGerenciado)
        let objetoEntrada = NSManagedObject(entity: entidadeEntrada!, insertInto: self.objetoGerenciado)
        
        objetoEntrada.setValue(textViewNota.text, forKey: "corpoTexto")
        objetoEntrada.setValue(stringData, forKey: "criadoEm")
        
        do {
            try objetoGerenciado.save()
        } catch let error as NSError {
            print("could not save the new entry \(error.description)")
        }
    }
    
    @IBAction func bttVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bttAdicionar(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
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
        formatter.dateFormat = "dd/MM/yyy"
        label.text = formatter.string(from: date)
    }

}
