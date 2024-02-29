// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersResponse _$OffersResponseFromJson(Map<String, dynamic> json) =>
    OffersResponse(
      activeOffers: (json['active_offers'] as List<dynamic>?)
          ?.map((e) => OffersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      amount: json['amount'] as int?,
      carCondition: json['carCondition'],
      clientId: json['client_id'],
      createdAt: json['created_at'],
      id: json['id'],
      maturity: json['maturity'] as int?,
      passiveOffers: (json['passive_offers'] as List<dynamic>?)
          ?.map((e) => OffersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sponsoredOffers: (json['sponsored_offers'] as List<dynamic>?)
          ?.map((e) => SponsoredOffers.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$OffersResponseToJson(OffersResponse instance) =>
    <String, dynamic>{
      'active_offers': instance.activeOffers,
      'amount': instance.amount,
      'carCondition': instance.carCondition,
      'client_id': instance.clientId,
      'created_at': instance.createdAt,
      'id': instance.id,
      'maturity': instance.maturity,
      'passive_offers': instance.passiveOffers,
      'sponsored_offers': instance.sponsoredOffers,
      'type': instance.type,
    };
