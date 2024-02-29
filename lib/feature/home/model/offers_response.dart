import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'offers_model.dart';
import 'sponsored_offers.dart';

part 'offers_response.g.dart';

@JsonSerializable()
class OffersResponse with EquatableMixin {
  @JsonKey(name: 'active_offers')
  List<OffersModel>? activeOffers;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'carCondition')
  dynamic carCondition;
  @JsonKey(name: 'client_id')
  dynamic clientId;
  @JsonKey(name: 'created_at')
  dynamic createdAt;
  @JsonKey(name: 'id')
  dynamic id;
  @JsonKey(name: 'maturity')
  int? maturity;
  @JsonKey(name: 'passive_offers')
  List<OffersModel>? passiveOffers;
  @JsonKey(name: 'sponsored_offers')
  List<SponsoredOffers>? sponsoredOffers;
  @JsonKey(name: 'type')
  String? type;

  OffersResponse({
    this.activeOffers,
    this.amount,
    this.carCondition,
    this.clientId,
    this.createdAt,
    this.id,
    this.maturity,
    this.passiveOffers,
    this.sponsoredOffers,
    this.type,
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) =>
      _$OffersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OffersResponseToJson(this);

  @override
  List<Object?> get props => [
        activeOffers,
        amount,
        carCondition,
        clientId,
        createdAt,
        id,
        maturity,
        passiveOffers,
        sponsoredOffers,
        type
      ];

  OffersResponse copyWith({
    List<OffersModel>? activeOffers,
    int? amount,
    dynamic carCondition,
    dynamic clientId,
    dynamic createdAt,
    dynamic id,
    int? maturity,
    List<OffersModel>? passiveOffers,
    List<SponsoredOffers>? sponsoredOffers,
    String? type,
  }) {
    return OffersResponse(
      activeOffers: activeOffers ?? this.activeOffers,
      amount: amount ?? this.amount,
      carCondition: carCondition ?? this.carCondition,
      clientId: clientId ?? this.clientId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      maturity: maturity ?? this.maturity,
      passiveOffers: passiveOffers ?? this.passiveOffers,
      sponsoredOffers: sponsoredOffers ?? this.sponsoredOffers,
      type: type ?? this.type,
    );
  }
}
