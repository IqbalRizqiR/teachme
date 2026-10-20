import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In id, this message translates to:
  /// **'teachMe'**
  String get appTitle;

  /// No description provided for @homeGreeting.
  ///
  /// In id, this message translates to:
  /// **'Yuk, mulai belajar!'**
  String get homeGreeting;

  /// No description provided for @searchHint.
  ///
  /// In id, this message translates to:
  /// **'Cari tentor atau mata pelajaran...'**
  String get searchHint;

  /// No description provided for @emptySearch.
  ///
  /// In id, this message translates to:
  /// **'Belum ada tentor yang cocok. Coba ubah filter ya!'**
  String get emptySearch;

  /// No description provided for @bookingSent.
  ///
  /// In id, this message translates to:
  /// **'Terkirim! Tunggu tentornya konfirmasi ya'**
  String get bookingSent;

  /// No description provided for @bookingAccepted.
  ///
  /// In id, this message translates to:
  /// **'Yay, diterima! Yuk bayar biar jadwalnya aman'**
  String get bookingAccepted;

  /// No description provided for @bookingPaid.
  ///
  /// In id, this message translates to:
  /// **'Beres! Sampai ketemu di sesi les'**
  String get bookingPaid;

  /// No description provided for @bookingCompleted.
  ///
  /// In id, this message translates to:
  /// **'Sesi kelar! Cek nilai & catatan barumu'**
  String get bookingCompleted;

  /// No description provided for @bookingRejected.
  ///
  /// In id, this message translates to:
  /// **'Yah, tentornya lagi nggak bisa. Cari jadwal lain yuk!'**
  String get bookingRejected;

  /// No description provided for @bookingExpired.
  ///
  /// In id, this message translates to:
  /// **'Waktunya habis. Cari jadwal lain yuk!'**
  String get bookingExpired;

  /// No description provided for @certificateReady.
  ///
  /// In id, this message translates to:
  /// **'Targetmu tercapai! Sertifikatmu siap diunduh'**
  String get certificateReady;

  /// No description provided for @gradePrompt.
  ///
  /// In id, this message translates to:
  /// **'Gimana progres muridmu hari ini?'**
  String get gradePrompt;

  /// No description provided for @scoreSaved.
  ///
  /// In id, this message translates to:
  /// **'Nilai tersimpan!'**
  String get scoreSaved;

  /// No description provided for @loginTitle.
  ///
  /// In id, this message translates to:
  /// **'Hey, selamat datang!'**
  String get loginTitle;

  /// No description provided for @loginButton.
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get loginButton;

  /// No description provided for @registerTitle.
  ///
  /// In id, this message translates to:
  /// **'Buat akun baru'**
  String get registerTitle;

  /// No description provided for @registerButton.
  ///
  /// In id, this message translates to:
  /// **'Buat Akun'**
  String get registerButton;

  /// No description provided for @noAccount.
  ///
  /// In id, this message translates to:
  /// **'Belum punya akun? Daftar'**
  String get noAccount;

  /// No description provided for @hasAccount.
  ///
  /// In id, this message translates to:
  /// **'Sudah punya akun? Masuk'**
  String get hasAccount;

  /// No description provided for @emailLabel.
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In id, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @nameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama lengkap'**
  String get nameLabel;

  /// No description provided for @emailError.
  ///
  /// In id, this message translates to:
  /// **'Emailnya kayaknya belum bener deh'**
  String get emailError;

  /// No description provided for @passwordError.
  ///
  /// In id, this message translates to:
  /// **'Minimal 8 karakter, harus ada huruf dan angka'**
  String get passwordError;

  /// No description provided for @nameError.
  ///
  /// In id, this message translates to:
  /// **'Nama wajib diisi'**
  String get nameError;

  /// No description provided for @roleStudent.
  ///
  /// In id, this message translates to:
  /// **'Murid'**
  String get roleStudent;

  /// No description provided for @roleTutor.
  ///
  /// In id, this message translates to:
  /// **'Tentor'**
  String get roleTutor;

  /// No description provided for @chooseRole.
  ///
  /// In id, this message translates to:
  /// **'Pilih peranmu'**
  String get chooseRole;

  /// No description provided for @home.
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get home;

  /// No description provided for @learning.
  ///
  /// In id, this message translates to:
  /// **'Belajar'**
  String get learning;

  /// No description provided for @profile.
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profile;

  /// No description provided for @dashboard.
  ///
  /// In id, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @schedule.
  ///
  /// In id, this message translates to:
  /// **'Jadwal'**
  String get schedule;

  /// No description provided for @bookings.
  ///
  /// In id, this message translates to:
  /// **'Booking'**
  String get bookings;

  /// No description provided for @statusPending.
  ///
  /// In id, this message translates to:
  /// **'Menunggu'**
  String get statusPending;

  /// No description provided for @statusAccepted.
  ///
  /// In id, this message translates to:
  /// **'Diterima'**
  String get statusAccepted;

  /// No description provided for @statusPaid.
  ///
  /// In id, this message translates to:
  /// **'Dibayar'**
  String get statusPaid;

  /// No description provided for @statusCompleted.
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get statusCompleted;

  /// No description provided for @statusRejected.
  ///
  /// In id, this message translates to:
  /// **'Ditolak'**
  String get statusRejected;

  /// No description provided for @statusCancelled.
  ///
  /// In id, this message translates to:
  /// **'Dibatalkan'**
  String get statusCancelled;

  /// No description provided for @statusExpired.
  ///
  /// In id, this message translates to:
  /// **'Kadaluarsa'**
  String get statusExpired;

  /// No description provided for @bookNow.
  ///
  /// In id, this message translates to:
  /// **'Pesan Sekarang'**
  String get bookNow;

  /// No description provided for @payNow.
  ///
  /// In id, this message translates to:
  /// **'Bayar Sekarang'**
  String get payNow;

  /// No description provided for @accept.
  ///
  /// In id, this message translates to:
  /// **'Terima'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In id, this message translates to:
  /// **'Tolak'**
  String get reject;

  /// No description provided for @cancel.
  ///
  /// In id, this message translates to:
  /// **'Batalkan'**
  String get cancel;

  /// No description provided for @retry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get retry;

  /// No description provided for @perHour.
  ///
  /// In id, this message translates to:
  /// **'/jam'**
  String get perHour;

  /// No description provided for @reviews.
  ///
  /// In id, this message translates to:
  /// **'Ulasan'**
  String get reviews;

  /// No description provided for @sessions.
  ///
  /// In id, this message translates to:
  /// **'sesi'**
  String get sessions;

  /// No description provided for @pickTime.
  ///
  /// In id, this message translates to:
  /// **'Pilih waktu'**
  String get pickTime;

  /// No description provided for @noSlots.
  ///
  /// In id, this message translates to:
  /// **'Belum ada jadwal tersedia'**
  String get noSlots;

  /// No description provided for @price.
  ///
  /// In id, this message translates to:
  /// **'Harga'**
  String get price;

  /// No description provided for @total.
  ///
  /// In id, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @sendRequest.
  ///
  /// In id, this message translates to:
  /// **'Kirim Permintaan'**
  String get sendRequest;

  /// No description provided for @simulatePayment.
  ///
  /// In id, this message translates to:
  /// **'Simulasi Pembayaran (dev)'**
  String get simulatePayment;

  /// No description provided for @findAnotherSlot.
  ///
  /// In id, this message translates to:
  /// **'Cari jadwal lain'**
  String get findAnotherSlot;

  /// No description provided for @myLearning.
  ///
  /// In id, this message translates to:
  /// **'Progres Belajar'**
  String get myLearning;

  /// No description provided for @scorePerSession.
  ///
  /// In id, this message translates to:
  /// **'Nilai per sesi'**
  String get scorePerSession;

  /// No description provided for @target.
  ///
  /// In id, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @certificate.
  ///
  /// In id, this message translates to:
  /// **'Sertifikat'**
  String get certificate;

  /// No description provided for @download.
  ///
  /// In id, this message translates to:
  /// **'Unduh'**
  String get download;

  /// No description provided for @rateTutor.
  ///
  /// In id, this message translates to:
  /// **'Nilai Tentor'**
  String get rateTutor;

  /// No description provided for @thisWeek.
  ///
  /// In id, this message translates to:
  /// **'Minggu ini'**
  String get thisWeek;

  /// No description provided for @earned.
  ///
  /// In id, this message translates to:
  /// **'Pendapatan'**
  String get earned;

  /// No description provided for @newRequests.
  ///
  /// In id, this message translates to:
  /// **'permintaan baru'**
  String get newRequests;

  /// No description provided for @incomingRequests.
  ///
  /// In id, this message translates to:
  /// **'Permintaan Masuk'**
  String get incomingRequests;

  /// No description provided for @upcomingSessions.
  ///
  /// In id, this message translates to:
  /// **'Sesi Mendatang'**
  String get upcomingSessions;

  /// No description provided for @needsGrading.
  ///
  /// In id, this message translates to:
  /// **'Perlu Dinilai'**
  String get needsGrading;

  /// No description provided for @gradeSession.
  ///
  /// In id, this message translates to:
  /// **'Nilai Sesi'**
  String get gradeSession;

  /// No description provided for @score.
  ///
  /// In id, this message translates to:
  /// **'Nilai'**
  String get score;

  /// No description provided for @notes.
  ///
  /// In id, this message translates to:
  /// **'Catatan'**
  String get notes;

  /// No description provided for @saveAndFinish.
  ///
  /// In id, this message translates to:
  /// **'Simpan & Selesaikan'**
  String get saveAndFinish;

  /// No description provided for @mySchedule.
  ///
  /// In id, this message translates to:
  /// **'Jadwal Saya'**
  String get mySchedule;

  /// No description provided for @weekly.
  ///
  /// In id, this message translates to:
  /// **'Mingguan'**
  String get weekly;

  /// No description provided for @exceptions.
  ///
  /// In id, this message translates to:
  /// **'Pengecualian'**
  String get exceptions;

  /// No description provided for @addRule.
  ///
  /// In id, this message translates to:
  /// **'Tambah Jadwal'**
  String get addRule;

  /// No description provided for @editRule.
  ///
  /// In id, this message translates to:
  /// **'Edit Jadwal'**
  String get editRule;

  /// No description provided for @deleteRule.
  ///
  /// In id, this message translates to:
  /// **'Hapus Jadwal'**
  String get deleteRule;

  /// No description provided for @confirmDelete.
  ///
  /// In id, this message translates to:
  /// **'Yakin mau hapus? Slot yang sudah dipesan tetap aman.'**
  String get confirmDelete;

  /// No description provided for @errorGeneric.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan. Coba lagi ya!'**
  String get errorGeneric;

  /// No description provided for @errorNoConnection.
  ///
  /// In id, this message translates to:
  /// **'Tidak bisa terhubung ke server'**
  String get errorNoConnection;

  /// No description provided for @logOut.
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logOut;

  /// No description provided for @darkMode.
  ///
  /// In id, this message translates to:
  /// **'Mode Gelap'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In id, this message translates to:
  /// **'Mode Terang'**
  String get lightMode;

  /// No description provided for @systemMode.
  ///
  /// In id, this message translates to:
  /// **'Ikuti Sistem'**
  String get systemMode;

  /// No description provided for @earnings.
  ///
  /// In id, this message translates to:
  /// **'Pendapatan'**
  String get earnings;

  /// No description provided for @gross.
  ///
  /// In id, this message translates to:
  /// **'Kotor'**
  String get gross;

  /// No description provided for @platformFee.
  ///
  /// In id, this message translates to:
  /// **'Biaya Platform'**
  String get platformFee;

  /// No description provided for @net.
  ///
  /// In id, this message translates to:
  /// **'Bersih'**
  String get net;

  /// No description provided for @about.
  ///
  /// In id, this message translates to:
  /// **'Tentang'**
  String get about;

  /// No description provided for @verified.
  ///
  /// In id, this message translates to:
  /// **'Terverifikasi'**
  String get verified;

  /// No description provided for @subject.
  ///
  /// In id, this message translates to:
  /// **'Mata Pelajaran'**
  String get subject;

  /// No description provided for @notifications.
  ///
  /// In id, this message translates to:
  /// **'Notifikasi'**
  String get notifications;

  /// No description provided for @markAllRead.
  ///
  /// In id, this message translates to:
  /// **'Tandai semua dibaca'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In id, this message translates to:
  /// **'Belum ada notifikasi'**
  String get noNotifications;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
