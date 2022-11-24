// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coachingDater.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachingData _$CoachingDataFromJson(Map<String, dynamic> json) => CoachingData(
      json['companyName'] as String,
      DateTime.parse(json['time'] as String),
      CoachingData.ColorFromJson(json['background']),
      json['isAllDay'] as bool,
      (json['face_point'] as num).toDouble(),
      (json['voice_point'] as num).toDouble(),
    )..to = DateTime.parse(json['to'] as String);

Map<String, dynamic> _$CoachingDataToJson(CoachingData instance) =>
    <String, dynamic>{
      'background': CoachingData.ColorToJson(instance.background),
      'companyName': instance.companyName,
      'time': instance.time.toIso8601String(),
      'to': instance.to.toIso8601String(),
      'isAllDay': instance.isAllDay,
      'face_point': instance.face_point,
      'voice_point': instance.voice_point,
    };
