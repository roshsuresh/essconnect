// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SdkConfiguration _$SdkConfigurationFromJson(Map<String, dynamic> json) =>
    SdkConfiguration(
      json['flowConfig'] as Map<String, dynamic>?,
      $enumDecodeNullable(_$FlowTypeEnumMap, json['flowType']),
      json['merchantLogo'] as String,
      json['themeConfig'],
    );

Map<String, dynamic> _$SdkConfigurationToJson(SdkConfiguration instance) =>
    <String, dynamic>{
      'flowConfig': instance.flowConfig,
      'flowType': _$FlowTypeEnumMap[instance.flowType],
      'themeConfig': instance.themeConfig,
      'merchantLogo': instance.merchantLogo,
    };

const _$FlowTypeEnumMap = {
  FlowType.payments: 'payments',
  FlowType.e_mandate: 'e_mandate',
  FlowType.modify_mandate: 'modify_mandate',
  FlowType.payment_plus_mandate: 'payment_plus_mandate',
};
