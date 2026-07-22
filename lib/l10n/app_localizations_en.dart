// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FUDO Challenge';

  @override
  String get searchHint => 'Search stocks...';

  @override
  String get searchEmptyPrompt => 'Try searching something';

  @override
  String get emptyResults => 'No results found';

  @override
  String get detailsOpen => 'Open';

  @override
  String get detailsHigh => 'High';

  @override
  String get detailsLow => 'Low';

  @override
  String get detailsAbout => 'About';

  @override
  String get detailsSector => 'Sector';

  @override
  String get detailsIndustry => 'Industry';

  @override
  String get detailsMarketCap => 'Market Cap';

  @override
  String get detailsPeRatio => 'PE Ratio';

  @override
  String get detailsDividendYield => 'Dividend Yield';

  @override
  String get detailsEps => 'EPS';

  @override
  String get retry => 'Retry';
}
