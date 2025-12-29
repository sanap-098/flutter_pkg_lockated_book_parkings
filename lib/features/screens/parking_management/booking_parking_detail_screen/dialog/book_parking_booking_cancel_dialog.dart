import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:provider/provider.dart';


class BookParkingBookingCancelDialog extends StatefulWidget {
  final String bookingId;
  final BuildContext parentContext;

  const BookParkingBookingCancelDialog({
    Key? key,
    required this.bookingId,
    required this.parentContext,
  }) : super(key: key);

  @override
  State<BookParkingBookingCancelDialog> createState() =>
      _BookParkingBookingCancelDialogState();
}

class _BookParkingBookingCancelDialogState
    extends State<BookParkingBookingCancelDialog> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 3000)).then((value) {
        Navigator.pop(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Booking ID: #${widget.bookingId}',
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Your Booking has been Cancelled.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
