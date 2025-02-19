import 'package:json_annotation/json_annotation.dart';
import 'package:billDeskSDK/src/model/flow_type.dart';

part 'sdk_config.g.dart';

@JsonSerializable(explicitToJson: true)
class SdkConfiguration{

  Map<String, dynamic>? flowConfig;
  FlowType? flowType;
  dynamic themeConfig;

  String merchantLogo;


  SdkConfiguration(this.flowConfig,this.flowType, this.merchantLogo, this.themeConfig);

  factory SdkConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SdkConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$SdkConfigurationToJson(this);
}