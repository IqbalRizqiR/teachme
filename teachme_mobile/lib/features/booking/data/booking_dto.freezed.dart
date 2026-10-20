// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingTutor {

 String get id; String get name;
/// Create a copy of BookingTutor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingTutorCopyWith<BookingTutor> get copyWith => _$BookingTutorCopyWithImpl<BookingTutor>(this as BookingTutor, _$identity);

  /// Serializes this BookingTutor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingTutor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingTutor&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingTutor;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as BookingTutor;
  return 'BookingTutor(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $BookingTutorCopyWith<$Res>  {
  factory $BookingTutorCopyWith(BookingTutor value, $Res Function(BookingTutor) _then) = _$BookingTutorCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$BookingTutorCopyWithImpl<$Res>
    implements $BookingTutorCopyWith<$Res> {
  _$BookingTutorCopyWithImpl(this._self, this._then);

  final BookingTutor _self;
  final $Res Function(BookingTutor) _then;

/// Create a copy of BookingTutor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(BookingTutor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingTutor].
extension BookingTutorPatterns on BookingTutor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingTutor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingTutor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingTutor value)  $default,){
final _that = this;
switch (_that) {
case _BookingTutor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingTutor value)?  $default,){
final _that = this;
switch (_that) {
case _BookingTutor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingTutor() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _BookingTutor():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _BookingTutor() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingTutor implements BookingTutor {
  const _BookingTutor({required this.id, required this.name});
  factory _BookingTutor.fromJson(Map<String, dynamic> json) => _$BookingTutorFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of BookingTutor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingTutorCopyWith<_BookingTutor> get copyWith => __$BookingTutorCopyWithImpl<_BookingTutor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingTutorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingTutor&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'BookingTutor(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$BookingTutorCopyWith<$Res> implements $BookingTutorCopyWith<$Res> {
  factory _$BookingTutorCopyWith(_BookingTutor value, $Res Function(_BookingTutor) _then) = __$BookingTutorCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$BookingTutorCopyWithImpl<$Res>
    implements _$BookingTutorCopyWith<$Res> {
  __$BookingTutorCopyWithImpl(this._self, this._then);

  final _BookingTutor _self;
  final $Res Function(_BookingTutor) _then;

/// Create a copy of BookingTutor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_BookingTutor(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BookingStudent {

 String get id; String get name;
/// Create a copy of BookingStudent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStudentCopyWith<BookingStudent> get copyWith => _$BookingStudentCopyWithImpl<BookingStudent>(this as BookingStudent, _$identity);

  /// Serializes this BookingStudent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingStudent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStudent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingStudent;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as BookingStudent;
  return 'BookingStudent(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $BookingStudentCopyWith<$Res>  {
  factory $BookingStudentCopyWith(BookingStudent value, $Res Function(BookingStudent) _then) = _$BookingStudentCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$BookingStudentCopyWithImpl<$Res>
    implements $BookingStudentCopyWith<$Res> {
  _$BookingStudentCopyWithImpl(this._self, this._then);

  final BookingStudent _self;
  final $Res Function(BookingStudent) _then;

/// Create a copy of BookingStudent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(BookingStudent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingStudent].
extension BookingStudentPatterns on BookingStudent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingStudent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingStudent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingStudent value)  $default,){
final _that = this;
switch (_that) {
case _BookingStudent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingStudent value)?  $default,){
final _that = this;
switch (_that) {
case _BookingStudent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingStudent() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _BookingStudent():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _BookingStudent() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingStudent implements BookingStudent {
  const _BookingStudent({required this.id, required this.name});
  factory _BookingStudent.fromJson(Map<String, dynamic> json) => _$BookingStudentFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of BookingStudent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingStudentCopyWith<_BookingStudent> get copyWith => __$BookingStudentCopyWithImpl<_BookingStudent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingStudentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingStudent&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'BookingStudent(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$BookingStudentCopyWith<$Res> implements $BookingStudentCopyWith<$Res> {
  factory _$BookingStudentCopyWith(_BookingStudent value, $Res Function(_BookingStudent) _then) = __$BookingStudentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$BookingStudentCopyWithImpl<$Res>
    implements _$BookingStudentCopyWith<$Res> {
  __$BookingStudentCopyWithImpl(this._self, this._then);

  final _BookingStudent _self;
  final $Res Function(_BookingStudent) _then;

/// Create a copy of BookingStudent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_BookingStudent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PaymentDto {

 String get id; String get orderId; int get amountIdr; String get status; String? get method; List<String>? get methods; String? get reference;
/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentDtoCopyWith<PaymentDto> get copyWith => _$PaymentDtoCopyWithImpl<PaymentDto>(this as PaymentDto, _$identity);

  /// Serializes this PaymentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaymentDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.amountIdr, _this.amountIdr) || other.amountIdr == _this.amountIdr)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.method, _this.method) || other.method == _this.method)&&const DeepCollectionEquality().equals(other.methods, _this.methods)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaymentDto;
  return Object.hash(runtimeType,_this.id,_this.orderId,_this.amountIdr,_this.status,_this.method,const DeepCollectionEquality().hash(_this.methods),_this.reference);
}

@override
String toString() {
  final _this = this as PaymentDto;
  return 'PaymentDto(id: ${_this.id}, orderId: ${_this.orderId}, amountIdr: ${_this.amountIdr}, status: ${_this.status}, method: ${_this.method}, methods: ${_this.methods}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $PaymentDtoCopyWith<$Res>  {
  factory $PaymentDtoCopyWith(PaymentDto value, $Res Function(PaymentDto) _then) = _$PaymentDtoCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, int amountIdr, String status, String? method, List<String>? methods, String? reference
});




}
/// @nodoc
class _$PaymentDtoCopyWithImpl<$Res>
    implements $PaymentDtoCopyWith<$Res> {
  _$PaymentDtoCopyWithImpl(this._self, this._then);

  final PaymentDto _self;
  final $Res Function(PaymentDto) _then;

/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? amountIdr = null,Object? status = null,Object? method = freezed,Object? methods = freezed,Object? reference = freezed,}) {
  return _then(PaymentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,amountIdr: null == amountIdr ? _self.amountIdr : amountIdr // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,methods: freezed == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentDto].
extension PaymentDtoPatterns on PaymentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentDto value)  $default,){
final _that = this;
switch (_that) {
case _PaymentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentDto value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  int amountIdr,  String status,  String? method,  List<String>? methods,  String? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
return $default(_that.id,_that.orderId,_that.amountIdr,_that.status,_that.method,_that.methods,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  int amountIdr,  String status,  String? method,  List<String>? methods,  String? reference)  $default,) {final _that = this;
switch (_that) {
case _PaymentDto():
return $default(_that.id,_that.orderId,_that.amountIdr,_that.status,_that.method,_that.methods,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  int amountIdr,  String status,  String? method,  List<String>? methods,  String? reference)?  $default,) {final _that = this;
switch (_that) {
case _PaymentDto() when $default != null:
return $default(_that.id,_that.orderId,_that.amountIdr,_that.status,_that.method,_that.methods,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentDto implements PaymentDto {
  const _PaymentDto({required this.id, required this.orderId, required this.amountIdr, required this.status, this.method,  List<String>? methods, this.reference}): _methods = methods;
  factory _PaymentDto.fromJson(Map<String, dynamic> json) => _$PaymentDtoFromJson(json);

@override final  String id;
@override final  String orderId;
@override final  int amountIdr;
@override final  String status;
@override final  String? method;
 final  List<String>? _methods;
@override List<String>? get methods {
  final value = _methods;
  if (value == null) return null;
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? reference;

/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentDtoCopyWith<_PaymentDto> get copyWith => __$PaymentDtoCopyWithImpl<_PaymentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.amountIdr, amountIdr) || other.amountIdr == amountIdr)&&(identical(other.status, status) || other.status == status)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.methods, _methods)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,orderId,amountIdr,status,method,const DeepCollectionEquality().hash(_methods),reference);
}

@override
String toString() {
    return 'PaymentDto(id: $id, orderId: $orderId, amountIdr: $amountIdr, status: $status, method: $method, methods: $methods, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$PaymentDtoCopyWith<$Res> implements $PaymentDtoCopyWith<$Res> {
  factory _$PaymentDtoCopyWith(_PaymentDto value, $Res Function(_PaymentDto) _then) = __$PaymentDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, int amountIdr, String status, String? method, List<String>? methods, String? reference
});




}
/// @nodoc
class __$PaymentDtoCopyWithImpl<$Res>
    implements _$PaymentDtoCopyWith<$Res> {
  __$PaymentDtoCopyWithImpl(this._self, this._then);

  final _PaymentDto _self;
  final $Res Function(_PaymentDto) _then;

/// Create a copy of PaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? amountIdr = null,Object? status = null,Object? method = freezed,Object? methods = freezed,Object? reference = freezed,}) {
  return _then(_PaymentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,amountIdr: null == amountIdr ? _self.amountIdr : amountIdr // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,methods: freezed == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BookingDto {

 String get id; String get status; int get priceIdr; int get feeIdr; String? get note; String? get rejectReason; String get respondBy; String? get payBy; String get createdAt; SlotDto get slot; BookingTutor? get tutor; BookingStudent? get student; String? get subjectName; PaymentDto? get payment;
/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDtoCopyWith<BookingDto> get copyWith => _$BookingDtoCopyWithImpl<BookingDto>(this as BookingDto, _$identity);

  /// Serializes this BookingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BookingDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.priceIdr, _this.priceIdr) || other.priceIdr == _this.priceIdr)&&(identical(other.feeIdr, _this.feeIdr) || other.feeIdr == _this.feeIdr)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.rejectReason, _this.rejectReason) || other.rejectReason == _this.rejectReason)&&(identical(other.respondBy, _this.respondBy) || other.respondBy == _this.respondBy)&&(identical(other.payBy, _this.payBy) || other.payBy == _this.payBy)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.slot, _this.slot) || other.slot == _this.slot)&&(identical(other.tutor, _this.tutor) || other.tutor == _this.tutor)&&(identical(other.student, _this.student) || other.student == _this.student)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.payment, _this.payment) || other.payment == _this.payment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BookingDto;
  return Object.hash(runtimeType,_this.id,_this.status,_this.priceIdr,_this.feeIdr,_this.note,_this.rejectReason,_this.respondBy,_this.payBy,_this.createdAt,_this.slot,_this.tutor,_this.student,_this.subjectName,_this.payment);
}

@override
String toString() {
  final _this = this as BookingDto;
  return 'BookingDto(id: ${_this.id}, status: ${_this.status}, priceIdr: ${_this.priceIdr}, feeIdr: ${_this.feeIdr}, note: ${_this.note}, rejectReason: ${_this.rejectReason}, respondBy: ${_this.respondBy}, payBy: ${_this.payBy}, createdAt: ${_this.createdAt}, slot: ${_this.slot}, tutor: ${_this.tutor}, student: ${_this.student}, subjectName: ${_this.subjectName}, payment: ${_this.payment})';
}


}

/// @nodoc
abstract mixin class $BookingDtoCopyWith<$Res>  {
  factory $BookingDtoCopyWith(BookingDto value, $Res Function(BookingDto) _then) = _$BookingDtoCopyWithImpl;
@useResult
$Res call({
 String id, String status, int priceIdr, int feeIdr, String? note, String? rejectReason, String respondBy, String? payBy, String createdAt, SlotDto slot, BookingTutor? tutor, BookingStudent? student, String? subjectName, PaymentDto? payment
});


$SlotDtoCopyWith<$Res> get slot;$BookingTutorCopyWith<$Res>? get tutor;$BookingStudentCopyWith<$Res>? get student;$PaymentDtoCopyWith<$Res>? get payment;

}
/// @nodoc
class _$BookingDtoCopyWithImpl<$Res>
    implements $BookingDtoCopyWith<$Res> {
  _$BookingDtoCopyWithImpl(this._self, this._then);

  final BookingDto _self;
  final $Res Function(BookingDto) _then;

/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? status = null,Object? priceIdr = null,Object? feeIdr = null,Object? note = freezed,Object? rejectReason = freezed,Object? respondBy = null,Object? payBy = freezed,Object? createdAt = null,Object? slot = null,Object? tutor = freezed,Object? student = freezed,Object? subjectName = freezed,Object? payment = freezed,}) {
  return _then(BookingDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priceIdr: null == priceIdr ? _self.priceIdr : priceIdr // ignore: cast_nullable_to_non_nullable
as int,feeIdr: null == feeIdr ? _self.feeIdr : feeIdr // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,rejectReason: freezed == rejectReason ? _self.rejectReason : rejectReason // ignore: cast_nullable_to_non_nullable
as String?,respondBy: null == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as String,payBy: freezed == payBy ? _self.payBy : payBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as SlotDto,tutor: freezed == tutor ? _self.tutor : tutor // ignore: cast_nullable_to_non_nullable
as BookingTutor?,student: freezed == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as BookingStudent?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentDto?,
  ));
}
/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlotDtoCopyWith<$Res> get slot {
  
  return $SlotDtoCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingTutorCopyWith<$Res>? get tutor {
    if (_self.tutor == null) {
    return null;
  }

  return $BookingTutorCopyWith<$Res>(_self.tutor!, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingStudentCopyWith<$Res>? get student {
    if (_self.student == null) {
    return null;
  }

  return $BookingStudentCopyWith<$Res>(_self.student!, (value) {
    return _then(_self.copyWith(student: value));
  });
}/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentDtoCopyWith<$Res>? get payment {
    if (_self.payment == null) {
    return null;
  }

  return $PaymentDtoCopyWith<$Res>(_self.payment!, (value) {
    return _then(_self.copyWith(payment: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingDto].
extension BookingDtoPatterns on BookingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingDto value)  $default,){
final _that = this;
switch (_that) {
case _BookingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingDto value)?  $default,){
final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String status,  int priceIdr,  int feeIdr,  String? note,  String? rejectReason,  String respondBy,  String? payBy,  String createdAt,  SlotDto slot,  BookingTutor? tutor,  BookingStudent? student,  String? subjectName,  PaymentDto? payment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
return $default(_that.id,_that.status,_that.priceIdr,_that.feeIdr,_that.note,_that.rejectReason,_that.respondBy,_that.payBy,_that.createdAt,_that.slot,_that.tutor,_that.student,_that.subjectName,_that.payment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String status,  int priceIdr,  int feeIdr,  String? note,  String? rejectReason,  String respondBy,  String? payBy,  String createdAt,  SlotDto slot,  BookingTutor? tutor,  BookingStudent? student,  String? subjectName,  PaymentDto? payment)  $default,) {final _that = this;
switch (_that) {
case _BookingDto():
return $default(_that.id,_that.status,_that.priceIdr,_that.feeIdr,_that.note,_that.rejectReason,_that.respondBy,_that.payBy,_that.createdAt,_that.slot,_that.tutor,_that.student,_that.subjectName,_that.payment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String status,  int priceIdr,  int feeIdr,  String? note,  String? rejectReason,  String respondBy,  String? payBy,  String createdAt,  SlotDto slot,  BookingTutor? tutor,  BookingStudent? student,  String? subjectName,  PaymentDto? payment)?  $default,) {final _that = this;
switch (_that) {
case _BookingDto() when $default != null:
return $default(_that.id,_that.status,_that.priceIdr,_that.feeIdr,_that.note,_that.rejectReason,_that.respondBy,_that.payBy,_that.createdAt,_that.slot,_that.tutor,_that.student,_that.subjectName,_that.payment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingDto implements BookingDto {
  const _BookingDto({required this.id, required this.status, required this.priceIdr, required this.feeIdr, this.note, this.rejectReason, required this.respondBy, this.payBy, required this.createdAt, required this.slot, this.tutor, this.student, this.subjectName, this.payment});
  factory _BookingDto.fromJson(Map<String, dynamic> json) => _$BookingDtoFromJson(json);

@override final  String id;
@override final  String status;
@override final  int priceIdr;
@override final  int feeIdr;
@override final  String? note;
@override final  String? rejectReason;
@override final  String respondBy;
@override final  String? payBy;
@override final  String createdAt;
@override final  SlotDto slot;
@override final  BookingTutor? tutor;
@override final  BookingStudent? student;
@override final  String? subjectName;
@override final  PaymentDto? payment;

/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingDtoCopyWith<_BookingDto> get copyWith => __$BookingDtoCopyWithImpl<_BookingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.priceIdr, priceIdr) || other.priceIdr == priceIdr)&&(identical(other.feeIdr, feeIdr) || other.feeIdr == feeIdr)&&(identical(other.note, note) || other.note == note)&&(identical(other.rejectReason, rejectReason) || other.rejectReason == rejectReason)&&(identical(other.respondBy, respondBy) || other.respondBy == respondBy)&&(identical(other.payBy, payBy) || other.payBy == payBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.tutor, tutor) || other.tutor == tutor)&&(identical(other.student, student) || other.student == student)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.payment, payment) || other.payment == payment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,status,priceIdr,feeIdr,note,rejectReason,respondBy,payBy,createdAt,slot,tutor,student,subjectName,payment);
}

@override
String toString() {
    return 'BookingDto(id: $id, status: $status, priceIdr: $priceIdr, feeIdr: $feeIdr, note: $note, rejectReason: $rejectReason, respondBy: $respondBy, payBy: $payBy, createdAt: $createdAt, slot: $slot, tutor: $tutor, student: $student, subjectName: $subjectName, payment: $payment)';
}


}

/// @nodoc
abstract mixin class _$BookingDtoCopyWith<$Res> implements $BookingDtoCopyWith<$Res> {
  factory _$BookingDtoCopyWith(_BookingDto value, $Res Function(_BookingDto) _then) = __$BookingDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String status, int priceIdr, int feeIdr, String? note, String? rejectReason, String respondBy, String? payBy, String createdAt, SlotDto slot, BookingTutor? tutor, BookingStudent? student, String? subjectName, PaymentDto? payment
});


@override $SlotDtoCopyWith<$Res> get slot;@override $BookingTutorCopyWith<$Res>? get tutor;@override $BookingStudentCopyWith<$Res>? get student;@override $PaymentDtoCopyWith<$Res>? get payment;

}
/// @nodoc
class __$BookingDtoCopyWithImpl<$Res>
    implements _$BookingDtoCopyWith<$Res> {
  __$BookingDtoCopyWithImpl(this._self, this._then);

  final _BookingDto _self;
  final $Res Function(_BookingDto) _then;

/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? status = null,Object? priceIdr = null,Object? feeIdr = null,Object? note = freezed,Object? rejectReason = freezed,Object? respondBy = null,Object? payBy = freezed,Object? createdAt = null,Object? slot = null,Object? tutor = freezed,Object? student = freezed,Object? subjectName = freezed,Object? payment = freezed,}) {
  return _then(_BookingDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priceIdr: null == priceIdr ? _self.priceIdr : priceIdr // ignore: cast_nullable_to_non_nullable
as int,feeIdr: null == feeIdr ? _self.feeIdr : feeIdr // ignore: cast_nullable_to_non_nullable
as int,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,rejectReason: freezed == rejectReason ? _self.rejectReason : rejectReason // ignore: cast_nullable_to_non_nullable
as String?,respondBy: null == respondBy ? _self.respondBy : respondBy // ignore: cast_nullable_to_non_nullable
as String,payBy: freezed == payBy ? _self.payBy : payBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as SlotDto,tutor: freezed == tutor ? _self.tutor : tutor // ignore: cast_nullable_to_non_nullable
as BookingTutor?,student: freezed == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as BookingStudent?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as PaymentDto?,
  ));
}

/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlotDtoCopyWith<$Res> get slot {
  
  return $SlotDtoCopyWith<$Res>(_self.slot, (value) {
    return _then(_self.copyWith(slot: value));
  });
}/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingTutorCopyWith<$Res>? get tutor {
    if (_self.tutor == null) {
    return null;
  }

  return $BookingTutorCopyWith<$Res>(_self.tutor!, (value) {
    return _then(_self.copyWith(tutor: value));
  });
}/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BookingStudentCopyWith<$Res>? get student {
    if (_self.student == null) {
    return null;
  }

  return $BookingStudentCopyWith<$Res>(_self.student!, (value) {
    return _then(_self.copyWith(student: value));
  });
}/// Create a copy of BookingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentDtoCopyWith<$Res>? get payment {
    if (_self.payment == null) {
    return null;
  }

  return $PaymentDtoCopyWith<$Res>(_self.payment!, (value) {
    return _then(_self.copyWith(payment: value));
  });
}
}


/// @nodoc
mixin _$CreateBookingRequest {

 String get slotId; String get subjectId; String? get note;
/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateBookingRequestCopyWith<CreateBookingRequest> get copyWith => _$CreateBookingRequestCopyWithImpl<CreateBookingRequest>(this as CreateBookingRequest, _$identity);

  /// Serializes this CreateBookingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreateBookingRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateBookingRequest&&(identical(other.slotId, _this.slotId) || other.slotId == _this.slotId)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreateBookingRequest;
  return Object.hash(runtimeType,_this.slotId,_this.subjectId,_this.note);
}

@override
String toString() {
  final _this = this as CreateBookingRequest;
  return 'CreateBookingRequest(slotId: ${_this.slotId}, subjectId: ${_this.subjectId}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $CreateBookingRequestCopyWith<$Res>  {
  factory $CreateBookingRequestCopyWith(CreateBookingRequest value, $Res Function(CreateBookingRequest) _then) = _$CreateBookingRequestCopyWithImpl;
@useResult
$Res call({
 String slotId, String subjectId, String? note
});




}
/// @nodoc
class _$CreateBookingRequestCopyWithImpl<$Res>
    implements $CreateBookingRequestCopyWith<$Res> {
  _$CreateBookingRequestCopyWithImpl(this._self, this._then);

  final CreateBookingRequest _self;
  final $Res Function(CreateBookingRequest) _then;

/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotId = null,Object? subjectId = null,Object? note = freezed,}) {
  return _then(CreateBookingRequest(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateBookingRequest].
extension CreateBookingRequestPatterns on CreateBookingRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateBookingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateBookingRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateBookingRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateBookingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slotId,  String subjectId,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
return $default(_that.slotId,_that.subjectId,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slotId,  String subjectId,  String? note)  $default,) {final _that = this;
switch (_that) {
case _CreateBookingRequest():
return $default(_that.slotId,_that.subjectId,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slotId,  String subjectId,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _CreateBookingRequest() when $default != null:
return $default(_that.slotId,_that.subjectId,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateBookingRequest implements CreateBookingRequest {
  const _CreateBookingRequest({required this.slotId, required this.subjectId, this.note});
  factory _CreateBookingRequest.fromJson(Map<String, dynamic> json) => _$CreateBookingRequestFromJson(json);

@override final  String slotId;
@override final  String subjectId;
@override final  String? note;

/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateBookingRequestCopyWith<_CreateBookingRequest> get copyWith => __$CreateBookingRequestCopyWithImpl<_CreateBookingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateBookingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateBookingRequest&&(identical(other.slotId, slotId) || other.slotId == slotId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,slotId,subjectId,note);
}

@override
String toString() {
    return 'CreateBookingRequest(slotId: $slotId, subjectId: $subjectId, note: $note)';
}


}

/// @nodoc
abstract mixin class _$CreateBookingRequestCopyWith<$Res> implements $CreateBookingRequestCopyWith<$Res> {
  factory _$CreateBookingRequestCopyWith(_CreateBookingRequest value, $Res Function(_CreateBookingRequest) _then) = __$CreateBookingRequestCopyWithImpl;
@override @useResult
$Res call({
 String slotId, String subjectId, String? note
});




}
/// @nodoc
class __$CreateBookingRequestCopyWithImpl<$Res>
    implements _$CreateBookingRequestCopyWith<$Res> {
  __$CreateBookingRequestCopyWithImpl(this._self, this._then);

  final _CreateBookingRequest _self;
  final $Res Function(_CreateBookingRequest) _then;

/// Create a copy of CreateBookingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotId = null,Object? subjectId = null,Object? note = freezed,}) {
  return _then(_CreateBookingRequest(
slotId: null == slotId ? _self.slotId : slotId // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaginatedBookings {

 List<BookingDto> get items; String? get nextCursor;
/// Create a copy of PaginatedBookings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedBookingsCopyWith<PaginatedBookings> get copyWith => _$PaginatedBookingsCopyWithImpl<PaginatedBookings>(this as PaginatedBookings, _$identity);

  /// Serializes this PaginatedBookings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PaginatedBookings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedBookings&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PaginatedBookings;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.nextCursor);
}

@override
String toString() {
  final _this = this as PaginatedBookings;
  return 'PaginatedBookings(items: ${_this.items}, nextCursor: ${_this.nextCursor})';
}


}

/// @nodoc
abstract mixin class $PaginatedBookingsCopyWith<$Res>  {
  factory $PaginatedBookingsCopyWith(PaginatedBookings value, $Res Function(PaginatedBookings) _then) = _$PaginatedBookingsCopyWithImpl;
@useResult
$Res call({
 List<BookingDto> items, String? nextCursor
});




}
/// @nodoc
class _$PaginatedBookingsCopyWithImpl<$Res>
    implements $PaginatedBookingsCopyWith<$Res> {
  _$PaginatedBookingsCopyWithImpl(this._self, this._then);

  final PaginatedBookings _self;
  final $Res Function(PaginatedBookings) _then;

/// Create a copy of PaginatedBookings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(PaginatedBookings(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedBookings].
extension PaginatedBookingsPatterns on PaginatedBookings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedBookings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedBookings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedBookings value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedBookings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedBookings value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedBookings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BookingDto> items,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedBookings() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BookingDto> items,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _PaginatedBookings():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BookingDto> items,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedBookings() when $default != null:
return $default(_that.items,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedBookings implements PaginatedBookings {
  const _PaginatedBookings({required  List<BookingDto> items, this.nextCursor}): _items = items;
  factory _PaginatedBookings.fromJson(Map<String, dynamic> json) => _$PaginatedBookingsFromJson(json);

 final  List<BookingDto> _items;
@override List<BookingDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;

/// Create a copy of PaginatedBookings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedBookingsCopyWith<_PaginatedBookings> get copyWith => __$PaginatedBookingsCopyWithImpl<_PaginatedBookings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedBookingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedBookings&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextCursor);
}

@override
String toString() {
    return 'PaginatedBookings(items: $items, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$PaginatedBookingsCopyWith<$Res> implements $PaginatedBookingsCopyWith<$Res> {
  factory _$PaginatedBookingsCopyWith(_PaginatedBookings value, $Res Function(_PaginatedBookings) _then) = __$PaginatedBookingsCopyWithImpl;
@override @useResult
$Res call({
 List<BookingDto> items, String? nextCursor
});




}
/// @nodoc
class __$PaginatedBookingsCopyWithImpl<$Res>
    implements _$PaginatedBookingsCopyWith<$Res> {
  __$PaginatedBookingsCopyWithImpl(this._self, this._then);

  final _PaginatedBookings _self;
  final $Res Function(_PaginatedBookings) _then;

/// Create a copy of PaginatedBookings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextCursor = freezed,}) {
  return _then(_PaginatedBookings(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<BookingDto>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
