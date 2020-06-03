//
//  Tabela.swift
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
        //Recuperar dados
        lerEntradas()
        
        //Tabela
        listaNotas.delegate = self
        listaNotas.dataSource = self
        listaNotas.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Estética
        bttNotaDiaria.layer.cornerRadius = 40
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
      lerEntradas()
      listaNotas.delegate = self
      listaNotas.dataSource = self
      super.viewWillAppear(animated)
    }
    
    func lerEntradas(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EntradasTeste3")

        do {
            notas = try managedContext.fetch(fetchRequest).reversed()
            self.listaNotas.reloadData()
        } catch let error as NSError {
          print("Não foi possível carregar os dados. \(error), \(error.userInfo)")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nota = notas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.text = nota.value(forKeyPath: "criadoEm") as? String
        cell.detailTextLabel?.text = nota.value(forKeyPath: "corpoTexto") as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nota = self.notas[indexPath.row]
        self.performSegue(withIdentifier: "CarregaNota", sender: nota)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CarregaNota"){
            let carregaNotaVC  = segue.destination as! reverEntrada
            carregaNotaVC.nota = sender as? NSManagedObject
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let nota = self.notas[indexPath.row]
            self.objetoGerenciado?.delete(nota)
            self.notas.remove(at: indexPath.row)

            self.listaNotas.deleteRows(at: [indexPath], with: .automatic)
            
            do {
                try objetoGerenciado?.save()
            } catch let erro as NSError {
                print("Não foi possível excluir objeto: \(erro), \(erro.localizedDescription)")
        }
    }
}

class reverEntrada: UIViewController {
    @IBOutlet weak var textViewEntrada: UITextView!
    @IBOutlet weak var viewEntrada: UIView!
    @IBOutlet weak var labelData: UILabel!
    var nota: NSManagedObject!
    
    override func viewDidLoad() {
        textViewEntrada.text = nota.value(forKey: "corpoTexto") as? String
        labelData.text = nota.value(forKey: "labelData") as? String
        estetica(view: viewEntrada, textView: textViewEntrada)
    }
    
    func estetica(view: UIView, textView: UITextView){
        view.layer.cornerRadius = 50
        textView.layer.cornerRadius = 50
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    @IBAction func bttVoltar(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
}
