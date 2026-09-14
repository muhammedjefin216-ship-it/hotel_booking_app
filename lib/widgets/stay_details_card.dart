import 'package:flutter/material.dart';

import '../domain/booking_service.dart';
import 'date_selector_field.dart';
import 'guest_filter_row.dart';
import 'validation_banner.dart';

class StayDetailsCard extends StatelessWidget {
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? guestFilter;

  final ValueChanged<DateTime> onCheckInSelected;
  final ValueChanged<DateTime> onCheckOutSelected;
  final ValueChanged<int?> onGuestFilterChanged;

  final DateValidationResult dateValidation;

  const StayDetailsCard({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.guestFilter,
    required this.onCheckInSelected,
    required this.onCheckOutSelected,
    required this.onGuestFilterChanged,
    required this.dateValidation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE4E8EE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardHeader(
            icon: Icons.calendar_month_outlined,
            title: 'Stay details',
            subtitle: 'Select your dates and number of guests',
          ),

          const SizedBox(height: 18),

          const Text(
            'Dates',
            style: TextStyle(
              color: Color(0xFF293346),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: DateSelectorField(
                  label: 'Check-in',
                  selectedDate: checkIn,
                  firstSelectableDate:
                      BookingCalculator.dateOnly(DateTime.now()),
                  onDateSelected: onCheckInSelected,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DateSelectorField(
                  label: 'Check-out',
                  selectedDate: checkOut,
                  firstSelectableDate: checkIn != null
                      ? checkIn!.add(const Duration(days: 1))
                      : BookingCalculator.dateOnly(DateTime.now())
                          .add(const Duration(days: 1)),
                  onDateSelected: onCheckOutSelected,
                ),
              ),
            ],
          ),

          if (!dateValidation.isValid &&
              (checkIn != null || checkOut != null)) ...[
            const SizedBox(height: 12),
            ValidationBanner(
              message: dateValidation.message!,
            ),
          ],

          const SizedBox(height: 20),

          const Text(
            'Guests',
            style: TextStyle(
              color: Color(0xFF293346),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          GuestFilterRow(
            selected: guestFilter,
            onChanged: onGuestFilterChanged,
          ),
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CardHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF173B65).withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF173B65),
            size: 21,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF172033),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF8A93A1),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}