//
//  Vehicle.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct Vehicle {

    /// The unique identifier of the vehicle
    public var id: String = ""

    /// The unique identifier of the vehicle (use id)
    public var vehicleId: Int = 0

    /// The unique identifier of the user of the vehicle
    public var userId: Int = 0

    /// The display name of the vehicle
    public var displayName: String = ""

    /// The options of the vehicle
    public var options: [VehicleOption] = []

    /// The vehicle's vehicle identification number
    public var vin: VIN?

    /// The vehicle's current state
    public var status: VehicleStatus = VehicleStatus.asleep

    /// The vehicle's remote start configuration
    public var remoteStartEnabled: Bool = false

    ///
    public var tokens: [String] = []

    ///
    public var inService: Bool = false

    ///
    public var chargeState: ChargeState = ChargeState()

    ///
    public var climateState: ClimateState = ClimateState()

    ///
    public var guiSettings: GUISettings = GUISettings()

    ///
    public var driveState: DriveState = DriveState()

    ///
    public var vehicleState: VehicleState = VehicleState()

    ///
    public var vehicleConfig: VehicleConfig = VehicleConfig()

    ///
    public init() {}

    ///
    public var timestamp: TimeInterval { return self.climateState.timestamp }
}

extension Vehicle: DataResponse {
    public mutating func mapping(map: Map) {
        let isVehicleData: Bool = !(map.JSON["id_s"] is String)
        if isVehicleData {
            displayName <- map["response.display_name"]
            id <- map["response.id_s"]
            options <- (map["response.option_codes"], VehicleOptionTransform(separator: ","))
            userId <- map["response.user_id"]
            vehicleId <- map["response.vehicle_id"]
            vin <- (map["response.vin"], VINTransform())
            status <- (map["response.state"], EnumTransform())
            remoteStartEnabled <- map["response.remote_start_enabled"]
            tokens <- map["response.tokens"]
            chargeState <- map["response.charge_state"]
            climateState <- map["response.climate_state"]
            guiSettings <- map["response.gui_settings"]
            driveState <- map["response.drive_state"]
            vehicleState <- map["response.vehicle_state"]
            vehicleConfig <- map["response.vehicle_config"]
            inService <- map["response.in_service"]
        } else {
            displayName <- map["display_name"]
            id <- map["id_s"]
            options <- (map["option_codes"], VehicleOptionTransform(separator: ","))
            userId <- map["user_id"]
            vehicleId <- map["vehicle_id"]
            vin <- (map["vin"], VINTransform())
            status <- (map["state"], EnumTransform())
            remoteStartEnabled <- map["remote_start_enabled"]
            tokens <- map["tokens"]
        }
    }
}

extension Vehicle: Equatable {
    public static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.chargeState.batteryLevel == rhs.chargeState.batteryLevel
            && lhs.chargeState.batteryRange == rhs.chargeState.batteryRange
    }
}

