//
//  ViewController.swift
//  15_04_24_WebServicesDemoDay1
//
//  Created by Vishal Jagtap on 20/05/24.
//

import UIKit

class ViewController: UIViewController {
    var urlString : String?
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var companies : [Company] = []
    private let reuseIdentifierForCell = "CompanyTableViewCell"
    var uiNib : UINib?
    
    @IBOutlet weak var companyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        registerCompanyTableViewWithXIB()
        serializeJSON()
    }
    
    func initializeTableView(){
        companyTableView.dataSource = self
        companyTableView.delegate = self
    }
    
    func registerCompanyTableViewWithXIB(){
        uiNib = UINib(nibName: reuseIdentifierForCell, bundle: nil)
        companyTableView.register(uiNib, forCellReuseIdentifier: reuseIdentifierForCell)
    }
    
    func serializeJSON(){
        urlString = "https://fake-json-api.mock.beeceptor.com/companies"
        url = URL(string:urlString!)
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!){ data, response, error in
            print(data)
            print(response)
            print(error)
            
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            for eachCompany in jsonResponse{
    
                let eachCompanyId = eachCompany["id"] as! Int
                let eachCompanyName = eachCompany["name"] as! String
                let eachCompanyAddress = eachCompany["address"] as! String
                let eachCompanyZip = eachCompany["zip"] as! String
                let eachCompanyCountry = eachCompany["country"] as! String
                
                let companySwiftObject = Company(id: eachCompanyId, name: eachCompanyName, address: eachCompanyAddress, zip: eachCompanyZip, country: eachCompanyCountry)
                self.companies.append(companySwiftObject)
            }
            
            DispatchQueue.main.async {
                self.companyTableView.reloadData()
            }
            
            print(self.companies)
        }.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let companyTableViewCell = self.companyTableView.dequeueReusableCell(withIdentifier: reuseIdentifierForCell, for: indexPath) as! CompanyTableViewCell
        
        companyTableViewCell.companyNameLabel.text = companies[indexPath.row].name
        companyTableViewCell.companyZipLabel.text = companies[indexPath.row].zip
        companyTableViewCell.companyCountryLabel.text = companies[indexPath.row].country
        
        return companyTableViewCell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
}
