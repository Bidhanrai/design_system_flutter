import 'package:flutter/material.dart';

import '../core/theme/app_tokens.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({
    super.key,
    this.initialMonth,
    this.selected,
    this.onSelect,
    this.accent,
  });

  final DateTime? initialMonth;
  final DateTime? selected;
  final ValueChanged<DateTime>? onSelect;
  final Color? accent;

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  static const _dow = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  late DateTime _month;
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    final now = widget.initialMonth ?? DateTime.now();
    _month = DateTime(now.year, now.month);
    _selected = widget.selected;
  }

  void _shift(int delta) =>
      setState(() => _month = DateTime(_month.year, _month.month + delta));

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final accent = widget.accent ?? t.primary;

    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final leading = DateTime(_month.year, _month.month, 1).weekday % 7;

    final cells = <Widget>[
      for (var i = 0; i < leading; i++) const SizedBox.shrink(),
      for (var d = 1; d <= daysInMonth; d++) _day(t, accent, d),
    ];
    while (cells.length % 7 != 0) {
      cells.add(const SizedBox.shrink());
    }

    final weeks = <Widget>[];
    for (var i = 0; i < cells.length; i += 7) {
      weeks.add(Row(
        children: [
          for (final c in cells.sublist(i, i + 7)) Expanded(child: c),
        ],
      ));
    }

    return Container(
      width: 300,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: t.surface,
        border: Border.all(color: t.border),
        borderRadius: BorderRadius.circular(t.radiusLg),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navIcon(t, Icons.chevron_left, () => _shift(-1)),
              Text('${_months[_month.month - 1]} ${_month.year}',
                  style: TextStyle(fontWeight: FontWeight.w600, color: t.text)),
              _navIcon(t, Icons.chevron_right, () => _shift(1)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final d in _dow)
                Expanded(
                  child: Center(
                    child: Text(d,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: t.faint)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          ...weeks,
        ],
      ),
    );
  }

  Widget _navIcon(AppTokens t, IconData icon, VoidCallback onTap) => IconButton(
        onPressed: onTap,
        icon: Icon(icon, size: 20, color: t.muted),
        splashRadius: 18,
      );

  Widget _day(AppTokens t, Color accent, int day) {
    final date = DateTime(_month.year, _month.month, day);
    final selected = _selected != null &&
        _selected!.year == date.year &&
        _selected!.month == date.month &&
        _selected!.day == date.day;

    return InkWell(
      borderRadius: BorderRadius.circular(t.radiusSm),
      onTap: () {
        setState(() => _selected = date);
        widget.onSelect?.call(date);
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? accent : Colors.transparent,
          borderRadius: BorderRadius.circular(t.radiusSm),
        ),
        child: Center(
          child: Text(
            '$day',
            style: TextStyle(
              fontSize: 13,
              color: selected ? t.onPrimary : t.text,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
