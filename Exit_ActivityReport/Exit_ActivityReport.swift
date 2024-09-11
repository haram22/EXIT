//
//  Exit_ActivityReport.swift
//  Exit_ActivityReport
//
//  Created by 김하람 on 9/11/24.
//

import DeviceActivity
import SwiftUI

@main
struct Exit_ActivityReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
