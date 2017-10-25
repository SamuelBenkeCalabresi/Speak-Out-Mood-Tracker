//  PieChartViewController.swift
//  Speak Out!
//
//  Created by admin on 08/06/2017.
//  Copyright © 2017 Samuel Benke Calabresi. All rights reserved.

import UIKit
import CoreData
import CorePlot

class PieChartViewController: UIViewController {
    
    @IBOutlet weak var hostView: CPTGraphHostingView!
    
    // DB Model to use
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let dbEntityName = "MoodsInDB3"
    // Array counter
    var moodCounter = [0,0,0,0,0]
    var symbols = ["Low", "Bad", "Ok", "Good", "Rad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDatabase()
        for number in moodCounter {
            print("THIS MOOD HAS \(number) NUMBER OF TIMES")
        }
    }
    
    // This should be called every time the view for the calendar has to be rendered
    func fetchDatabase() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntityName)
        request.returnsObjectsAsFaults = false
        do {
            var counter:Int = 0
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    counter += 1
                    // get attribute mood code from entity result
                    if let moodCode = result.value(forKey: "moodCode") as? String {
                        // switch to choose value is from
                        let moodCodeAsInt = Int(moodCode)!
                        print("THE moodCode is equal to \(moodCode)\r")
                        switch moodCodeAsInt {
                        case -2:
                            moodCounter[0] += 1
                        case -1:
                            moodCounter[1] += 1
                        case +0:
                            moodCounter[2] += 1
                        case +1:
                            moodCounter[3] += 1
                        case +2:
                            moodCounter[4] += 1
                        default:
                            moodCounter[0] = moodCounter[0]
                        }
                    }
                }
                print("THE NUMBER OF ENTRIES IN THE DB ARE: \(counter)")
            }
        } catch {
            // PROCESS ERROR
            print("ERROR FETCHING DATA")
        }
    }
    
    //// PLOT DATA IN PIE GRAP
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initPlot()
    }
    
    func initPlot() {
        configureHostView()
        configureGraph()
        configureChart()
//        configureLegend()
    }
    
    func configureHostView() {
        hostView.allowPinchScaling = false
    }
    
    func configureGraph() {
        // 1 - Create and configure the graph
        let graph = CPTXYGraph(frame: hostView.bounds)
        hostView.hostedGraph = graph
        graph.paddingLeft = 0.0
        graph.paddingTop = 0.0
        graph.paddingRight = 0.0
        graph.paddingBottom = 0.0
        graph.axisSet = nil
        
        // 2 - Create text style
        let textStyle: CPTMutableTextStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.black()
        textStyle.fontName = "AvenirNext-Medium"
        textStyle.fontSize = 17.0
        textStyle.textAlignment = .center
        
        // 3 - Set graph title and text style
        graph.title = "Pie chart mood stats"
        graph.titleTextStyle = textStyle
        graph.titlePlotAreaFrameAnchor = CPTRectAnchor.top
    }
    
    func configureChart() {
        // 1 - Get a reference to the graph
        let graph = hostView.hostedGraph!
        
        // 2 - Create the chart
        let pieChart = CPTPieChart()
        pieChart.delegate = self
        pieChart.dataSource = self
        pieChart.pieRadius = (min(hostView.bounds.size.width, hostView.bounds.size.height) * 0.7) / 2
        pieChart.identifier = NSString(string: graph.title!)
        pieChart.startAngle = CGFloat(M_PI_4)
        pieChart.sliceDirection = .clockwise
        pieChart.labelOffset = -0.6 * pieChart.pieRadius
        
        // 3 - Configure border style
        let borderStyle = CPTMutableLineStyle()
        borderStyle.lineColor = CPTColor.white()
        borderStyle.lineWidth = 2.0
        pieChart.borderLineStyle = borderStyle
        
        // 4 - Configure text style
        let textStyle = CPTMutableTextStyle()
        textStyle.color = CPTColor.white()
        textStyle.textAlignment = .center
        pieChart.labelTextStyle = textStyle
        
        // 5 - Add chart to graph
        graph.add(pieChart)
    }
    
//    func configureLegend() {
//        // 1 - Get graph instance
//        guard let graph = hostView.hostedGraph else { return }
//        
//        // 2 - Create legend
//        let theLegend = CPTLegend(graph: graph)
//        
//        // 3 - Configure legend
//        theLegend.numberOfColumns = 3
//        theLegend.fill = CPTFill(color: CPTColor.white())
//        let textStyle = CPTMutableTextStyle()
//        textStyle.fontSize = 12
//        theLegend.textStyle = textStyle
//        
//        // 4 - Add legend to graph
//        graph.legend = theLegend
//        if view.bounds.width > view.bounds.height {
//            graph.legendAnchor = .right
//            graph.legendDisplacement = CGPoint(x: -20, y: 0.0)
//            
//        } else {
//            graph.legendAnchor = .bottomRight
//            graph.legendDisplacement = CGPoint(x: -8.0, y: 8.0)
//        }
//    }
}

extension PieChartViewController: CPTPieChartDataSource, CPTPieChartDelegate {
    
    // Get from the MODEL the number of slices to display in the PieChart
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(moodCounter.count)
    }
    
    // Get the size of each slice given the return value (Any?)
    // i.e. is here that the MODEL has to give the values to show the size of all the moods
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        let currentMoodCount = Float(moodCounter[Int(idx)])
        return 1 * currentMoodCount
    }
    
    //    // Get from the MODEL the labels/titles of each slice
    //    func dataLabel(for plot: CPTPlot, record idx: UInt) -> CPTLayer? {
    //        let layer = CPTTextLayer(text: String(format: "\(symbols[Int(idx)])\n%.2f", moodCounter[Int(idx)]))
    //        layer.textStyle = plot.labelTextStyle
    //        return layer
    //    }
    
    // Fill the slices given the index of the slice
    // Use the colour always used to represent the moods
    func sliceFill(for pieChart: CPTPieChart, record idx: UInt) -> CPTFill? {
        switch idx {
        case 0:   return CPTFill(color: CPTColor(componentRed:0.27, green:0.19, blue:0.81, alpha:1.00))
        case 1:   return CPTFill(color: CPTColor(componentRed:0.0, green:0.71, blue:0.94, alpha:1.00))
        case 2:   return CPTFill(color: CPTColor(componentRed:0.81, green:0.59, blue:1.0, alpha:1.00))
        case 3:   return CPTFill(color: CPTColor(componentRed:0.98, green:0.78, blue:0.31, alpha:1.00))
        case 4:   return CPTFill(color: CPTColor(componentRed:0.98, green:0.46, blue:0.49, alpha:1.00))
        default:  return nil
        }
    }
//    
//    func legendTitle(for pieChart: CPTPieChart, record idx: UInt) -> String? {
//        return symbols[Int(idx)]
//    }
}
