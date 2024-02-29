import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'sponsored_offers.g.dart';

@JsonSerializable()
class SponsoredOffers with EquatableMixin {
  @JsonKey(name: 'ad_button_text')
  String? adButtonText;
  @JsonKey(name: 'ad_content')
  String? adContent;
  @JsonKey(name: 'ad_details')
  String? adDetails;
  @JsonKey(name: 'ad_display_type')
  String? adDisplayType;
  @JsonKey(name: 'ad_header')
  String? adHeader;
  @JsonKey(name: 'ad_img_link')
  String? adImgLink;
  @JsonKey(name: 'ad_name')
  String? adName;
  @JsonKey(name: 'ad_utm_link')
  String? adUtmLink;
  @JsonKey(name: 'badge_text')
  String? badgeText;
  @JsonKey(name: 'bank')
  String? bank;
  @JsonKey(name: 'bank_id')
  int? bankId;
  @JsonKey(name: 'end_date')
  String? endDate;
  @JsonKey(name: 'footnote')
  String? footnote;
  @JsonKey(name: 'list_type')
  int? listType;
  @JsonKey(name: 'logo_url')
  String? logoUrl;
  @JsonKey(name: 'product_type')
  int? productType;
  @JsonKey(name: 'sponsored_rate')
  int? sponsoredRate;

  SponsoredOffers({
    this.adButtonText,
    this.adContent,
    this.adDetails,
    this.adDisplayType,
    this.adHeader,
    this.adImgLink,
    this.adName,
    this.adUtmLink,
    this.badgeText,
    this.bank,
    this.bankId,
    this.endDate,
    this.footnote,
    this.listType,
    this.logoUrl,
    this.productType,
    this.sponsoredRate,
  });

  factory SponsoredOffers.fromJson(Map<String, dynamic> json) =>
      _$SponsoredOffersFromJson(json);

  Map<String, dynamic> toJson() => _$SponsoredOffersToJson(this);

  @override
  List<Object?> get props => [
        adButtonText,
        adContent,
        adDetails,
        adDisplayType,
        adHeader,
        adImgLink,
        adName,
        adUtmLink,
        badgeText,
        bank,
        bankId,
        endDate,
        footnote,
        listType,
        logoUrl,
        productType,
        sponsoredRate
      ];

  SponsoredOffers copyWith({
    String? adButtonText,
    String? adContent,
    String? adDetails,
    String? adDisplayType,
    String? adHeader,
    String? adImgLink,
    String? adName,
    String? adUtmLink,
    String? badgeText,
    String? bank,
    int? bankId,
    String? endDate,
    String? footnote,
    int? listType,
    String? logoUrl,
    int? productType,
    int? sponsoredRate,
  }) {
    return SponsoredOffers(
      adButtonText: adButtonText ?? this.adButtonText,
      adContent: adContent ?? this.adContent,
      adDetails: adDetails ?? this.adDetails,
      adDisplayType: adDisplayType ?? this.adDisplayType,
      adHeader: adHeader ?? this.adHeader,
      adImgLink: adImgLink ?? this.adImgLink,
      adName: adName ?? this.adName,
      adUtmLink: adUtmLink ?? this.adUtmLink,
      badgeText: badgeText ?? this.badgeText,
      bank: bank ?? this.bank,
      bankId: bankId ?? this.bankId,
      endDate: endDate ?? this.endDate,
      footnote: footnote ?? this.footnote,
      listType: listType ?? this.listType,
      logoUrl: logoUrl ?? this.logoUrl,
      productType: productType ?? this.productType,
      sponsoredRate: sponsoredRate ?? this.sponsoredRate,
    );
  }
}
