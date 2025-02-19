class Locationlist {
  String? status;
  int? code;
  Data? data;

  Locationlist({this.status, this.code, this.data});

  Locationlist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<DataList>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataList>[];
      json['data'].forEach((v) {
        data!.add(DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataList {
  String? id;
  D? d;
  MetaD? metaD;
  String? serialNo;
  int? createdDate;
  String? createdBy;
  int? sourceDate;

  DataList(
      {this.id,
        this.d,
        this.metaD,
        this.serialNo,
        this.createdDate,
        this.createdBy,
        this.sourceDate});

  DataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    d = json['d'] != null ? D.fromJson(json['d']) : null;
    metaD = json['meta_d'] != null ? MetaD.fromJson(json['meta_d']) : null;
    serialNo = json['serial_no'];
    createdDate = json['created_date'];
    createdBy = json['created_by'];
    sourceDate = json['source_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (d != null) {
      data['d'] = d!.toJson();
    }
    if (metaD != null) {
      data['meta_d'] = metaD!.toJson();
    }
    data['serial_no'] = serialNo;
    data['created_date'] = createdDate;
    data['created_by'] = createdBy;
    data['source_date'] = sourceDate;
    return data;
  }
}

class D {
  String? server;
  String? latitude;
  bool? hst;
  String? mainPower;
  double? alt;
  String? rawDataId;
  String? nwOperator;
  double? speed;
  int? satelliteCount;
  String? imeiNo;
  String? vehicleMode;
  int? gsmSignalStrength;
  int? gnssFix;
  String? ignition;
  String? serialNo;
  String? packetType;
  bool? validStatus;
  String? longitude;
  int? sourceDate;
  String? data;
  int? invalidReason;

  D(
      {this.server,
        this.latitude,
        this.hst,
        this.mainPower,
        this.alt,
        this.rawDataId,
        this.nwOperator,
        this.speed,
        this.satelliteCount,
        this.imeiNo,
        this.vehicleMode,
        this.gsmSignalStrength,
        this.gnssFix,
        this.ignition,
        this.serialNo,
        this.packetType,
        this.validStatus,
        this.longitude,
        this.sourceDate,
        this.data,
        this.invalidReason});

  D.fromJson(Map<String, dynamic> json) {
    server = json['server'];
    latitude = json['latitude'];
    hst = json['hst'];
    mainPower = json['main_power'];
    alt = json['alt'];
    rawDataId = json['raw_data_id'];
    nwOperator = json['nw_operator'];
    speed = json['speed'];
    satelliteCount = json['satellite_count'];
    imeiNo = json['imei_no'];
    vehicleMode = json['vehicle_mode'];
    gsmSignalStrength = json['gsm_signal_strength'];
    gnssFix = json['gnss_fix'];
    ignition = json['ignition'];
    serialNo = json['serial_no'];
    packetType = json['packet_type'];
    validStatus = json['valid_status'];
    longitude = json['longitude'];
    sourceDate = json['source_date'];
    data = json['data'];
    invalidReason = json['invalid_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['server'] = server;
    data['latitude'] = latitude;
    data['hst'] = hst;
    data['main_power'] = mainPower;
    data['alt'] = alt;
    data['raw_data_id'] = rawDataId;
    data['nw_operator'] = nwOperator;
    data['speed'] = speed;
    data['satellite_count'] = satelliteCount;
    data['imei_no'] = imeiNo;
    data['vehicle_mode'] = vehicleMode;
    data['gsm_signal_strength'] = gsmSignalStrength;
    data['gnss_fix'] = gnssFix;
    data['ignition'] = ignition;
    data['serial_no'] = serialNo;
    data['packet_type'] = packetType;
    data['valid_status'] = validStatus;
    data['longitude'] = longitude;
    data['source_date'] = sourceDate;
    data['data'] = this.data;
    data['invalid_reason'] = invalidReason;
    return data;
  }
}

class MetaD {
  String? fleet;
  String? vehicleRegistration;
  String? vendor;
  String? dealer;
  String? distributor;

  MetaD(
      {this.fleet,
        this.vehicleRegistration,
        this.vendor,
        this.dealer,
        this.distributor});

  MetaD.fromJson(Map<String, dynamic> json) {
    fleet = json['fleet'];
    vehicleRegistration = json['vehicle_registration'];
    vendor = json['vendor'];
    dealer = json['dealer'];
    distributor = json['distributor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fleet'] = fleet;
    data['vehicle_registration'] = vehicleRegistration;
    data['vendor'] = vendor;
    data['dealer'] = dealer;
    data['distributor'] = distributor;
    return data;
  }
}

//Gps Device
class GpsDevice {
  String? deviceName;
  String? token;

  GpsDevice({this.deviceName, this.token});

  GpsDevice.fromJson(Map<String, dynamic> json) {
    deviceName = json['deviceName'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceName'] = this.deviceName;
    data['token'] = this.token;
    return data;
  }
}

//BUs List Model

class BusImeiNoList {
  String? busName;
  String? imeiNumber;

  BusImeiNoList({this.busName, this.imeiNumber});

  BusImeiNoList.fromJson(Map<String, dynamic> json) {
    busName = json['busName'];
    imeiNumber = json['imeiNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busName'] = this.busName;
    data['imeiNumber'] = this.imeiNumber;
    return data;
  }
}




