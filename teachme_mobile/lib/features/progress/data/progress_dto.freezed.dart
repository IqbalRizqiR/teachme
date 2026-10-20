// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressEntryDto {

 int get sessionNo; String get date; int get score; String get note; String get subjectName; String get tutorName;
/// Create a copy of ProgressEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressEntryDtoCopyWith<ProgressEntryDto> get copyWith => _$ProgressEntryDtoCopyWithImpl<ProgressEntryDto>(this as ProgressEntryDto, _$identity);

  /// Serializes this ProgressEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProgressEntryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressEntryDto&&(identical(other.sessionNo, _this.sessionNo) || other.sessionNo == _this.sessionNo)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.tutorName, _this.tutorName) || other.tutorName == _this.tutorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProgressEntryDto;
  return Object.hash(runtimeType,_this.sessionNo,_this.date,_this.score,_this.note,_this.subjectName,_this.tutorName);
}

@override
String toString() {
  final _this = this as ProgressEntryDto;
  return 'ProgressEntryDto(sessionNo: ${_this.sessionNo}, date: ${_this.date}, score: ${_this.score}, note: ${_this.note}, subjectName: ${_this.subjectName}, tutorName: ${_this.tutorName})';
}


}

/// @nodoc
abstract mixin class $ProgressEntryDtoCopyWith<$Res>  {
  factory $ProgressEntryDtoCopyWith(ProgressEntryDto value, $Res Function(ProgressEntryDto) _then) = _$ProgressEntryDtoCopyWithImpl;
@useResult
$Res call({
 int sessionNo, String date, int score, String note, String subjectName, String tutorName
});




}
/// @nodoc
class _$ProgressEntryDtoCopyWithImpl<$Res>
    implements $ProgressEntryDtoCopyWith<$Res> {
  _$ProgressEntryDtoCopyWithImpl(this._self, this._then);

  final ProgressEntryDto _self;
  final $Res Function(ProgressEntryDto) _then;

/// Create a copy of ProgressEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionNo = null,Object? date = null,Object? score = null,Object? note = null,Object? subjectName = null,Object? tutorName = null,}) {
  return _then(ProgressEntryDto(
sessionNo: null == sessionNo ? _self.sessionNo : sessionNo // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,tutorName: null == tutorName ? _self.tutorName : tutorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressEntryDto].
extension ProgressEntryDtoPatterns on ProgressEntryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressEntryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _ProgressEntryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressEntryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionNo,  String date,  int score,  String note,  String subjectName,  String tutorName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressEntryDto() when $default != null:
return $default(_that.sessionNo,_that.date,_that.score,_that.note,_that.subjectName,_that.tutorName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionNo,  String date,  int score,  String note,  String subjectName,  String tutorName)  $default,) {final _that = this;
switch (_that) {
case _ProgressEntryDto():
return $default(_that.sessionNo,_that.date,_that.score,_that.note,_that.subjectName,_that.tutorName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionNo,  String date,  int score,  String note,  String subjectName,  String tutorName)?  $default,) {final _that = this;
switch (_that) {
case _ProgressEntryDto() when $default != null:
return $default(_that.sessionNo,_that.date,_that.score,_that.note,_that.subjectName,_that.tutorName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressEntryDto implements ProgressEntryDto {
  const _ProgressEntryDto({required this.sessionNo, required this.date, required this.score, required this.note, required this.subjectName, required this.tutorName});
  factory _ProgressEntryDto.fromJson(Map<String, dynamic> json) => _$ProgressEntryDtoFromJson(json);

@override final  int sessionNo;
@override final  String date;
@override final  int score;
@override final  String note;
@override final  String subjectName;
@override final  String tutorName;

/// Create a copy of ProgressEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressEntryDtoCopyWith<_ProgressEntryDto> get copyWith => __$ProgressEntryDtoCopyWithImpl<_ProgressEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressEntryDto&&(identical(other.sessionNo, sessionNo) || other.sessionNo == sessionNo)&&(identical(other.date, date) || other.date == date)&&(identical(other.score, score) || other.score == score)&&(identical(other.note, note) || other.note == note)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.tutorName, tutorName) || other.tutorName == tutorName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionNo,date,score,note,subjectName,tutorName);
}

@override
String toString() {
    return 'ProgressEntryDto(sessionNo: $sessionNo, date: $date, score: $score, note: $note, subjectName: $subjectName, tutorName: $tutorName)';
}


}

/// @nodoc
abstract mixin class _$ProgressEntryDtoCopyWith<$Res> implements $ProgressEntryDtoCopyWith<$Res> {
  factory _$ProgressEntryDtoCopyWith(_ProgressEntryDto value, $Res Function(_ProgressEntryDto) _then) = __$ProgressEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionNo, String date, int score, String note, String subjectName, String tutorName
});




}
/// @nodoc
class __$ProgressEntryDtoCopyWithImpl<$Res>
    implements _$ProgressEntryDtoCopyWith<$Res> {
  __$ProgressEntryDtoCopyWithImpl(this._self, this._then);

  final _ProgressEntryDto _self;
  final $Res Function(_ProgressEntryDto) _then;

/// Create a copy of ProgressEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionNo = null,Object? date = null,Object? score = null,Object? note = null,Object? subjectName = null,Object? tutorName = null,}) {
  return _then(_ProgressEntryDto(
sessionNo: null == sessionNo ? _self.sessionNo : sessionNo // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,tutorName: null == tutorName ? _self.tutorName : tutorName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProgressSummary {

 int? get targetScore; int? get minSessions; int get completedSessions; double get average;
/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressSummaryCopyWith<ProgressSummary> get copyWith => _$ProgressSummaryCopyWithImpl<ProgressSummary>(this as ProgressSummary, _$identity);

  /// Serializes this ProgressSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProgressSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressSummary&&(identical(other.targetScore, _this.targetScore) || other.targetScore == _this.targetScore)&&(identical(other.minSessions, _this.minSessions) || other.minSessions == _this.minSessions)&&(identical(other.completedSessions, _this.completedSessions) || other.completedSessions == _this.completedSessions)&&(identical(other.average, _this.average) || other.average == _this.average));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProgressSummary;
  return Object.hash(runtimeType,_this.targetScore,_this.minSessions,_this.completedSessions,_this.average);
}

@override
String toString() {
  final _this = this as ProgressSummary;
  return 'ProgressSummary(targetScore: ${_this.targetScore}, minSessions: ${_this.minSessions}, completedSessions: ${_this.completedSessions}, average: ${_this.average})';
}


}

/// @nodoc
abstract mixin class $ProgressSummaryCopyWith<$Res>  {
  factory $ProgressSummaryCopyWith(ProgressSummary value, $Res Function(ProgressSummary) _then) = _$ProgressSummaryCopyWithImpl;
@useResult
$Res call({
 int? targetScore, int? minSessions, int completedSessions, double average
});




}
/// @nodoc
class _$ProgressSummaryCopyWithImpl<$Res>
    implements $ProgressSummaryCopyWith<$Res> {
  _$ProgressSummaryCopyWithImpl(this._self, this._then);

  final ProgressSummary _self;
  final $Res Function(ProgressSummary) _then;

/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetScore = freezed,Object? minSessions = freezed,Object? completedSessions = null,Object? average = null,}) {
  return _then(ProgressSummary(
targetScore: freezed == targetScore ? _self.targetScore : targetScore // ignore: cast_nullable_to_non_nullable
as int?,minSessions: freezed == minSessions ? _self.minSessions : minSessions // ignore: cast_nullable_to_non_nullable
as int?,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressSummary].
extension ProgressSummaryPatterns on ProgressSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressSummary value)  $default,){
final _that = this;
switch (_that) {
case _ProgressSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? targetScore,  int? minSessions,  int completedSessions,  double average)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that.targetScore,_that.minSessions,_that.completedSessions,_that.average);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? targetScore,  int? minSessions,  int completedSessions,  double average)  $default,) {final _that = this;
switch (_that) {
case _ProgressSummary():
return $default(_that.targetScore,_that.minSessions,_that.completedSessions,_that.average);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? targetScore,  int? minSessions,  int completedSessions,  double average)?  $default,) {final _that = this;
switch (_that) {
case _ProgressSummary() when $default != null:
return $default(_that.targetScore,_that.minSessions,_that.completedSessions,_that.average);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressSummary implements ProgressSummary {
  const _ProgressSummary({this.targetScore, this.minSessions, required this.completedSessions, required this.average});
  factory _ProgressSummary.fromJson(Map<String, dynamic> json) => _$ProgressSummaryFromJson(json);

@override final  int? targetScore;
@override final  int? minSessions;
@override final  int completedSessions;
@override final  double average;

/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressSummaryCopyWith<_ProgressSummary> get copyWith => __$ProgressSummaryCopyWithImpl<_ProgressSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressSummary&&(identical(other.targetScore, targetScore) || other.targetScore == targetScore)&&(identical(other.minSessions, minSessions) || other.minSessions == minSessions)&&(identical(other.completedSessions, completedSessions) || other.completedSessions == completedSessions)&&(identical(other.average, average) || other.average == average));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,targetScore,minSessions,completedSessions,average);
}

@override
String toString() {
    return 'ProgressSummary(targetScore: $targetScore, minSessions: $minSessions, completedSessions: $completedSessions, average: $average)';
}


}

/// @nodoc
abstract mixin class _$ProgressSummaryCopyWith<$Res> implements $ProgressSummaryCopyWith<$Res> {
  factory _$ProgressSummaryCopyWith(_ProgressSummary value, $Res Function(_ProgressSummary) _then) = __$ProgressSummaryCopyWithImpl;
@override @useResult
$Res call({
 int? targetScore, int? minSessions, int completedSessions, double average
});




}
/// @nodoc
class __$ProgressSummaryCopyWithImpl<$Res>
    implements _$ProgressSummaryCopyWith<$Res> {
  __$ProgressSummaryCopyWithImpl(this._self, this._then);

  final _ProgressSummary _self;
  final $Res Function(_ProgressSummary) _then;

/// Create a copy of ProgressSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetScore = freezed,Object? minSessions = freezed,Object? completedSessions = null,Object? average = null,}) {
  return _then(_ProgressSummary(
targetScore: freezed == targetScore ? _self.targetScore : targetScore // ignore: cast_nullable_to_non_nullable
as int?,minSessions: freezed == minSessions ? _self.minSessions : minSessions // ignore: cast_nullable_to_non_nullable
as int?,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ProgressResponse {

 List<ProgressEntryDto> get entries; ProgressSummary get summary;
/// Create a copy of ProgressResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressResponseCopyWith<ProgressResponse> get copyWith => _$ProgressResponseCopyWithImpl<ProgressResponse>(this as ProgressResponse, _$identity);

  /// Serializes this ProgressResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProgressResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressResponse&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&(identical(other.summary, _this.summary) || other.summary == _this.summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProgressResponse;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.entries),_this.summary);
}

@override
String toString() {
  final _this = this as ProgressResponse;
  return 'ProgressResponse(entries: ${_this.entries}, summary: ${_this.summary})';
}


}

/// @nodoc
abstract mixin class $ProgressResponseCopyWith<$Res>  {
  factory $ProgressResponseCopyWith(ProgressResponse value, $Res Function(ProgressResponse) _then) = _$ProgressResponseCopyWithImpl;
@useResult
$Res call({
 List<ProgressEntryDto> entries, ProgressSummary summary
});


$ProgressSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$ProgressResponseCopyWithImpl<$Res>
    implements $ProgressResponseCopyWith<$Res> {
  _$ProgressResponseCopyWithImpl(this._self, this._then);

  final ProgressResponse _self;
  final $Res Function(ProgressResponse) _then;

/// Create a copy of ProgressResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,Object? summary = null,}) {
  return _then(ProgressResponse(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<ProgressEntryDto>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProgressSummary,
  ));
}
/// Create a copy of ProgressResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressSummaryCopyWith<$Res> get summary {
  
  return $ProgressSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProgressResponse].
extension ProgressResponsePatterns on ProgressResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProgressResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProgressEntryDto> entries,  ProgressSummary summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressResponse() when $default != null:
return $default(_that.entries,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProgressEntryDto> entries,  ProgressSummary summary)  $default,) {final _that = this;
switch (_that) {
case _ProgressResponse():
return $default(_that.entries,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProgressEntryDto> entries,  ProgressSummary summary)?  $default,) {final _that = this;
switch (_that) {
case _ProgressResponse() when $default != null:
return $default(_that.entries,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressResponse implements ProgressResponse {
  const _ProgressResponse({required  List<ProgressEntryDto> entries, required this.summary}): _entries = entries;
  factory _ProgressResponse.fromJson(Map<String, dynamic> json) => _$ProgressResponseFromJson(json);

 final  List<ProgressEntryDto> _entries;
@override List<ProgressEntryDto> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override final  ProgressSummary summary;

/// Create a copy of ProgressResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressResponseCopyWith<_ProgressResponse> get copyWith => __$ProgressResponseCopyWithImpl<_ProgressResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressResponseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressResponse&&const DeepCollectionEquality().equals(other.entries, _entries)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),summary);
}

@override
String toString() {
    return 'ProgressResponse(entries: $entries, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$ProgressResponseCopyWith<$Res> implements $ProgressResponseCopyWith<$Res> {
  factory _$ProgressResponseCopyWith(_ProgressResponse value, $Res Function(_ProgressResponse) _then) = __$ProgressResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ProgressEntryDto> entries, ProgressSummary summary
});


@override $ProgressSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$ProgressResponseCopyWithImpl<$Res>
    implements _$ProgressResponseCopyWith<$Res> {
  __$ProgressResponseCopyWithImpl(this._self, this._then);

  final _ProgressResponse _self;
  final $Res Function(_ProgressResponse) _then;

/// Create a copy of ProgressResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? summary = null,}) {
  return _then(_ProgressResponse(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<ProgressEntryDto>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as ProgressSummary,
  ));
}

/// Create a copy of ProgressResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProgressSummaryCopyWith<$Res> get summary {
  
  return $ProgressSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$EnrollmentDto {

 String get id; String get subjectName; String get tutorName; int? get targetScore; int? get minSessions; int get completedSessions; double get averageScore; bool get hasCertificate; String? get certificateId;
/// Create a copy of EnrollmentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnrollmentDtoCopyWith<EnrollmentDto> get copyWith => _$EnrollmentDtoCopyWithImpl<EnrollmentDto>(this as EnrollmentDto, _$identity);

  /// Serializes this EnrollmentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EnrollmentDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnrollmentDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.tutorName, _this.tutorName) || other.tutorName == _this.tutorName)&&(identical(other.targetScore, _this.targetScore) || other.targetScore == _this.targetScore)&&(identical(other.minSessions, _this.minSessions) || other.minSessions == _this.minSessions)&&(identical(other.completedSessions, _this.completedSessions) || other.completedSessions == _this.completedSessions)&&(identical(other.averageScore, _this.averageScore) || other.averageScore == _this.averageScore)&&(identical(other.hasCertificate, _this.hasCertificate) || other.hasCertificate == _this.hasCertificate)&&(identical(other.certificateId, _this.certificateId) || other.certificateId == _this.certificateId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EnrollmentDto;
  return Object.hash(runtimeType,_this.id,_this.subjectName,_this.tutorName,_this.targetScore,_this.minSessions,_this.completedSessions,_this.averageScore,_this.hasCertificate,_this.certificateId);
}

@override
String toString() {
  final _this = this as EnrollmentDto;
  return 'EnrollmentDto(id: ${_this.id}, subjectName: ${_this.subjectName}, tutorName: ${_this.tutorName}, targetScore: ${_this.targetScore}, minSessions: ${_this.minSessions}, completedSessions: ${_this.completedSessions}, averageScore: ${_this.averageScore}, hasCertificate: ${_this.hasCertificate}, certificateId: ${_this.certificateId})';
}


}

/// @nodoc
abstract mixin class $EnrollmentDtoCopyWith<$Res>  {
  factory $EnrollmentDtoCopyWith(EnrollmentDto value, $Res Function(EnrollmentDto) _then) = _$EnrollmentDtoCopyWithImpl;
@useResult
$Res call({
 String id, String subjectName, String tutorName, int? targetScore, int? minSessions, int completedSessions, double averageScore, bool hasCertificate, String? certificateId
});




}
/// @nodoc
class _$EnrollmentDtoCopyWithImpl<$Res>
    implements $EnrollmentDtoCopyWith<$Res> {
  _$EnrollmentDtoCopyWithImpl(this._self, this._then);

  final EnrollmentDto _self;
  final $Res Function(EnrollmentDto) _then;

/// Create a copy of EnrollmentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subjectName = null,Object? tutorName = null,Object? targetScore = freezed,Object? minSessions = freezed,Object? completedSessions = null,Object? averageScore = null,Object? hasCertificate = null,Object? certificateId = freezed,}) {
  return _then(EnrollmentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,tutorName: null == tutorName ? _self.tutorName : tutorName // ignore: cast_nullable_to_non_nullable
as String,targetScore: freezed == targetScore ? _self.targetScore : targetScore // ignore: cast_nullable_to_non_nullable
as int?,minSessions: freezed == minSessions ? _self.minSessions : minSessions // ignore: cast_nullable_to_non_nullable
as int?,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as double,hasCertificate: null == hasCertificate ? _self.hasCertificate : hasCertificate // ignore: cast_nullable_to_non_nullable
as bool,certificateId: freezed == certificateId ? _self.certificateId : certificateId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EnrollmentDto].
extension EnrollmentDtoPatterns on EnrollmentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnrollmentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnrollmentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnrollmentDto value)  $default,){
final _that = this;
switch (_that) {
case _EnrollmentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnrollmentDto value)?  $default,){
final _that = this;
switch (_that) {
case _EnrollmentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subjectName,  String tutorName,  int? targetScore,  int? minSessions,  int completedSessions,  double averageScore,  bool hasCertificate,  String? certificateId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnrollmentDto() when $default != null:
return $default(_that.id,_that.subjectName,_that.tutorName,_that.targetScore,_that.minSessions,_that.completedSessions,_that.averageScore,_that.hasCertificate,_that.certificateId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subjectName,  String tutorName,  int? targetScore,  int? minSessions,  int completedSessions,  double averageScore,  bool hasCertificate,  String? certificateId)  $default,) {final _that = this;
switch (_that) {
case _EnrollmentDto():
return $default(_that.id,_that.subjectName,_that.tutorName,_that.targetScore,_that.minSessions,_that.completedSessions,_that.averageScore,_that.hasCertificate,_that.certificateId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subjectName,  String tutorName,  int? targetScore,  int? minSessions,  int completedSessions,  double averageScore,  bool hasCertificate,  String? certificateId)?  $default,) {final _that = this;
switch (_that) {
case _EnrollmentDto() when $default != null:
return $default(_that.id,_that.subjectName,_that.tutorName,_that.targetScore,_that.minSessions,_that.completedSessions,_that.averageScore,_that.hasCertificate,_that.certificateId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnrollmentDto implements EnrollmentDto {
  const _EnrollmentDto({required this.id, required this.subjectName, required this.tutorName, this.targetScore, this.minSessions, required this.completedSessions, required this.averageScore, required this.hasCertificate, this.certificateId});
  factory _EnrollmentDto.fromJson(Map<String, dynamic> json) => _$EnrollmentDtoFromJson(json);

@override final  String id;
@override final  String subjectName;
@override final  String tutorName;
@override final  int? targetScore;
@override final  int? minSessions;
@override final  int completedSessions;
@override final  double averageScore;
@override final  bool hasCertificate;
@override final  String? certificateId;

/// Create a copy of EnrollmentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnrollmentDtoCopyWith<_EnrollmentDto> get copyWith => __$EnrollmentDtoCopyWithImpl<_EnrollmentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnrollmentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnrollmentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.tutorName, tutorName) || other.tutorName == tutorName)&&(identical(other.targetScore, targetScore) || other.targetScore == targetScore)&&(identical(other.minSessions, minSessions) || other.minSessions == minSessions)&&(identical(other.completedSessions, completedSessions) || other.completedSessions == completedSessions)&&(identical(other.averageScore, averageScore) || other.averageScore == averageScore)&&(identical(other.hasCertificate, hasCertificate) || other.hasCertificate == hasCertificate)&&(identical(other.certificateId, certificateId) || other.certificateId == certificateId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,subjectName,tutorName,targetScore,minSessions,completedSessions,averageScore,hasCertificate,certificateId);
}

@override
String toString() {
    return 'EnrollmentDto(id: $id, subjectName: $subjectName, tutorName: $tutorName, targetScore: $targetScore, minSessions: $minSessions, completedSessions: $completedSessions, averageScore: $averageScore, hasCertificate: $hasCertificate, certificateId: $certificateId)';
}


}

/// @nodoc
abstract mixin class _$EnrollmentDtoCopyWith<$Res> implements $EnrollmentDtoCopyWith<$Res> {
  factory _$EnrollmentDtoCopyWith(_EnrollmentDto value, $Res Function(_EnrollmentDto) _then) = __$EnrollmentDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String subjectName, String tutorName, int? targetScore, int? minSessions, int completedSessions, double averageScore, bool hasCertificate, String? certificateId
});




}
/// @nodoc
class __$EnrollmentDtoCopyWithImpl<$Res>
    implements _$EnrollmentDtoCopyWith<$Res> {
  __$EnrollmentDtoCopyWithImpl(this._self, this._then);

  final _EnrollmentDto _self;
  final $Res Function(_EnrollmentDto) _then;

/// Create a copy of EnrollmentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subjectName = null,Object? tutorName = null,Object? targetScore = freezed,Object? minSessions = freezed,Object? completedSessions = null,Object? averageScore = null,Object? hasCertificate = null,Object? certificateId = freezed,}) {
  return _then(_EnrollmentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,tutorName: null == tutorName ? _self.tutorName : tutorName // ignore: cast_nullable_to_non_nullable
as String,targetScore: freezed == targetScore ? _self.targetScore : targetScore // ignore: cast_nullable_to_non_nullable
as int?,minSessions: freezed == minSessions ? _self.minSessions : minSessions // ignore: cast_nullable_to_non_nullable
as int?,completedSessions: null == completedSessions ? _self.completedSessions : completedSessions // ignore: cast_nullable_to_non_nullable
as int,averageScore: null == averageScore ? _self.averageScore : averageScore // ignore: cast_nullable_to_non_nullable
as double,hasCertificate: null == hasCertificate ? _self.hasCertificate : hasCertificate // ignore: cast_nullable_to_non_nullable
as bool,certificateId: freezed == certificateId ? _self.certificateId : certificateId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
