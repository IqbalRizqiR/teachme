// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tutor_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TutorSubjectDto {

 String get id; String get subjectId; String get subjectName; int get priceIdr;
/// Create a copy of TutorSubjectDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorSubjectDtoCopyWith<TutorSubjectDto> get copyWith => _$TutorSubjectDtoCopyWithImpl<TutorSubjectDto>(this as TutorSubjectDto, _$identity);

  /// Serializes this TutorSubjectDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TutorSubjectDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorSubjectDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.priceIdr, _this.priceIdr) || other.priceIdr == _this.priceIdr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TutorSubjectDto;
  return Object.hash(runtimeType,_this.id,_this.subjectId,_this.subjectName,_this.priceIdr);
}

@override
String toString() {
  final _this = this as TutorSubjectDto;
  return 'TutorSubjectDto(id: ${_this.id}, subjectId: ${_this.subjectId}, subjectName: ${_this.subjectName}, priceIdr: ${_this.priceIdr})';
}


}

/// @nodoc
abstract mixin class $TutorSubjectDtoCopyWith<$Res>  {
  factory $TutorSubjectDtoCopyWith(TutorSubjectDto value, $Res Function(TutorSubjectDto) _then) = _$TutorSubjectDtoCopyWithImpl;
@useResult
$Res call({
 String id, String subjectId, String subjectName, int priceIdr
});




}
/// @nodoc
class _$TutorSubjectDtoCopyWithImpl<$Res>
    implements $TutorSubjectDtoCopyWith<$Res> {
  _$TutorSubjectDtoCopyWithImpl(this._self, this._then);

  final TutorSubjectDto _self;
  final $Res Function(TutorSubjectDto) _then;

/// Create a copy of TutorSubjectDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subjectId = null,Object? subjectName = null,Object? priceIdr = null,}) {
  return _then(TutorSubjectDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,priceIdr: null == priceIdr ? _self.priceIdr : priceIdr // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TutorSubjectDto].
extension TutorSubjectDtoPatterns on TutorSubjectDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TutorSubjectDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TutorSubjectDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TutorSubjectDto value)  $default,){
final _that = this;
switch (_that) {
case _TutorSubjectDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TutorSubjectDto value)?  $default,){
final _that = this;
switch (_that) {
case _TutorSubjectDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subjectId,  String subjectName,  int priceIdr)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TutorSubjectDto() when $default != null:
return $default(_that.id,_that.subjectId,_that.subjectName,_that.priceIdr);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subjectId,  String subjectName,  int priceIdr)  $default,) {final _that = this;
switch (_that) {
case _TutorSubjectDto():
return $default(_that.id,_that.subjectId,_that.subjectName,_that.priceIdr);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subjectId,  String subjectName,  int priceIdr)?  $default,) {final _that = this;
switch (_that) {
case _TutorSubjectDto() when $default != null:
return $default(_that.id,_that.subjectId,_that.subjectName,_that.priceIdr);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TutorSubjectDto implements TutorSubjectDto {
  const _TutorSubjectDto({required this.id, required this.subjectId, required this.subjectName, required this.priceIdr});
  factory _TutorSubjectDto.fromJson(Map<String, dynamic> json) => _$TutorSubjectDtoFromJson(json);

@override final  String id;
@override final  String subjectId;
@override final  String subjectName;
@override final  int priceIdr;

/// Create a copy of TutorSubjectDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorSubjectDtoCopyWith<_TutorSubjectDto> get copyWith => __$TutorSubjectDtoCopyWithImpl<_TutorSubjectDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TutorSubjectDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TutorSubjectDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.priceIdr, priceIdr) || other.priceIdr == priceIdr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,subjectId,subjectName,priceIdr);
}

@override
String toString() {
    return 'TutorSubjectDto(id: $id, subjectId: $subjectId, subjectName: $subjectName, priceIdr: $priceIdr)';
}


}

/// @nodoc
abstract mixin class _$TutorSubjectDtoCopyWith<$Res> implements $TutorSubjectDtoCopyWith<$Res> {
  factory _$TutorSubjectDtoCopyWith(_TutorSubjectDto value, $Res Function(_TutorSubjectDto) _then) = __$TutorSubjectDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String subjectId, String subjectName, int priceIdr
});




}
/// @nodoc
class __$TutorSubjectDtoCopyWithImpl<$Res>
    implements _$TutorSubjectDtoCopyWith<$Res> {
  __$TutorSubjectDtoCopyWithImpl(this._self, this._then);

  final _TutorSubjectDto _self;
  final $Res Function(_TutorSubjectDto) _then;

/// Create a copy of TutorSubjectDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subjectId = null,Object? subjectName = null,Object? priceIdr = null,}) {
  return _then(_TutorSubjectDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,priceIdr: null == priceIdr ? _self.priceIdr : priceIdr // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TutorCard {

 String get id; String get userId; String get name; String? get avatarUrl; double get ratingAvg; int get ratingCount; List<TutorSubjectDto> get subjects; String? get nextSlot;
/// Create a copy of TutorCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorCardCopyWith<TutorCard> get copyWith => _$TutorCardCopyWithImpl<TutorCard>(this as TutorCard, _$identity);

  /// Serializes this TutorCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TutorCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.ratingAvg, _this.ratingAvg) || other.ratingAvg == _this.ratingAvg)&&(identical(other.ratingCount, _this.ratingCount) || other.ratingCount == _this.ratingCount)&&const DeepCollectionEquality().equals(other.subjects, _this.subjects)&&(identical(other.nextSlot, _this.nextSlot) || other.nextSlot == _this.nextSlot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TutorCard;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.name,_this.avatarUrl,_this.ratingAvg,_this.ratingCount,const DeepCollectionEquality().hash(_this.subjects),_this.nextSlot);
}

@override
String toString() {
  final _this = this as TutorCard;
  return 'TutorCard(id: ${_this.id}, userId: ${_this.userId}, name: ${_this.name}, avatarUrl: ${_this.avatarUrl}, ratingAvg: ${_this.ratingAvg}, ratingCount: ${_this.ratingCount}, subjects: ${_this.subjects}, nextSlot: ${_this.nextSlot})';
}


}

/// @nodoc
abstract mixin class $TutorCardCopyWith<$Res>  {
  factory $TutorCardCopyWith(TutorCard value, $Res Function(TutorCard) _then) = _$TutorCardCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, String? avatarUrl, double ratingAvg, int ratingCount, List<TutorSubjectDto> subjects, String? nextSlot
});




}
/// @nodoc
class _$TutorCardCopyWithImpl<$Res>
    implements $TutorCardCopyWith<$Res> {
  _$TutorCardCopyWithImpl(this._self, this._then);

  final TutorCard _self;
  final $Res Function(TutorCard) _then;

/// Create a copy of TutorCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? ratingAvg = null,Object? ratingCount = null,Object? subjects = null,Object? nextSlot = freezed,}) {
  return _then(TutorCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ratingAvg: null == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<TutorSubjectDto>,nextSlot: freezed == nextSlot ? _self.nextSlot : nextSlot // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TutorCard].
extension TutorCardPatterns on TutorCard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TutorCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TutorCard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TutorCard value)  $default,){
final _that = this;
switch (_that) {
case _TutorCard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TutorCard value)?  $default,){
final _that = this;
switch (_that) {
case _TutorCard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? avatarUrl,  double ratingAvg,  int ratingCount,  List<TutorSubjectDto> subjects,  String? nextSlot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TutorCard() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.avatarUrl,_that.ratingAvg,_that.ratingCount,_that.subjects,_that.nextSlot);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? avatarUrl,  double ratingAvg,  int ratingCount,  List<TutorSubjectDto> subjects,  String? nextSlot)  $default,) {final _that = this;
switch (_that) {
case _TutorCard():
return $default(_that.id,_that.userId,_that.name,_that.avatarUrl,_that.ratingAvg,_that.ratingCount,_that.subjects,_that.nextSlot);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  String? avatarUrl,  double ratingAvg,  int ratingCount,  List<TutorSubjectDto> subjects,  String? nextSlot)?  $default,) {final _that = this;
switch (_that) {
case _TutorCard() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.avatarUrl,_that.ratingAvg,_that.ratingCount,_that.subjects,_that.nextSlot);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TutorCard implements TutorCard {
  const _TutorCard({required this.id, required this.userId, required this.name, this.avatarUrl, required this.ratingAvg, required this.ratingCount, required  List<TutorSubjectDto> subjects, this.nextSlot}): _subjects = subjects;
  factory _TutorCard.fromJson(Map<String, dynamic> json) => _$TutorCardFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  String? avatarUrl;
@override final  double ratingAvg;
@override final  int ratingCount;
 final  List<TutorSubjectDto> _subjects;
@override List<TutorSubjectDto> get subjects {
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subjects);
}

@override final  String? nextSlot;

/// Create a copy of TutorCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorCardCopyWith<_TutorCard> get copyWith => __$TutorCardCopyWithImpl<_TutorCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TutorCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TutorCard&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.ratingAvg, ratingAvg) || other.ratingAvg == ratingAvg)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.subjects, _subjects)&&(identical(other.nextSlot, nextSlot) || other.nextSlot == nextSlot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,name,avatarUrl,ratingAvg,ratingCount,const DeepCollectionEquality().hash(_subjects),nextSlot);
}

@override
String toString() {
    return 'TutorCard(id: $id, userId: $userId, name: $name, avatarUrl: $avatarUrl, ratingAvg: $ratingAvg, ratingCount: $ratingCount, subjects: $subjects, nextSlot: $nextSlot)';
}


}

/// @nodoc
abstract mixin class _$TutorCardCopyWith<$Res> implements $TutorCardCopyWith<$Res> {
  factory _$TutorCardCopyWith(_TutorCard value, $Res Function(_TutorCard) _then) = __$TutorCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, String? avatarUrl, double ratingAvg, int ratingCount, List<TutorSubjectDto> subjects, String? nextSlot
});




}
/// @nodoc
class __$TutorCardCopyWithImpl<$Res>
    implements _$TutorCardCopyWith<$Res> {
  __$TutorCardCopyWithImpl(this._self, this._then);

  final _TutorCard _self;
  final $Res Function(_TutorCard) _then;

/// Create a copy of TutorCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? ratingAvg = null,Object? ratingCount = null,Object? subjects = null,Object? nextSlot = freezed,}) {
  return _then(_TutorCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,ratingAvg: null == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<TutorSubjectDto>,nextSlot: freezed == nextSlot ? _self.nextSlot : nextSlot // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TutorDetail {

 String get id; String get userId; String get name; String? get avatarUrl; String? get bio; bool get isVerified; double get ratingAvg; int get ratingCount; List<TutorSubjectDto> get subjects;
/// Create a copy of TutorDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TutorDetailCopyWith<TutorDetail> get copyWith => _$TutorDetailCopyWithImpl<TutorDetail>(this as TutorDetail, _$identity);

  /// Serializes this TutorDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TutorDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TutorDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl)&&(identical(other.bio, _this.bio) || other.bio == _this.bio)&&(identical(other.isVerified, _this.isVerified) || other.isVerified == _this.isVerified)&&(identical(other.ratingAvg, _this.ratingAvg) || other.ratingAvg == _this.ratingAvg)&&(identical(other.ratingCount, _this.ratingCount) || other.ratingCount == _this.ratingCount)&&const DeepCollectionEquality().equals(other.subjects, _this.subjects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TutorDetail;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.name,_this.avatarUrl,_this.bio,_this.isVerified,_this.ratingAvg,_this.ratingCount,const DeepCollectionEquality().hash(_this.subjects));
}

@override
String toString() {
  final _this = this as TutorDetail;
  return 'TutorDetail(id: ${_this.id}, userId: ${_this.userId}, name: ${_this.name}, avatarUrl: ${_this.avatarUrl}, bio: ${_this.bio}, isVerified: ${_this.isVerified}, ratingAvg: ${_this.ratingAvg}, ratingCount: ${_this.ratingCount}, subjects: ${_this.subjects})';
}


}

/// @nodoc
abstract mixin class $TutorDetailCopyWith<$Res>  {
  factory $TutorDetailCopyWith(TutorDetail value, $Res Function(TutorDetail) _then) = _$TutorDetailCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, String? avatarUrl, String? bio, bool isVerified, double ratingAvg, int ratingCount, List<TutorSubjectDto> subjects
});




}
/// @nodoc
class _$TutorDetailCopyWithImpl<$Res>
    implements $TutorDetailCopyWith<$Res> {
  _$TutorDetailCopyWithImpl(this._self, this._then);

  final TutorDetail _self;
  final $Res Function(TutorDetail) _then;

/// Create a copy of TutorDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? isVerified = null,Object? ratingAvg = null,Object? ratingCount = null,Object? subjects = null,}) {
  return _then(TutorDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,ratingAvg: null == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<TutorSubjectDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [TutorDetail].
extension TutorDetailPatterns on TutorDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TutorDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TutorDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TutorDetail value)  $default,){
final _that = this;
switch (_that) {
case _TutorDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TutorDetail value)?  $default,){
final _that = this;
switch (_that) {
case _TutorDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? avatarUrl,  String? bio,  bool isVerified,  double ratingAvg,  int ratingCount,  List<TutorSubjectDto> subjects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TutorDetail() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.avatarUrl,_that.bio,_that.isVerified,_that.ratingAvg,_that.ratingCount,_that.subjects);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String? avatarUrl,  String? bio,  bool isVerified,  double ratingAvg,  int ratingCount,  List<TutorSubjectDto> subjects)  $default,) {final _that = this;
switch (_that) {
case _TutorDetail():
return $default(_that.id,_that.userId,_that.name,_that.avatarUrl,_that.bio,_that.isVerified,_that.ratingAvg,_that.ratingCount,_that.subjects);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  String? avatarUrl,  String? bio,  bool isVerified,  double ratingAvg,  int ratingCount,  List<TutorSubjectDto> subjects)?  $default,) {final _that = this;
switch (_that) {
case _TutorDetail() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.avatarUrl,_that.bio,_that.isVerified,_that.ratingAvg,_that.ratingCount,_that.subjects);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TutorDetail implements TutorDetail {
  const _TutorDetail({required this.id, required this.userId, required this.name, this.avatarUrl, this.bio, required this.isVerified, required this.ratingAvg, required this.ratingCount, required  List<TutorSubjectDto> subjects}): _subjects = subjects;
  factory _TutorDetail.fromJson(Map<String, dynamic> json) => _$TutorDetailFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String name;
@override final  String? avatarUrl;
@override final  String? bio;
@override final  bool isVerified;
@override final  double ratingAvg;
@override final  int ratingCount;
 final  List<TutorSubjectDto> _subjects;
@override List<TutorSubjectDto> get subjects {
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subjects);
}


/// Create a copy of TutorDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TutorDetailCopyWith<_TutorDetail> get copyWith => __$TutorDetailCopyWithImpl<_TutorDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TutorDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TutorDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.ratingAvg, ratingAvg) || other.ratingAvg == ratingAvg)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.subjects, _subjects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,name,avatarUrl,bio,isVerified,ratingAvg,ratingCount,const DeepCollectionEquality().hash(_subjects));
}

@override
String toString() {
    return 'TutorDetail(id: $id, userId: $userId, name: $name, avatarUrl: $avatarUrl, bio: $bio, isVerified: $isVerified, ratingAvg: $ratingAvg, ratingCount: $ratingCount, subjects: $subjects)';
}


}

/// @nodoc
abstract mixin class _$TutorDetailCopyWith<$Res> implements $TutorDetailCopyWith<$Res> {
  factory _$TutorDetailCopyWith(_TutorDetail value, $Res Function(_TutorDetail) _then) = __$TutorDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, String? avatarUrl, String? bio, bool isVerified, double ratingAvg, int ratingCount, List<TutorSubjectDto> subjects
});




}
/// @nodoc
class __$TutorDetailCopyWithImpl<$Res>
    implements _$TutorDetailCopyWith<$Res> {
  __$TutorDetailCopyWithImpl(this._self, this._then);

  final _TutorDetail _self;
  final $Res Function(_TutorDetail) _then;

/// Create a copy of TutorDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? avatarUrl = freezed,Object? bio = freezed,Object? isVerified = null,Object? ratingAvg = null,Object? ratingCount = null,Object? subjects = null,}) {
  return _then(_TutorDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,ratingAvg: null == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<TutorSubjectDto>,
  ));
}


}


/// @nodoc
mixin _$SlotDto {

 String get id; String get startsAt; String get endsAt; String get status;
/// Create a copy of SlotDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotDtoCopyWith<SlotDto> get copyWith => _$SlotDtoCopyWithImpl<SlotDto>(this as SlotDto, _$identity);

  /// Serializes this SlotDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SlotDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.startsAt, _this.startsAt) || other.startsAt == _this.startsAt)&&(identical(other.endsAt, _this.endsAt) || other.endsAt == _this.endsAt)&&(identical(other.status, _this.status) || other.status == _this.status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SlotDto;
  return Object.hash(runtimeType,_this.id,_this.startsAt,_this.endsAt,_this.status);
}

@override
String toString() {
  final _this = this as SlotDto;
  return 'SlotDto(id: ${_this.id}, startsAt: ${_this.startsAt}, endsAt: ${_this.endsAt}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $SlotDtoCopyWith<$Res>  {
  factory $SlotDtoCopyWith(SlotDto value, $Res Function(SlotDto) _then) = _$SlotDtoCopyWithImpl;
@useResult
$Res call({
 String id, String startsAt, String endsAt, String status
});




}
/// @nodoc
class _$SlotDtoCopyWithImpl<$Res>
    implements $SlotDtoCopyWith<$Res> {
  _$SlotDtoCopyWithImpl(this._self, this._then);

  final SlotDto _self;
  final $Res Function(SlotDto) _then;

/// Create a copy of SlotDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,}) {
  return _then(SlotDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotDto].
extension SlotDtoPatterns on SlotDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotDto value)  $default,){
final _that = this;
switch (_that) {
case _SlotDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotDto value)?  $default,){
final _that = this;
switch (_that) {
case _SlotDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String startsAt,  String endsAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotDto() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String startsAt,  String endsAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _SlotDto():
return $default(_that.id,_that.startsAt,_that.endsAt,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String startsAt,  String endsAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _SlotDto() when $default != null:
return $default(_that.id,_that.startsAt,_that.endsAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlotDto implements SlotDto {
  const _SlotDto({required this.id, required this.startsAt, required this.endsAt, required this.status});
  factory _SlotDto.fromJson(Map<String, dynamic> json) => _$SlotDtoFromJson(json);

@override final  String id;
@override final  String startsAt;
@override final  String endsAt;
@override final  String status;

/// Create a copy of SlotDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotDtoCopyWith<_SlotDto> get copyWith => __$SlotDtoCopyWithImpl<_SlotDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotDto&&(identical(other.id, id) || other.id == id)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,startsAt,endsAt,status);
}

@override
String toString() {
    return 'SlotDto(id: $id, startsAt: $startsAt, endsAt: $endsAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SlotDtoCopyWith<$Res> implements $SlotDtoCopyWith<$Res> {
  factory _$SlotDtoCopyWith(_SlotDto value, $Res Function(_SlotDto) _then) = __$SlotDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String startsAt, String endsAt, String status
});




}
/// @nodoc
class __$SlotDtoCopyWithImpl<$Res>
    implements _$SlotDtoCopyWith<$Res> {
  __$SlotDtoCopyWithImpl(this._self, this._then);

  final _SlotDto _self;
  final $Res Function(_SlotDto) _then;

/// Create a copy of SlotDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsAt = null,Object? endsAt = null,Object? status = null,}) {
  return _then(_SlotDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReviewDto {

 String get id; int get rating; String? get comment; String get studentName; String get createdAt;
/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<ReviewDto> get copyWith => _$ReviewDtoCopyWithImpl<ReviewDto>(this as ReviewDto, _$identity);

  /// Serializes this ReviewDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReviewDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.comment, _this.comment) || other.comment == _this.comment)&&(identical(other.studentName, _this.studentName) || other.studentName == _this.studentName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReviewDto;
  return Object.hash(runtimeType,_this.id,_this.rating,_this.comment,_this.studentName,_this.createdAt);
}

@override
String toString() {
  final _this = this as ReviewDto;
  return 'ReviewDto(id: ${_this.id}, rating: ${_this.rating}, comment: ${_this.comment}, studentName: ${_this.studentName}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ReviewDtoCopyWith<$Res>  {
  factory $ReviewDtoCopyWith(ReviewDto value, $Res Function(ReviewDto) _then) = _$ReviewDtoCopyWithImpl;
@useResult
$Res call({
 String id, int rating, String? comment, String studentName, String createdAt
});




}
/// @nodoc
class _$ReviewDtoCopyWithImpl<$Res>
    implements $ReviewDtoCopyWith<$Res> {
  _$ReviewDtoCopyWithImpl(this._self, this._then);

  final ReviewDto _self;
  final $Res Function(ReviewDto) _then;

/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rating = null,Object? comment = freezed,Object? studentName = null,Object? createdAt = null,}) {
  return _then(ReviewDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewDto].
extension ReviewDtoPatterns on ReviewDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewDto value)  $default,){
final _that = this;
switch (_that) {
case _ReviewDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int rating,  String? comment,  String studentName,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
return $default(_that.id,_that.rating,_that.comment,_that.studentName,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int rating,  String? comment,  String studentName,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReviewDto():
return $default(_that.id,_that.rating,_that.comment,_that.studentName,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int rating,  String? comment,  String studentName,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
return $default(_that.id,_that.rating,_that.comment,_that.studentName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewDto implements ReviewDto {
  const _ReviewDto({required this.id, required this.rating, this.comment, required this.studentName, required this.createdAt});
  factory _ReviewDto.fromJson(Map<String, dynamic> json) => _$ReviewDtoFromJson(json);

@override final  String id;
@override final  int rating;
@override final  String? comment;
@override final  String studentName;
@override final  String createdAt;

/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewDtoCopyWith<_ReviewDto> get copyWith => __$ReviewDtoCopyWithImpl<_ReviewDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewDto&&(identical(other.id, id) || other.id == id)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,rating,comment,studentName,createdAt);
}

@override
String toString() {
    return 'ReviewDto(id: $id, rating: $rating, comment: $comment, studentName: $studentName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReviewDtoCopyWith<$Res> implements $ReviewDtoCopyWith<$Res> {
  factory _$ReviewDtoCopyWith(_ReviewDto value, $Res Function(_ReviewDto) _then) = __$ReviewDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int rating, String? comment, String studentName, String createdAt
});




}
/// @nodoc
class __$ReviewDtoCopyWithImpl<$Res>
    implements _$ReviewDtoCopyWith<$Res> {
  __$ReviewDtoCopyWithImpl(this._self, this._then);

  final _ReviewDto _self;
  final $Res Function(_ReviewDto) _then;

/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rating = null,Object? comment = freezed,Object? studentName = null,Object? createdAt = null,}) {
  return _then(_ReviewDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PaginatedTutors {

 List<TutorCard> get items; String? get nextCursor;
/// Create a copy of PaginatedTutors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedTutorsCopyWith<PaginatedTutors> get copyWith => _$PaginatedTutorsCopyWithImpl<PaginatedTutors>(this as PaginatedTutors, _$identity);

  /// Serializes this PaginatedTutors to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaginatedTutors;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedTutors&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaginatedTutors;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.nextCursor);
}

@override
String toString() {
  final _this = this as PaginatedTutors;
  return 'PaginatedTutors(items: ${_this.items}, nextCursor: ${_this.nextCursor})';
}


}

/// @nodoc
abstract mixin class $PaginatedTutorsCopyWith<$Res>  {
  factory $PaginatedTutorsCopyWith(PaginatedTutors value, $Res Function(PaginatedTutors) _then) = _$PaginatedTutorsCopyWithImpl;
@useResult
$Res call({
 List<TutorCard> items, String? nextCursor
});




}
/// @nodoc
class _$PaginatedTutorsCopyWithImpl<$Res>
    implements $PaginatedTutorsCopyWith<$Res> {
  _$PaginatedTutorsCopyWithImpl(this._self, this._then);

  final PaginatedTutors _self;
  final $Res Function(PaginatedTutors) _then;

/// Create a copy of PaginatedTutors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(PaginatedTutors(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TutorCard>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedTutors].
extension PaginatedTutorsPatterns on PaginatedTutors {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedTutors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedTutors() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedTutors value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedTutors():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedTutors value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedTutors() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TutorCard> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedTutors() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TutorCard> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _PaginatedTutors():
return $default(_that.items,_that.nextCursor);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TutorCard> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedTutors() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedTutors implements PaginatedTutors {
  const _PaginatedTutors({required  List<TutorCard> items, this.nextCursor}): _items = items;
  factory _PaginatedTutors.fromJson(Map<String, dynamic> json) => _$PaginatedTutorsFromJson(json);

 final  List<TutorCard> _items;
@override List<TutorCard> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of PaginatedTutors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedTutorsCopyWith<_PaginatedTutors> get copyWith => __$PaginatedTutorsCopyWithImpl<_PaginatedTutors>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedTutorsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedTutors&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);
}

@override
String toString() {
    return 'PaginatedTutors(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$PaginatedTutorsCopyWith<$Res> implements $PaginatedTutorsCopyWith<$Res> {
  factory _$PaginatedTutorsCopyWith(_PaginatedTutors value, $Res Function(_PaginatedTutors) _then) = __$PaginatedTutorsCopyWithImpl;
@override @useResult
$Res call({
 List<TutorCard> items, String? nextCursor
});




}
/// @nodoc
class __$PaginatedTutorsCopyWithImpl<$Res>
    implements _$PaginatedTutorsCopyWith<$Res> {
  __$PaginatedTutorsCopyWithImpl(this._self, this._then);

  final _PaginatedTutors _self;
  final $Res Function(_PaginatedTutors) _then;

/// Create a copy of PaginatedTutors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_PaginatedTutors(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TutorCard>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaginatedReviews {

 List<ReviewDto> get items; String? get nextCursor;
/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedReviewsCopyWith<PaginatedReviews> get copyWith => _$PaginatedReviewsCopyWithImpl<PaginatedReviews>(this as PaginatedReviews, _$identity);

  /// Serializes this PaginatedReviews to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaginatedReviews;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedReviews&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaginatedReviews;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.nextCursor);
}

@override
String toString() {
  final _this = this as PaginatedReviews;
  return 'PaginatedReviews(items: ${_this.items}, nextCursor: ${_this.nextCursor})';
}


}

/// @nodoc
abstract mixin class $PaginatedReviewsCopyWith<$Res>  {
  factory $PaginatedReviewsCopyWith(PaginatedReviews value, $Res Function(PaginatedReviews) _then) = _$PaginatedReviewsCopyWithImpl;
@useResult
$Res call({
 List<ReviewDto> items, String? nextCursor
});




}
/// @nodoc
class _$PaginatedReviewsCopyWithImpl<$Res>
    implements $PaginatedReviewsCopyWith<$Res> {
  _$PaginatedReviewsCopyWithImpl(this._self, this._then);

  final PaginatedReviews _self;
  final $Res Function(PaginatedReviews) _then;

/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(PaginatedReviews(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReviewDto>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedReviews].
extension PaginatedReviewsPatterns on PaginatedReviews {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedReviews value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedReviews() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedReviews value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedReviews():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedReviews value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedReviews() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReviewDto> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedReviews() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReviewDto> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _PaginatedReviews():
return $default(_that.items,_that.nextCursor);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReviewDto> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedReviews() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedReviews implements PaginatedReviews {
  const _PaginatedReviews({required  List<ReviewDto> items, this.nextCursor}): _items = items;
  factory _PaginatedReviews.fromJson(Map<String, dynamic> json) => _$PaginatedReviewsFromJson(json);

 final  List<ReviewDto> _items;
@override List<ReviewDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedReviewsCopyWith<_PaginatedReviews> get copyWith => __$PaginatedReviewsCopyWithImpl<_PaginatedReviews>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedReviewsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedReviews&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);
}

@override
String toString() {
    return 'PaginatedReviews(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$PaginatedReviewsCopyWith<$Res> implements $PaginatedReviewsCopyWith<$Res> {
  factory _$PaginatedReviewsCopyWith(_PaginatedReviews value, $Res Function(_PaginatedReviews) _then) = __$PaginatedReviewsCopyWithImpl;
@override @useResult
$Res call({
 List<ReviewDto> items, String? nextCursor
});




}
/// @nodoc
class __$PaginatedReviewsCopyWithImpl<$Res>
    implements _$PaginatedReviewsCopyWith<$Res> {
  __$PaginatedReviewsCopyWithImpl(this._self, this._then);

  final _PaginatedReviews _self;
  final $Res Function(_PaginatedReviews) _then;

/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_PaginatedReviews(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReviewDto>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
