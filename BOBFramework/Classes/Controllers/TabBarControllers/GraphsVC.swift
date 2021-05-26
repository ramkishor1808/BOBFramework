//
//  GraphsVC.swift
//  BOB
//
//  Created by Anushree on 2/22/21.
//  Copyright © 2021 Mayank. All rights reserved.
//

import UIKit
import Charts

@available(iOS 13.0, *)
class GraphsVC:BaseClass  {
    
    @IBOutlet weak var number1: UISlider!
    @IBOutlet weak var number2: UISlider!
    @IBOutlet weak var number3: UISlider!
    @IBOutlet weak var assestAllocationChart: HorizontalBarChartView!
    @IBOutlet weak var productAllocationChart: PieChartView!
    @IBOutlet weak var assestAllocationPrefromanceChart: BarChartView!
    @IBOutlet weak var protfolioPrefromanceChart: BarChartView!
     @IBOutlet weak var mutualFundShcremChart: PieChartView!
    @IBOutlet weak var mutualFundAMCExposureChart: HorizontalBarChartView!
    
    @IBAction func renderCharts() {
        barChartUpdate()
        pieChartUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(GlobleValue.HoldingDataArray)
        self.setNavigationtitle(titleText : "ProtofileAnalysis",view: self,rightImage : "menu")
               self.navigationController?.setNavigationBarHidden(false, animated: true)
        barChartUpdate()
       mutualFundAMCExposureChartHbarChartUpdate ()
        pieChartUpdate()
     APICalling()
    }
    func APICalling()  {
//       AssetClassName
//        ValueAmount
//        ValuePercentage//{"UserId":"adminchecker","LastBusinessDate":"2018-02-07T00:00:00","ClientCode":"1","AllocationType":2,"CurrencyCode":1.0,"AccountLevel":1.0}
   
           
                   let identifier = UUID()
                   let testString = "\(identifier)|BOBWealth"
                   let json = ["RequestBody":["UserId":"adminchecker","LastBusinessDate":"2018-02-07T00:00:00","ClientCode":"32","AllocationType":2,"CurrencyCode":1.0,"AccountLevel":1.0],"Source":"BOBWealth","UniqueIdentifier":"\(identifier)"] as [String : Any]
                                        let jsonString1 = json.jsonDic
                            
                                      
                                let str = jsonString1.trimmingCharacters(in: .whitespacesAndNewlines)
                              let encToken = try! testString.aesEncrypt()
                                let enc = try! str.aesEncrypt()
        //   SVProgressHUD.show()
                    APIManager.shareInstance.AuthenticationRequest(method: "Client/AssetAllocation", TPA: encToken, parameter: enc){
                               (netResponse) -> (Void) in
                               if(netResponse.statusCode == 200){
                                //    SVProgressHUD.dismiss()
                                   print(netResponse.responseDict as Any)
                                 GlobleValue.AssetAllocationDataArray = netResponse.responseDict as? [[String : Any]] ?? [[:]]
          
                                  DispatchQueue.main.async {
                                    self.HbarChartUpdate()
                                    }
                                  }
                               else{
                               //    SVProgressHUD.dismiss()
                       }
                               }
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func barChartUpdate () {
       print(GlobleValue.potfolioDataDic)
        // Basic set up of plan chart
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(20))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(40))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(80))
        let dataSet = BarChartDataSet(entries: [entry1, entry2, entry3])
        let data = BarChartData(dataSets: [dataSet])
        assestAllocationPrefromanceChart.data = data
         protfolioPrefromanceChart.data = data

        // Color
        dataSet.addColor(.red)
        dataSet.colors = ChartColorTemplates.vordiplom()

        // Refresh chart with new data
        assestAllocationPrefromanceChart.notifyDataSetChanged()
         protfolioPrefromanceChart.notifyDataSetChanged()
    }
    func HbarChartUpdate () {
        
        // Basic set up of plan chart
        var count : Int = 0
        var entry :[BarChartDataEntry] = []
        for Assetarr in  GlobleValue.AssetAllocationDataArray {
            print(Assetarr)
            count = count + 1
            entry.append(BarChartDataEntry(x: Double(count), y: Assetarr["ValuePercentage"] as? Double ?? 0.0))
             
        }
        let dataSet = BarChartDataSet(entries: entry)
                   let data = BarChartData(dataSets: [dataSet])
                   assestAllocationChart.data = data
                    dataSet.colors = ChartColorTemplates.vordiplom()
      
        //assestAllocation
       
       // barChart.chartDescription?.text = "Number of Widgets by Type"

        // Color
       

        // Refresh chart with new data
       assestAllocationChart.notifyDataSetChanged()
    }
    func mutualFundAMCExposureChartHbarChartUpdate () {
        
        // Basic set up of plan chart
        var count : Int = 0
        var entry :[BarChartDataEntry] = []
        for Assetarr in  GlobleValue.HoldingDataArray {
            print(Assetarr)
            count = count + 1
            entry.append(BarChartDataEntry(x: Double(count), y: Assetarr["MarketValue1"] as? Double ?? 0.0))
             
        }
        let dataSet = BarChartDataSet(entries: entry )
                   let data = BarChartData(dataSets: [dataSet])
                   mutualFundAMCExposureChart.data = data
                    dataSet.colors = ChartColorTemplates.vordiplom()
      
        //assestAllocation
       
       // barChart.chartDescription?.text = "Number of Widgets by Type"

        // Color
       

        // Refresh chart with new data
        mutualFundAMCExposureChart.notifyDataSetChanged()
    }
    
    func pieChartUpdate () {
     //   Source
     //   (Sum of Market Value for Product)/(Total Market Value) * 100
//let reducedNumberSum = numbers.reduce(0,+) // returns 10
        var AmtArr  = [Int]()
        for Arr in  GlobleValue.HoldingDataArray{
            AmtArr.append(Int(Arr["MarketValue"]  as? Double ?? 0.0) )
         }
        print(AmtArr)
         let total = AmtArr.sum()
         print(total)
        var count : Int = 0
              var entry :[PieChartDataEntry] = []
              for Assetarr in  GlobleValue.HoldingDataArray {
                  print(Assetarr)
                  count = count + 1
                let mar = Int(Assetarr["MarketValue"]  as? Double ?? 0.0)
                let sum = mar / total * 100
               entry.append(PieChartDataEntry(value :Double(sum)))
                   
              }
     //  let name = GlobleValue.HoldingDataArray[0][Source] as ? String
       //  let dataValue = GlobleValue.HoldingDataArray[0][Source] as ? String
//        let entry1 = PieChartDataEntry(value: Double(20))
//        let entry2 = PieChartDataEntry(value: Double(80))
//        let entry3 = PieChartDataEntry(value: Double(122))
        let dataSet = PieChartDataSet(entries: entry)
        let data = PieChartData(dataSet: dataSet)
        dataSet.color(atIndex: 0)
        productAllocationChart.data = data
         mutualFundShcremChart.data = data
      //  pieChart.chartDescription?.text = "Share of Widgets by Type"

        // Color
        dataSet.colors = ChartColorTemplates.joyful()
        //dataSet.valueColors = [UIColor.black]
       // pieChart.backgroundColor = UIColor.black
    //   pieChart.holeColor = UIColor.clear
        //pieChart.chartDescription?.textColor = UIColor.white
        //pieChart.legend.textColor = UIColor.white
       
        // Text
//        pieChart.legend.font = UIFont(name: "Futura", size: 10)!
//        pieChart.chartDescription?.font = UIFont(name: "Futura", size: 12)!
//        pieChart.chartDescription?.xOffset = pieChart.frame.width
//        pieChart.chartDescription?.yOffset = pieChart.frame.height * (2/3)
//        pieChart.chartDescription?.textAlign = NSTextAlignment.left

        // Refresh chart with new data
        productAllocationChart.notifyDataSetChanged()
         mutualFundShcremChart.notifyDataSetChanged()
    }


}

