import 'package:flutter/material.dart';

List<String> listOfWeekDaysSymbol = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

List<String> listOfMonthsSymbol = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

enum DatePickerSelectionMode {
  /// - DateRangePickerSelectionMode.single, Allows to select a single date,
  /// selecting a new date will remove the selection for previous date and
  /// updates selection to the new selected date.
  disable,

  /// - DateRangePickerSelectionMode.single, Allows to select a single date,
  /// selecting a new date will remove the selection for previous date and
  /// updates selection to the new selected date.
  single,

  /// - DateRangePickerSelection.multiple, Allows multiple date selection,
  /// selecting a new date will not remove the selection for previous dates,
  /// allows to select as many dates as possible.
  multiple,

  /// - DateRangePickerSelection.range, Allows to select a single range of
  /// dates.
  range,

  /// - DateRangePickerSelection.multiRange, Allows to select a multiple ranges
  /// of dates.
  multiRange,
}

class DecorationProperties {
  final Color? datesBackgroundColor;
  final Color? datesTextColor;
  final TextStyle? datesTextStyle;
  final Color? datesBorderColor;
  final double? datesBorderRadius;

  DecorationProperties({
    this.datesBackgroundColor,
    this.datesTextColor,
    this.datesTextStyle,
    this.datesBorderColor,
    this.datesBorderRadius,
  });

  // Implement toString to make it easier to see information
  // when using the print statement.
  @override
  String toString() {
    return 'DatesProperties{datesBackgroundColor: $datesBackgroundColor, datesTextColor: $datesTextColor, datesTextStyle: $datesTextStyle, datesBorderColor: $datesBorderColor, datesBorderRadius: $datesBorderRadius}';
  }
}

class DatesProperties {
  final DecorationProperties? decorationProperties;
  final bool? disable;

  DatesProperties({
    this.decorationProperties,
    this.disable,
  });

  // Implement toString to make it easier to see information
  // when using the print statement.
  @override
  String toString() {
    return 'DatesProperties{decorationProperties: $decorationProperties, disable: $disable}';
  }
}

class CalendarPropertiesState extends ChangeNotifier {
  late DatesProperties _streakDatesProperties;
  DatesProperties get streakDatesProperties => _streakDatesProperties;

  late DatesProperties _currentDateProperties;
  DatesProperties get currentDateProperties => _currentDateProperties;

  late DatesProperties _generalDatesProperties;
  DatesProperties get generalDatesProperties => _generalDatesProperties;

  late DatesProperties _leadingTrailingDatesProperties;
  DatesProperties get leadingTrailingDatesProperties =>
      _leadingTrailingDatesProperties;

  late DatesProperties _selectedDatesProperties;
  DatesProperties get selectedDatesProperties => _selectedDatesProperties;

  late DatesProperties _selectedRangeBetweenDatesProperties;
  DatesProperties get selectedRangeBetweenDatesProperties =>
      _selectedRangeBetweenDatesProperties;

  late bool _enableDenseViewForDates;
  bool get enableDenseViewForDates => _enableDenseViewForDates;

  late bool _enableDenseSplashForDates;
  bool get enableDenseSplashForDates => _enableDenseSplashForDates;

  late DateTime? _startDateOfCalendar;
  DateTime get startDateOfCalendar =>
      _startDateOfCalendar ?? DateTime.utc(0000, 1, 1);

  late DateTime? _endDateOfCalendar;
  DateTime get endDateOfCalendar =>
      _endDateOfCalendar ?? DateTime.utc(9999, 1, 1);

  late DatePickerSelectionMode _dateSelectionMode;
  DatePickerSelectionMode get dateSelectionMode => _dateSelectionMode;

  late bool _disablePastDates;
  bool get disablePastDates => _disablePastDates;

  late DateTime _initialViewMonthDateTime;
  DateTime get initialViewMonthDateTime => _initialViewMonthDateTime;

  late DateTime _currentDateOfCalendar;
  DateTime get currentDateOfCalendar => _currentDateOfCalendar;

  late List<DateTime> _datesForStreaks;
  List<DateTime> get datesForStreaks => _datesForStreaks;

  initializeProperties({
    required DatesProperties? streakDatesProperties,
    required DatesProperties? currentDateProperties,
    required DatesProperties? generalDatesProperties,
    required DatesProperties? leadingTrailingDatesProperties,
    required DatesProperties? selectedDatesProperties,
    required DatesProperties? selectedRangeBetweenDatesProperties,
    required bool? enableDenseViewForDates,
    required bool? enableDenseSplashForDates,
    required DateTime? startDateOfCalendar,
    required DateTime? endDateOfCalendar,
    required DatePickerSelectionMode? dateSelectionMode,
    required bool? disablePastDates,
    required DateTime? initialViewMonthDateTime,
    required DateTime? currentDateOfCalendar,
    required List<DateTime>? datesForStreaks,
    required BuildContext context,
  }) {
    final ThemeData theme = Theme.of(context);

    _streakDatesProperties = DatesProperties(
        decorationProperties: DecorationProperties(
            datesBackgroundColor: streakDatesProperties
                    ?.decorationProperties?.datesBackgroundColor ??
                theme.colorScheme.surfaceVariant,
            datesTextColor:
                streakDatesProperties?.decorationProperties?.datesTextColor ??
                    theme.colorScheme.onSurfaceVariant,
            datesTextStyle:
                streakDatesProperties?.decorationProperties?.datesTextStyle ??
                    const TextStyle(),
            datesBorderColor:
                streakDatesProperties?.decorationProperties?.datesBorderColor ??
                    theme.colorScheme.onSurface,
            datesBorderRadius: streakDatesProperties
                    ?.decorationProperties?.datesBorderRadius ??
                12),
        disable: streakDatesProperties?.disable ?? false);

    _currentDateProperties = DatesProperties(
        decorationProperties: DecorationProperties(
            datesBackgroundColor: currentDateProperties
                ?.decorationProperties?.datesBackgroundColor,
            datesTextColor:
                currentDateProperties?.decorationProperties?.datesTextColor,
            datesTextStyle:
                currentDateProperties?.decorationProperties?.datesTextStyle,
            datesBorderColor:
                currentDateProperties?.decorationProperties?.datesBorderColor ??
                    theme.colorScheme.primary,
            datesBorderRadius: currentDateProperties
                    ?.decorationProperties?.datesBorderRadius ??
                12),
        disable: currentDateProperties?.disable ?? false);

    _generalDatesProperties = DatesProperties(
        decorationProperties: DecorationProperties(
            datesBackgroundColor: generalDatesProperties
                    ?.decorationProperties?.datesBackgroundColor ??
                Colors.transparent,
            datesTextColor:
                generalDatesProperties?.decorationProperties?.datesTextColor ??
                    theme.colorScheme.onSurface,
            datesTextStyle:
                generalDatesProperties?.decorationProperties?.datesTextStyle ??
                    const TextStyle(),
            datesBorderColor: generalDatesProperties
                    ?.decorationProperties?.datesBorderColor ??
                theme.colorScheme.onSurface.withOpacity(0.5),
            datesBorderRadius: generalDatesProperties
                    ?.decorationProperties?.datesBorderRadius ??
                12),
        disable: generalDatesProperties?.disable ?? false);

    _leadingTrailingDatesProperties = DatesProperties(
        decorationProperties: DecorationProperties(
            datesBackgroundColor: leadingTrailingDatesProperties
                    ?.decorationProperties?.datesBackgroundColor ??
                theme.colorScheme.surface,
            datesTextColor: leadingTrailingDatesProperties
                    ?.decorationProperties?.datesTextColor ??
                theme.disabledColor,
            datesTextStyle: leadingTrailingDatesProperties
                    ?.decorationProperties?.datesTextStyle ??
                const TextStyle(),
            datesBorderColor: leadingTrailingDatesProperties
                    ?.decorationProperties?.datesBorderColor ??
                theme.dividerColor,
            datesBorderRadius: leadingTrailingDatesProperties
                    ?.decorationProperties?.datesBorderRadius ??
                12),
        disable: leadingTrailingDatesProperties?.disable ?? false);

    _selectedDatesProperties = DatesProperties(
        decorationProperties: DecorationProperties(
            datesBackgroundColor: selectedDatesProperties
                    ?.decorationProperties?.datesBackgroundColor ??
                theme.colorScheme.primary,
            datesTextColor:
                selectedDatesProperties?.decorationProperties?.datesTextColor ??
                    theme.colorScheme.primary,
            datesTextStyle:
                selectedDatesProperties?.decorationProperties?.datesTextStyle ??
                    const TextStyle(),
            datesBorderColor: selectedDatesProperties
                    ?.decorationProperties?.datesBorderColor ??
                theme.colorScheme.primary,
            datesBorderRadius: selectedDatesProperties
                    ?.decorationProperties?.datesBorderRadius ??
                12),
        disable: selectedDatesProperties?.disable ?? false);

    _selectedRangeBetweenDatesProperties = DatesProperties(
        decorationProperties: DecorationProperties(
            datesBackgroundColor: selectedRangeBetweenDatesProperties
                    ?.decorationProperties?.datesBackgroundColor ??
                theme.colorScheme.surfaceVariant,
            datesTextColor: selectedRangeBetweenDatesProperties
                    ?.decorationProperties?.datesTextColor ??
                theme.colorScheme.onSurfaceVariant,
            datesTextStyle: selectedRangeBetweenDatesProperties
                    ?.decorationProperties?.datesTextStyle ??
                const TextStyle(),
            datesBorderColor: selectedRangeBetweenDatesProperties
                    ?.decorationProperties?.datesBorderColor ??
                Colors.transparent,
            datesBorderRadius: selectedRangeBetweenDatesProperties
                    ?.decorationProperties?.datesBorderRadius ??
                12),
        disable: selectedDatesProperties?.disable ?? false);

    _enableDenseViewForDates = enableDenseViewForDates ?? false;
    _enableDenseSplashForDates = enableDenseSplashForDates ?? false;
    _startDateOfCalendar = startDateOfCalendar;
    _endDateOfCalendar = endDateOfCalendar;
    _dateSelectionMode = dateSelectionMode ?? DatePickerSelectionMode.disable;
    _disablePastDates = disablePastDates ?? false;
    _initialViewMonthDateTime = initialViewMonthDateTime ??
        (currentDateOfCalendar != null
            ? DateTime.utc(
                currentDateOfCalendar.year, currentDateOfCalendar.month, 1)
            : DateTime.utc(DateTime.now().year, DateTime.now().month, 1));
    _currentDateOfCalendar = currentDateOfCalendar ?? DateTime.now();
    _datesForStreaks = datesForStreaks != null
        ? List.generate(
            datesForStreaks.length,
            (index) => DateTime.utc(datesForStreaks[index].year,
                datesForStreaks[index].month, datesForStreaks[index].day))
        : [];
  }
}