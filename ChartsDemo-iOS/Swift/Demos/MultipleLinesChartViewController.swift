//
//  MultipleLinesChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif
import DGCharts

class MultipleLinesChartViewController: DemoBaseViewController {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Multiple Lines Chart"
        self.options = [.toggleValues,
                        .toggleFilled,
                        .toggleCircles,
                        .toggleCubic,
                        .toggleStepped,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]

        chartView.delegate = self
        
        chartView.chartDescription.enabled = false

        // have only 3 labels on right side
        chartView.rightAxis.labelCount = 3


        // add kWh
        let formatter = NumberFormatter()
        formatter.negativeSuffix = " kWh\n From Grid"
        formatter.positiveSuffix = " kWh"

        chartView.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)

        chartView.leftAxis.enabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false

        // have only 5 labels on xaxis
        chartView.xAxis.labelCount = 5
        
        chartView.drawBordersEnabled = false
        chartView.setScaleEnabled(true)

//        let l = chartView.legend
//        l.horizontalAlignment = .right
//        l.verticalAlignment = .top
//        l.orientation = .vertical
//        l.drawInside = false
//        chartView.legend = l

        sliderX.value = 20
        sliderY.value = 100
        slidersValueChanged(nil)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }
    
    // TODO: Refine data creation
    func setDataCount(_ count: Int, range: UInt32) {

        // home confumption POC
        let testArray: [[Double]] = [
            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 1.5, 1.3, 1.6, 1.7, 1.4, 1.5, 1.4, 1.6, 1.5, 1.6, 1.8, 1.9, 2.0, 1.6, 2.5, 3.6, 4.8, 4.7, 3.6, 3.3, 3.1, 2.9, 2.7, 2.6, 2.5, 1.5, 1.5, 0.0, 0.0, 0.0, 0.0, 0.0],
            [1.5, 1.4, 1.2, 1.5, 1.3, 1.6, 1.5, 1.1, 1.6, 1.3, 1.5, 1.7, 2.0, 1.5, 1.5, 1.3, 1.3, 1.6, 1.6, 1.7, 1.4, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.3, 1.5, 2.2, 2.4, 2.6, 2.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        ]


//        let testArray: [[Double]] = [
//            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.5, 1.0, 1.5, 2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
//            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.7, 0.8, 0.6, 0.7, 0.7, 1.8, 5.1, 6.1, 2.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
//            [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 4.0, 0.5, 0.0, 4.0, 6.0, 5.0, 4.0, 3.0, 0.0, 0.0, 0.0, 0.0]
//        ]

//        var sumArray: [Double] = zip(testArray[0], testArray[1]).map(+)
//        sumArray = zip(sumArray, testArray[2]).map(+)



        // home consumtipn fill colors

        let colors: [NSUIColor] = [
            NSUIColor(red: 255/255.0, green: 200/255.0, blue: 0/255.0, alpha: 1.0),
            NSUIColor(red: 2/255.0, green: 190/255.0, blue: 77/255.0, alpha: 1.0)
        ]
        let fillColors: [NSUIColor] = [
            NSUIColor(red: 255/255.0, green: 239/255.0, blue: 179/255.0, alpha: 1.0),
            NSUIColor(red: 180/255.0, green: 236/255.0, blue: 202/255.0, alpha: 1.0)
        ]

//        let colors = ChartColorTemplates.vordiplom()[0...3]
//        let fillColors: [NSUIColor] = [
//            NSUIColor(red: 255/255.0, green: 239/255.0, blue: 179/255.0, alpha: 1.0),
//            NSUIColor(red: 180/255.0, green: 216/255.0, blue: 255/255.0, alpha: 1.0),
//            NSUIColor(red: 236/255.0, green: 238/255.0, blue: 241/255.0, alpha: 1.0)
//        ]
        
//        let block: (Int) -> ChartDataEntry = { (i) -> ChartDataEntry in
//            let val = Double(arc4random_uniform(range) + 3)
//            return ChartDataEntry(x: Double(i), y: val)
//        }
        let dataSets = (0..<2).map { i -> LineChartDataSet in
            //let yVals = (0..<count).map(block)
            let yVals = testArray[i].enumerated().map { index, element in
//            let yVals = sumArray.enumerated().map { index, element in
                    //ChartDataEntry(x: Double(index), y: element)

                /// stacked area chart
                /// sum previous y values each x value
                /// needs to be confirmed with design team
                /// maybe better solution is to fill every next graph not from xaxis till it's value, but from previous graph value to current graph value
                if i > 0 {
                    return ChartDataEntry(x: Double(index),
                                   y: element + testArray[i-1][index])
                } else {
                    return ChartDataEntry(x: Double(index),
                                   y: element)
                }
            }
            let set = LineChartDataSet(entries: yVals, label: "DataSet \(i)")
            set.lineWidth = 1
            set.circleRadius = 4
            set.circleHoleRadius = 2
            let color = colors[i % colors.count]
            set.setColor(color)
            set.fillColor = NSUIColor(cgColor: fillColors[i].cgColor)
            set.setCircleColor(color)
            
            return set
        }
        
//        dataSets[0].lineDashLengths = [5, 5]
//        dataSets[0].colors = ChartColorTemplates.vordiplom()
//        dataSets[0].circleColors = ChartColorTemplates.vordiplom()


        // MUST reversed data sets to achieve designs
        let data = LineChartData(dataSets: dataSets.reversed())
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        chartView.data = data
    }
    
    override func optionTapped(_ option: Option) {
        guard let data = chartView.data else { return }

        switch option {
        case .toggleFilled:
            for case let set as LineChartDataSet in data {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCircles:
            for case let set as LineChartDataSet in data {
                set.drawCirclesEnabled = !set.drawCirclesEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCubic:
            for case let set as LineChartDataSet in data {
                set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            }
            chartView.setNeedsDisplay()
            
        case .toggleStepped:
            for case let set as LineChartDataSet in data {
                set.mode = (set.mode == .stepped) ? .linear : .stepped
            }
            chartView.setNeedsDisplay()
            
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }

    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
