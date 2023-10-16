//
//  LineChartFilledViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif
import DGCharts

class LineChartFilledViewController: DemoBaseViewController {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Filled Line Chart"
        
        chartView.delegate = self
        
        chartView.backgroundColor = .white
        chartView.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
        chartView.drawGridBackgroundEnabled = true
        
        chartView.drawBordersEnabled = true
        
        chartView.chartDescription.enabled = false
        
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        chartView.legend.enabled = false
        
        chartView.xAxis.enabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMaximum = 900
        leftAxis.axisMinimum = -250
        leftAxis.drawAxisLineEnabled = false
        
        chartView.rightAxis.enabled = false
        
        sliderX.value = 100
        sliderY.value = 60
        slidersValueChanged(nil)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let testArray: [[Double]] = [
            [1.5, 1.6, 1.3, 1.5, 1.7, 2.0, 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -30.0, 0.0, 10.0, 10.0, 20.0, 0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0, 0.0, 20.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 30.0, 20.0, 10.0, 0.0, 0.0, 0.0, 0.0]
//            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 20.0, 15.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        ]
        let colors = ChartColorTemplates.vordiplom()[0...2]
        let fillColors: [NSUIColor] = [
            NSUIColor(red: 255/255.0, green: 239/255.0, blue: 179/255.0, alpha: 1.0),
            NSUIColor(red: 180/255.0, green: 216/255.0, blue: 255/255.0, alpha: 1.0),
            NSUIColor(red: 236/255.0, green: 238/255.0, blue: 241/255.0, alpha: 1.0)
        ]

        let dataSets = (0..<2).map { i -> LineChartDataSet in
            //let yVals = (0..<count).map(block)
            let yVals = testArray[i].enumerated().map { index, element in
                ChartDataEntry(x: Double(index), y: element)
            }
            let set = LineChartDataSet(entries: yVals, label: "DataSet \(i)")
            set.lineWidth = 1
            set.circleRadius = 4
            set.circleHoleRadius = 2
            let color = colors[i % colors.count]
            set.setColor(color)
            set.drawFilledEnabled = true
            set.fillColor = NSUIColor(cgColor: fillColors[i].cgColor)
            set.setCircleColor(color)

            return set
        }
////        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
////            let val = Double(arc4random_uniform(range) + 50)
////            return ChartDataEntry(x: Double(i), y: val)
////        }
////        let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
////            let val = Double(arc4random_uniform(range) + 450)
////            return ChartDataEntry(x: Double(i), y: val)
////        }
//
//        let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
//        set1.axisDependency = .left
//        set1.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
//        set1.drawCirclesEnabled = false
//        set1.lineWidth = 2
//        set1.circleRadius = 3
//        set1.fillAlpha = 1
//        set1.drawFilledEnabled = true
//        set1.fillColor = .white
//        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
//        set1.drawCircleHoleEnabled = false
//        set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
//            return CGFloat(self.chartView.leftAxis.axisMinimum)
//        }
//
//        let set2 = LineChartDataSet(entries: yVals2, label: "DataSet 2")
//        set2.axisDependency = .left
//        set2.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
//        set2.drawCirclesEnabled = false
//        set2.lineWidth = 2
//        set2.circleRadius = 3
//        set2.fillAlpha = 1
//        set2.drawFilledEnabled = true
//        set2.fillColor = .white
//        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
//        set2.drawCircleHoleEnabled = false
//        set2.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
//            return CGFloat(self.chartView.leftAxis.axisMaximum)
//        }

        let data: LineChartData = [dataSets[0], dataSets[1]]
//        let data = LineChartData(dataSets: dataSets)
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
