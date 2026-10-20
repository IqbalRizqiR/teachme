// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DashboardDto {

 int get thisWeekSessions; int get pendingRequests; int get earningsThisMonth; double get ratingAvg; int get ratingCount; List<BookingDto> get incomingBookings; List<BookingDto> get upcomingSessions; List<BookingDto> get needsGrading;
/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDtoCopyWith<DashboardDto> get copyWith => _$DashboardDtoCopyWithImpl<DashboardDto>(this as DashboardDto, _$identity);

  /// Serializes this DashboardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DashboardDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardDto&&(identical(other.thisWeekSessions, _this.thisWeekSessions) || other.thisWeekSessions == _this.thisWeekSessions)&&(identical(other.pendingRequests, _this.pendingRequests) || other.pendingRequests == _this.pendingRequests)&&(identical(other.earningsThisMonth, _this.earningsThisMonth) || other.earningsThisMonth == _this.earningsThisMonth)&&(identical(other.ratingAvg, _this.ratingAvg) || other.ratingAvg == _this.ratingAvg)&&(identical(other.ratingCount, _this.ratingCount) || other.ratingCount == _this.ratingCount)&&const DeepCollectionEquality().equals(other.incomingBookings, _this.incomingBookings)&&const DeepCollectionEquality().equals(other.upcomingSessions, _this.upcomingSessions)&&const DeepCollectionEquality().equals(other.needsGrading, _this.needsGrading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DashboardDto;
  return Object.hash(runtimeType,_this.thisWeekSessions,_this.pendingRequests,_this.earningsThisMonth,_this.ratingAvg,_this.ratingCount,const DeepCollectionEquality().hash(_this.incomingBookings),const DeepCollectionEquality().hash(_this.upcomingSessions),const DeepCollectionEquality().hash(_this.needsGrading));
}

@override
String toString() {
  final _this = this as DashboardDto;
  return 'DashboardDto(thisWeekSessions: ${_this.thisWeekSessions}, pendingRequests: ${_this.pendingRequests}, earningsThisMonth: ${_this.earningsThisMonth}, ratingAvg: ${_this.ratingAvg}, ratingCount: ${_this.ratingCount}, incomingBookings: ${_this.incomingBookings}, upcomingSessions: ${_this.upcomingSessions}, needsGrading: ${_this.needsGrading})';
}


}

/// @nodoc
abstract mixin class $DashboardDtoCopyWith<$Res>  {
  factory $DashboardDtoCopyWith(DashboardDto value, $Res Function(DashboardDto) _then) = _$DashboardDtoCopyWithImpl;
@useResult
$Res call({
 int thisWeekSessions, int pendingRequests, int earningsThisMonth, double ratingAvg, int ratingCount, List<BookingDto> incomingBookings, List<BookingDto> upcomingSessions, List<BookingDto> needsGrading
});




}
/// @nodoc
class _$DashboardDtoCopyWithImpl<$Res>
    implements $DashboardDtoCopyWith<$Res> {
  _$DashboardDtoCopyWithImpl(this._self, this._then);

  final DashboardDto _self;
  final $Res Function(DashboardDto) _then;

/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? thisWeekSessions = null,Object? pendingRequests = null,Object? earningsThisMonth = null,Object? ratingAvg = null,Object? ratingCount = null,Object? incomingBookings = null,Object? upcomingSessions = null,Object? needsGrading = null,}) {
  return _then(DashboardDto(
thisWeekSessions: null == thisWeekSessions ? _self.thisWeekSessions : thisWeekSessions // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,earningsThisMonth: null == earningsThisMonth ? _self.earningsThisMonth : earningsThisMonth // ignore: cast_nullable_to_non_nullable
as int,ratingAvg: null == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,incomingBookings: null == incomingBookings ? _self.incomingBookings : incomingBookings // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,upcomingSessions: null == upcomingSessions ? _self.upcomingSessions : upcomingSessions // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,needsGrading: null == needsGrading ? _self.needsGrading : needsGrading // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardDto].
extension DashboardDtoPatterns on DashboardDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardDto value)  $default,){
final _that = this;
switch (_that) {
case _DashboardDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardDto value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int thisWeekSessions,  int pendingRequests,  int earningsThisMonth,  double ratingAvg,  int ratingCount,  List<BookingDto> incomingBookings,  List<BookingDto> upcomingSessions,  List<BookingDto> needsGrading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
return $default(_that.thisWeekSessions,_that.pendingRequests,_that.earningsThisMonth,_that.ratingAvg,_that.ratingCount,_that.incomingBookings,_that.upcomingSessions,_that.needsGrading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int thisWeekSessions,  int pendingRequests,  int earningsThisMonth,  double ratingAvg,  int ratingCount,  List<BookingDto> incomingBookings,  List<BookingDto> upcomingSessions,  List<BookingDto> needsGrading)  $default,) {final _that = this;
switch (_that) {
case _DashboardDto():
return $default(_that.thisWeekSessions,_that.pendingRequests,_that.earningsThisMonth,_that.ratingAvg,_that.ratingCount,_that.incomingBookings,_that.upcomingSessions,_that.needsGrading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int thisWeekSessions,  int pendingRequests,  int earningsThisMonth,  double ratingAvg,  int ratingCount,  List<BookingDto> incomingBookings,  List<BookingDto> upcomingSessions,  List<BookingDto> needsGrading)?  $default,) {final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
return $default(_that.thisWeekSessions,_that.pendingRequests,_that.earningsThisMonth,_that.ratingAvg,_that.ratingCount,_that.incomingBookings,_that.upcomingSessions,_that.needsGrading);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardDto implements DashboardDto {
  const _DashboardDto({required this.thisWeekSessions, required this.pendingRequests, required this.earningsThisMonth, required this.ratingAvg, required this.ratingCount, required  List<BookingDto> incomingBookings, required  List<BookingDto> upcomingSessions, required  List<BookingDto> needsGrading}): _incomingBookings = incomingBookings,_upcomingSessions = upcomingSessions,_needsGrading = needsGrading;
  factory _DashboardDto.fromJson(Map<String, dynamic> json) => _$DashboardDtoFromJson(json);

@override final  int thisWeekSessions;
@override final  int pendingRequests;
@override final  int earningsThisMonth;
@override final  double ratingAvg;
@override final  int ratingCount;
 final  List<BookingDto> _incomingBookings;
@override List<BookingDto> get incomingBookings {
  if (_incomingBookings is EqualUnmodifiableListView) return _incomingBookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incomingBookings);
}

 final  List<BookingDto> _upcomingSessions;
@override List<BookingDto> get upcomingSessions {
  if (_upcomingSessions is EqualUnmodifiableListView) return _upcomingSessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingSessions);
}

 final  List<BookingDto> _needsGrading;
@override List<BookingDto> get needsGrading {
  if (_needsGrading is EqualUnmodifiableListView) return _needsGrading;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_needsGrading);
}


/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDtoCopyWith<_DashboardDto> get copyWith => __$DashboardDtoCopyWithImpl<_DashboardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardDto&&(identical(other.thisWeekSessions, thisWeekSessions) || other.thisWeekSessions == thisWeekSessions)&&(identical(other.pendingRequests, pendingRequests) || other.pendingRequests == pendingRequests)&&(identical(other.earningsThisMonth, earningsThisMonth) || other.earningsThisMonth == earningsThisMonth)&&(identical(other.ratingAvg, ratingAvg) || other.ratingAvg == ratingAvg)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount)&&const DeepCollectionEquality().equals(other.incomingBookings, _incomingBookings)&&const DeepCollectionEquality().equals(other.upcomingSessions, _upcomingSessions)&&const DeepCollectionEquality().equals(other.needsGrading, _needsGrading));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,thisWeekSessions,pendingRequests,earningsThisMonth,ratingAvg,ratingCount,const DeepCollectionEquality().hash(_incomingBookings),const DeepCollectionEquality().hash(_upcomingSessions),const DeepCollectionEquality().hash(_needsGrading));
}

@override
String toString() {
    return 'DashboardDto(thisWeekSessions: $thisWeekSessions, pendingRequests: $pendingRequests, earningsThisMonth: $earningsThisMonth, ratingAvg: $ratingAvg, ratingCount: $ratingCount, incomingBookings: $incomingBookings, upcomingSessions: $upcomingSessions, needsGrading: $needsGrading)';
}


}

/// @nodoc
abstract mixin class _$DashboardDtoCopyWith<$Res> implements $DashboardDtoCopyWith<$Res> {
  factory _$DashboardDtoCopyWith(_DashboardDto value, $Res Function(_DashboardDto) _then) = __$DashboardDtoCopyWithImpl;
@override @useResult
$Res call({
 int thisWeekSessions, int pendingRequests, int earningsThisMonth, double ratingAvg, int ratingCount, List<BookingDto> incomingBookings, List<BookingDto> upcomingSessions, List<BookingDto> needsGrading
});




}
/// @nodoc
class __$DashboardDtoCopyWithImpl<$Res>
    implements _$DashboardDtoCopyWith<$Res> {
  __$DashboardDtoCopyWithImpl(this._self, this._then);

  final _DashboardDto _self;
  final $Res Function(_DashboardDto) _then;

/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? thisWeekSessions = null,Object? pendingRequests = null,Object? earningsThisMonth = null,Object? ratingAvg = null,Object? ratingCount = null,Object? incomingBookings = null,Object? upcomingSessions = null,Object? needsGrading = null,}) {
  return _then(_DashboardDto(
thisWeekSessions: null == thisWeekSessions ? _self.thisWeekSessions : thisWeekSessions // ignore: cast_nullable_to_non_nullable
as int,pendingRequests: null == pendingRequests ? _self.pendingRequests : pendingRequests // ignore: cast_nullable_to_non_nullable
as int,earningsThisMonth: null == earningsThisMonth ? _self.earningsThisMonth : earningsThisMonth // ignore: cast_nullable_to_non_nullable
as int,ratingAvg: null == ratingAvg ? _self.ratingAvg : ratingAvg // ignore: cast_nullable_to_non_nullable
as double,ratingCount: null == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int,incomingBookings: null == incomingBookings ? _self._incomingBookings : incomingBookings // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,upcomingSessions: null == upcomingSessions ? _self._upcomingSessions : upcomingSessions // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,needsGrading: null == needsGrading ? _self._needsGrading : needsGrading // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,
  ));
}


}

// dart format on
