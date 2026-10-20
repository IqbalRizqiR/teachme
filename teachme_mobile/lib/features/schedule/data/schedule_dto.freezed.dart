// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AvailabilityRuleDto {

 String get id; int get weekday; int get startMinute; int get endMinute;
/// Create a copy of AvailabilityRuleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityRuleDtoCopyWith<AvailabilityRuleDto> get copyWith => _$AvailabilityRuleDtoCopyWithImpl<AvailabilityRuleDto>(this as AvailabilityRuleDto, _$identity);

  /// Serializes this AvailabilityRuleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AvailabilityRuleDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityRuleDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday)&&(identical(other.startMinute, _this.startMinute) || other.startMinute == _this.startMinute)&&(identical(other.endMinute, _this.endMinute) || other.endMinute == _this.endMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AvailabilityRuleDto;
  return Object.hash(runtimeType,_this.id,_this.weekday,_this.startMinute,_this.endMinute);
}

@override
String toString() {
  final _this = this as AvailabilityRuleDto;
  return 'AvailabilityRuleDto(id: ${_this.id}, weekday: ${_this.weekday}, startMinute: ${_this.startMinute}, endMinute: ${_this.endMinute})';
}


}

/// @nodoc
abstract mixin class $AvailabilityRuleDtoCopyWith<$Res>  {
  factory $AvailabilityRuleDtoCopyWith(AvailabilityRuleDto value, $Res Function(AvailabilityRuleDto) _then) = _$AvailabilityRuleDtoCopyWithImpl;
@useResult
$Res call({
 String id, int weekday, int startMinute, int endMinute
});




}
/// @nodoc
class _$AvailabilityRuleDtoCopyWithImpl<$Res>
    implements $AvailabilityRuleDtoCopyWith<$Res> {
  _$AvailabilityRuleDtoCopyWithImpl(this._self, this._then);

  final AvailabilityRuleDto _self;
  final $Res Function(AvailabilityRuleDto) _then;

/// Create a copy of AvailabilityRuleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weekday = null,Object? startMinute = null,Object? endMinute = null,}) {
  return _then(AvailabilityRuleDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityRuleDto].
extension AvailabilityRuleDtoPatterns on AvailabilityRuleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityRuleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityRuleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityRuleDto value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityRuleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityRuleDto value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityRuleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int weekday,  int startMinute,  int endMinute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityRuleDto() when $default != null:
return $default(_that.id,_that.weekday,_that.startMinute,_that.endMinute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int weekday,  int startMinute,  int endMinute)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityRuleDto():
return $default(_that.id,_that.weekday,_that.startMinute,_that.endMinute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int weekday,  int startMinute,  int endMinute)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityRuleDto() when $default != null:
return $default(_that.id,_that.weekday,_that.startMinute,_that.endMinute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityRuleDto implements AvailabilityRuleDto {
  const _AvailabilityRuleDto({required this.id, required this.weekday, required this.startMinute, required this.endMinute});
  factory _AvailabilityRuleDto.fromJson(Map<String, dynamic> json) => _$AvailabilityRuleDtoFromJson(json);

@override final  String id;
@override final  int weekday;
@override final  int startMinute;
@override final  int endMinute;

/// Create a copy of AvailabilityRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityRuleDtoCopyWith<_AvailabilityRuleDto> get copyWith => __$AvailabilityRuleDtoCopyWithImpl<_AvailabilityRuleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityRuleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityRuleDto&&(identical(other.id, id) || other.id == id)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,weekday,startMinute,endMinute);
}

@override
String toString() {
    return 'AvailabilityRuleDto(id: $id, weekday: $weekday, startMinute: $startMinute, endMinute: $endMinute)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityRuleDtoCopyWith<$Res> implements $AvailabilityRuleDtoCopyWith<$Res> {
  factory _$AvailabilityRuleDtoCopyWith(_AvailabilityRuleDto value, $Res Function(_AvailabilityRuleDto) _then) = __$AvailabilityRuleDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int weekday, int startMinute, int endMinute
});




}
/// @nodoc
class __$AvailabilityRuleDtoCopyWithImpl<$Res>
    implements _$AvailabilityRuleDtoCopyWith<$Res> {
  __$AvailabilityRuleDtoCopyWithImpl(this._self, this._then);

  final _AvailabilityRuleDto _self;
  final $Res Function(_AvailabilityRuleDto) _then;

/// Create a copy of AvailabilityRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weekday = null,Object? startMinute = null,Object? endMinute = null,}) {
  return _then(_AvailabilityRuleDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AvailabilityExceptionDto {

 String get id; String get date; String? get reason;
/// Create a copy of AvailabilityExceptionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailabilityExceptionDtoCopyWith<AvailabilityExceptionDto> get copyWith => _$AvailabilityExceptionDtoCopyWithImpl<AvailabilityExceptionDto>(this as AvailabilityExceptionDto, _$identity);

  /// Serializes this AvailabilityExceptionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AvailabilityExceptionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailabilityExceptionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AvailabilityExceptionDto;
  return Object.hash(runtimeType,_this.id,_this.date,_this.reason);
}

@override
String toString() {
  final _this = this as AvailabilityExceptionDto;
  return 'AvailabilityExceptionDto(id: ${_this.id}, date: ${_this.date}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $AvailabilityExceptionDtoCopyWith<$Res>  {
  factory $AvailabilityExceptionDtoCopyWith(AvailabilityExceptionDto value, $Res Function(AvailabilityExceptionDto) _then) = _$AvailabilityExceptionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String date, String? reason
});




}
/// @nodoc
class _$AvailabilityExceptionDtoCopyWithImpl<$Res>
    implements $AvailabilityExceptionDtoCopyWith<$Res> {
  _$AvailabilityExceptionDtoCopyWithImpl(this._self, this._then);

  final AvailabilityExceptionDto _self;
  final $Res Function(AvailabilityExceptionDto) _then;

/// Create a copy of AvailabilityExceptionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? reason = freezed,}) {
  return _then(AvailabilityExceptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailabilityExceptionDto].
extension AvailabilityExceptionDtoPatterns on AvailabilityExceptionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailabilityExceptionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailabilityExceptionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailabilityExceptionDto value)  $default,){
final _that = this;
switch (_that) {
case _AvailabilityExceptionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailabilityExceptionDto value)?  $default,){
final _that = this;
switch (_that) {
case _AvailabilityExceptionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String date,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailabilityExceptionDto() when $default != null:
return $default(_that.id,_that.date,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String date,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _AvailabilityExceptionDto():
return $default(_that.id,_that.date,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String date,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _AvailabilityExceptionDto() when $default != null:
return $default(_that.id,_that.date,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AvailabilityExceptionDto implements AvailabilityExceptionDto {
  const _AvailabilityExceptionDto({required this.id, required this.date, this.reason});
  factory _AvailabilityExceptionDto.fromJson(Map<String, dynamic> json) => _$AvailabilityExceptionDtoFromJson(json);

@override final  String id;
@override final  String date;
@override final  String? reason;

/// Create a copy of AvailabilityExceptionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailabilityExceptionDtoCopyWith<_AvailabilityExceptionDto> get copyWith => __$AvailabilityExceptionDtoCopyWithImpl<_AvailabilityExceptionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AvailabilityExceptionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailabilityExceptionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,date,reason);
}

@override
String toString() {
    return 'AvailabilityExceptionDto(id: $id, date: $date, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$AvailabilityExceptionDtoCopyWith<$Res> implements $AvailabilityExceptionDtoCopyWith<$Res> {
  factory _$AvailabilityExceptionDtoCopyWith(_AvailabilityExceptionDto value, $Res Function(_AvailabilityExceptionDto) _then) = __$AvailabilityExceptionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String date, String? reason
});




}
/// @nodoc
class __$AvailabilityExceptionDtoCopyWithImpl<$Res>
    implements _$AvailabilityExceptionDtoCopyWith<$Res> {
  __$AvailabilityExceptionDtoCopyWithImpl(this._self, this._then);

  final _AvailabilityExceptionDto _self;
  final $Res Function(_AvailabilityExceptionDto) _then;

/// Create a copy of AvailabilityExceptionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? reason = freezed,}) {
  return _then(_AvailabilityExceptionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreateRuleRequest {

 int get weekday; int get startMinute; int get endMinute;
/// Create a copy of CreateRuleRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateRuleRequestCopyWith<CreateRuleRequest> get copyWith => _$CreateRuleRequestCopyWithImpl<CreateRuleRequest>(this as CreateRuleRequest, _$identity);

  /// Serializes this CreateRuleRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateRuleRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateRuleRequest&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday)&&(identical(other.startMinute, _this.startMinute) || other.startMinute == _this.startMinute)&&(identical(other.endMinute, _this.endMinute) || other.endMinute == _this.endMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateRuleRequest;
  return Object.hash(runtimeType,_this.weekday,_this.startMinute,_this.endMinute);
}

@override
String toString() {
  final _this = this as CreateRuleRequest;
  return 'CreateRuleRequest(weekday: ${_this.weekday}, startMinute: ${_this.startMinute}, endMinute: ${_this.endMinute})';
}


}

/// @nodoc
abstract mixin class $CreateRuleRequestCopyWith<$Res>  {
  factory $CreateRuleRequestCopyWith(CreateRuleRequest value, $Res Function(CreateRuleRequest) _then) = _$CreateRuleRequestCopyWithImpl;
@useResult
$Res call({
 int weekday, int startMinute, int endMinute
});




}
/// @nodoc
class _$CreateRuleRequestCopyWithImpl<$Res>
    implements $CreateRuleRequestCopyWith<$Res> {
  _$CreateRuleRequestCopyWithImpl(this._self, this._then);

  final CreateRuleRequest _self;
  final $Res Function(CreateRuleRequest) _then;

/// Create a copy of CreateRuleRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? startMinute = null,Object? endMinute = null,}) {
  return _then(CreateRuleRequest(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateRuleRequest].
extension CreateRuleRequestPatterns on CreateRuleRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateRuleRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateRuleRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateRuleRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateRuleRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateRuleRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateRuleRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekday,  int startMinute,  int endMinute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateRuleRequest() when $default != null:
return $default(_that.weekday,_that.startMinute,_that.endMinute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekday,  int startMinute,  int endMinute)  $default,) {final _that = this;
switch (_that) {
case _CreateRuleRequest():
return $default(_that.weekday,_that.startMinute,_that.endMinute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekday,  int startMinute,  int endMinute)?  $default,) {final _that = this;
switch (_that) {
case _CreateRuleRequest() when $default != null:
return $default(_that.weekday,_that.startMinute,_that.endMinute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateRuleRequest implements CreateRuleRequest {
  const _CreateRuleRequest({required this.weekday, required this.startMinute, required this.endMinute});
  factory _CreateRuleRequest.fromJson(Map<String, dynamic> json) => _$CreateRuleRequestFromJson(json);

@override final  int weekday;
@override final  int startMinute;
@override final  int endMinute;

/// Create a copy of CreateRuleRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateRuleRequestCopyWith<_CreateRuleRequest> get copyWith => __$CreateRuleRequestCopyWithImpl<_CreateRuleRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateRuleRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateRuleRequest&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startMinute, startMinute) || other.startMinute == startMinute)&&(identical(other.endMinute, endMinute) || other.endMinute == endMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,weekday,startMinute,endMinute);
}

@override
String toString() {
    return 'CreateRuleRequest(weekday: $weekday, startMinute: $startMinute, endMinute: $endMinute)';
}


}

/// @nodoc
abstract mixin class _$CreateRuleRequestCopyWith<$Res> implements $CreateRuleRequestCopyWith<$Res> {
  factory _$CreateRuleRequestCopyWith(_CreateRuleRequest value, $Res Function(_CreateRuleRequest) _then) = __$CreateRuleRequestCopyWithImpl;
@override @useResult
$Res call({
 int weekday, int startMinute, int endMinute
});




}
/// @nodoc
class __$CreateRuleRequestCopyWithImpl<$Res>
    implements _$CreateRuleRequestCopyWith<$Res> {
  __$CreateRuleRequestCopyWithImpl(this._self, this._then);

  final _CreateRuleRequest _self;
  final $Res Function(_CreateRuleRequest) _then;

/// Create a copy of CreateRuleRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? startMinute = null,Object? endMinute = null,}) {
  return _then(_CreateRuleRequest(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startMinute: null == startMinute ? _self.startMinute : startMinute // ignore: cast_nullable_to_non_nullable
as int,endMinute: null == endMinute ? _self.endMinute : endMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CreateExceptionRequest {

 String get date; String? get reason;
/// Create a copy of CreateExceptionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateExceptionRequestCopyWith<CreateExceptionRequest> get copyWith => _$CreateExceptionRequestCopyWithImpl<CreateExceptionRequest>(this as CreateExceptionRequest, _$identity);

  /// Serializes this CreateExceptionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateExceptionRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateExceptionRequest&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateExceptionRequest;
  return Object.hash(runtimeType,_this.date,_this.reason);
}

@override
String toString() {
  final _this = this as CreateExceptionRequest;
  return 'CreateExceptionRequest(date: ${_this.date}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $CreateExceptionRequestCopyWith<$Res>  {
  factory $CreateExceptionRequestCopyWith(CreateExceptionRequest value, $Res Function(CreateExceptionRequest) _then) = _$CreateExceptionRequestCopyWithImpl;
@useResult
$Res call({
 String date, String? reason
});




}
/// @nodoc
class _$CreateExceptionRequestCopyWithImpl<$Res>
    implements $CreateExceptionRequestCopyWith<$Res> {
  _$CreateExceptionRequestCopyWithImpl(this._self, this._then);

  final CreateExceptionRequest _self;
  final $Res Function(CreateExceptionRequest) _then;

/// Create a copy of CreateExceptionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? reason = freezed,}) {
  return _then(CreateExceptionRequest(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateExceptionRequest].
extension CreateExceptionRequestPatterns on CreateExceptionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateExceptionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateExceptionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateExceptionRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateExceptionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateExceptionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateExceptionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateExceptionRequest() when $default != null:
return $default(_that.date,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _CreateExceptionRequest():
return $default(_that.date,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _CreateExceptionRequest() when $default != null:
return $default(_that.date,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateExceptionRequest implements CreateExceptionRequest {
  const _CreateExceptionRequest({required this.date, this.reason});
  factory _CreateExceptionRequest.fromJson(Map<String, dynamic> json) => _$CreateExceptionRequestFromJson(json);

@override final  String date;
@override final  String? reason;

/// Create a copy of CreateExceptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateExceptionRequestCopyWith<_CreateExceptionRequest> get copyWith => __$CreateExceptionRequestCopyWithImpl<_CreateExceptionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateExceptionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateExceptionRequest&&(identical(other.date, date) || other.date == date)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,reason);
}

@override
String toString() {
    return 'CreateExceptionRequest(date: $date, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$CreateExceptionRequestCopyWith<$Res> implements $CreateExceptionRequestCopyWith<$Res> {
  factory _$CreateExceptionRequestCopyWith(_CreateExceptionRequest value, $Res Function(_CreateExceptionRequest) _then) = __$CreateExceptionRequestCopyWithImpl;
@override @useResult
$Res call({
 String date, String? reason
});




}
/// @nodoc
class __$CreateExceptionRequestCopyWithImpl<$Res>
    implements _$CreateExceptionRequestCopyWith<$Res> {
  __$CreateExceptionRequestCopyWithImpl(this._self, this._then);

  final _CreateExceptionRequest _self;
  final $Res Function(_CreateExceptionRequest) _then;

/// Create a copy of CreateExceptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? reason = freezed,}) {
  return _then(_CreateExceptionRequest(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
