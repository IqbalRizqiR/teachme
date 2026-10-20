// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'teachMe';

  @override
  String get homeGreeting => 'Let\'s start learning!';

  @override
  String get searchHint => 'Search tutors or subjects...';

  @override
  String get emptySearch => 'No tutors match yet. Try changing filters!';

  @override
  String get bookingSent => 'Sent! Waiting for tutor to confirm';

  @override
  String get bookingAccepted => 'Accepted! Pay now to lock your slot';

  @override
  String get bookingPaid => 'Done! See you at the session';

  @override
  String get bookingCompleted => 'Session done! Check your new score';

  @override
  String get bookingRejected => 'Tutor can\'t make it. Find another slot!';

  @override
  String get bookingExpired => 'Time\'s up. Find another slot!';

  @override
  String get certificateReady =>
      'Target reached! Certificate ready to download';

  @override
  String get gradePrompt => 'How did your student do today?';

  @override
  String get scoreSaved => 'Score saved!';

  @override
  String get loginTitle => 'Hey, welcome back!';

  @override
  String get loginButton => 'Log In';

  @override
  String get registerTitle => 'Create a new account';

  @override
  String get registerButton => 'Create Account';

  @override
  String get noAccount => 'Don\'t have an account? Sign up';

  @override
  String get hasAccount => 'Already have an account? Log in';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get nameLabel => 'Full name';

  @override
  String get emailError => 'That email doesn\'t look right';

  @override
  String get passwordError => 'At least 8 characters with a letter and number';

  @override
  String get nameError => 'Name is required';

  @override
  String get roleStudent => 'Student';

  @override
  String get roleTutor => 'Tutor';

  @override
  String get chooseRole => 'Choose your role';

  @override
  String get home => 'Home';

  @override
  String get learning => 'Learning';

  @override
  String get profile => 'Profile';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get schedule => 'Schedule';

  @override
  String get bookings => 'Bookings';

  @override
  String get statusPending => 'Waiting';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusCompleted => 'Done';

  @override
  String get statusRejected => 'Declined';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusExpired => 'Expired';

  @override
  String get bookNow => 'Book Now';

  @override
  String get payNow => 'Pay Now';

  @override
  String get accept => 'Accept';

  @override
  String get reject => 'Decline';

  @override
  String get cancel => 'Cancel';

  @override
  String get retry => 'Try Again';

  @override
  String get perHour => '/hr';

  @override
  String get reviews => 'Reviews';

  @override
  String get sessions => 'sessions';

  @override
  String get pickTime => 'Pick a time';

  @override
  String get noSlots => 'No slots available yet';

  @override
  String get price => 'Price';

  @override
  String get total => 'Total';

  @override
  String get sendRequest => 'Send Request';

  @override
  String get simulatePayment => 'Simulate Payment (dev)';

  @override
  String get findAnotherSlot => 'Find another slot';

  @override
  String get myLearning => 'My Learning';

  @override
  String get scorePerSession => 'Score per session';

  @override
  String get target => 'Target';

  @override
  String get certificate => 'Certificate';

  @override
  String get download => 'Download';

  @override
  String get rateTutor => 'Rate Tutor';

  @override
  String get thisWeek => 'This week';

  @override
  String get earned => 'Earned';

  @override
  String get newRequests => 'new requests';

  @override
  String get incomingRequests => 'Incoming Requests';

  @override
  String get upcomingSessions => 'Upcoming Sessions';

  @override
  String get needsGrading => 'Needs Grading';

  @override
  String get gradeSession => 'Grade Session';

  @override
  String get score => 'Score';

  @override
  String get notes => 'Notes';

  @override
  String get saveAndFinish => 'Save & Finish';

  @override
  String get mySchedule => 'My Schedule';

  @override
  String get weekly => 'Weekly';

  @override
  String get exceptions => 'Exceptions';

  @override
  String get addRule => 'Add Schedule';

  @override
  String get editRule => 'Edit Schedule';

  @override
  String get deleteRule => 'Delete Schedule';

  @override
  String get confirmDelete => 'Are you sure? Booked slots will stay.';

  @override
  String get errorGeneric => 'Something went wrong. Try again!';

  @override
  String get errorNoConnection => 'Can\'t reach the server';

  @override
  String get logOut => 'Log Out';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemMode => 'Follow System';

  @override
  String get earnings => 'Earnings';

  @override
  String get gross => 'Gross';

  @override
  String get platformFee => 'Platform Fee';

  @override
  String get net => 'Net';

  @override
  String get about => 'About';

  @override
  String get verified => 'Verified';

  @override
  String get subject => 'Subject';

  @override
  String get notifications => 'Notifications';

  @override
  String get markAllRead => 'Mark all as read';

  @override
  String get noNotifications => 'No notifications yet';
}
