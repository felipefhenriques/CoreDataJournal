//
//  ViewController.swift
//  TesteCoreData
//
//  Created by Felipe Ferreira on 01/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var objetoGerenciado: NSManagedObjectContext!
    var entrada: NSManagedObject!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        criarNovaEntrada()
    }
    
    func criarNovaEntrada(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let stringData = formatter.string(from: date)
        
        let entidadeEntrada = NSEntityDescription.entity(forEntityName: "Nota", in: self.objetoGerenciado)
        let objetoEntrada = NSManagedObject(entity: entidadeEntrada!, insertInto: self.objetoGerenciado)
        
        objetoEntrada.setValue("texto", forKey: "corpoTexto")
        objetoEntrada.setValue(stringData, forKey: "criadoEm")
        
        do {
            try objetoGerenciado.save()
        } catch let error as NSError {
            print("could not save the new entry \(error.description)")
        }
    }


}

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    var entradas: [NSManagedObject]!
    var objetoGerenciado: NSManagedObjectContext!
    @IBOutlet weak var tabela: UITableView!
    
    override func viewDidLoad() {
        tabela.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        buscarEntradas()
        
    }
    
    func buscarEntradas(){
        let pedidoBusca = NSFetchRequest<NSManagedObject>(entityName: "Nota") // <NSManagedObject>
        do {
            let objetosEntrada = try objetoGerenciado.fetch(pedidoBusca)
            self.entradas = objetosEntrada
            for i in 0..<5{
                let entrada = self.entradas[i]
                print(entrada.value(forKey: "corpoTexto") as? String)
            }
        } catch let erro as NSError {
            print("Não foi possível buscar entradas\(erro), \(erro.userInfo)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celula", for: indexPath)
        let entrada = entradas[indexPath.row]
        
        cell.textLabel?.text = entrada.value(forKey: "corpoTexto") as? String
        cell.detailTextLabel?.text = entrada.value(forKey: "criadoEm") as? String
        
        
        return cell
    }
}

