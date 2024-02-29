import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'offers_model.g.dart';

@JsonSerializable()
class OffersModel with EquatableMixin {
  @JsonKey(name: 'annual_rate')
  double? annualRate;
  @JsonKey(name: 'bank')
  String? bank;
  @JsonKey(name: 'bank_id')
  int? bankId;
  @JsonKey(name: 'bank_type')
  String? bankType;
  @JsonKey(name: 'detail_note')
  String? detailNote;
  @JsonKey(name: 'expertise')
  double? expertise;
  @JsonKey(name: 'footnote')
  String? footnote;
  @JsonKey(name: 'hypothec_fee')
  double? hypothecFee;
  @JsonKey(name: 'interest_rate')
  double? interestRate;
  @JsonKey(name: 'logo_url')
  String? logoUrl;
  @JsonKey(name: 'note')
  String? note;
  @JsonKey(name: 'product_name')
  String? productName;
  @JsonKey(name: 'sponsored_rate')
  double? sponsoredRate;
  @JsonKey(name: 'url')
  String? url;

  OffersModel({
    this.annualRate,
    this.bank,
    this.bankId,
    this.bankType,
    this.detailNote,
    this.expertise,
    this.footnote,
    this.hypothecFee,
    this.interestRate,
    this.logoUrl,
    this.note,
    this.productName,
    this.sponsoredRate,
    this.url,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) =>
      _$OffersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OffersModelToJson(this);

  @override
  List<Object?> get props => [
        annualRate,
        bank,
        bankId,
        bankType,
        detailNote,
        expertise,
        footnote,
        hypothecFee,
        interestRate,
        logoUrl,
        note,
        productName,
        sponsoredRate,
        url
      ];

  OffersModel copyWith({
    double? annualRate,
    String? bank,
    int? bankId,
    String? bankType,
    String? detailNote,
    double? expertise,
    String? footnote,
    double? hypothecFee,
    double? interestRate,
    String? logoUrl,
    String? note,
    String? productName,
    double? sponsoredRate,
    String? url,
  }) {
    return OffersModel(
      annualRate: annualRate ?? this.annualRate,
      bank: bank ?? this.bank,
      bankId: bankId ?? this.bankId,
      bankType: bankType ?? this.bankType,
      detailNote: detailNote ?? this.detailNote,
      expertise: expertise ?? this.expertise,
      footnote: footnote ?? this.footnote,
      hypothecFee: hypothecFee ?? this.hypothecFee,
      interestRate: interestRate ?? this.interestRate,
      logoUrl: logoUrl ?? this.logoUrl,
      note: note ?? this.note,
      productName: productName ?? this.productName,
      sponsoredRate: sponsoredRate ?? this.sponsoredRate,
      url: url ?? this.url,
    );
  }
}
