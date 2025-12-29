import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../../core/themes/theme_view_model.dart';

class BookSpaceThanYouDialog extends StatefulWidget {
  final String bookingId;
  final BuildContext parentContext;
  final bool isFromParking;

  const BookSpaceThanYouDialog({
    Key? key,
    required this.bookingId,
    required this.parentContext,
    this.isFromParking = false,
  }) : super(key: key);

  @override
  State<BookSpaceThanYouDialog> createState() => _BookSpaceThanYouDialogState();
}

class _BookSpaceThanYouDialogState extends State<BookSpaceThanYouDialog> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 3000)).then((value) {
        Navigator.pop(context);
        if (widget.isFromParking) {
          Navigator.popAndPushNamed(widget.parentContext,
                'parking_management_bookings_and_request_screen');
          // Navigator.popAndPushNamed(widget.parentContext,
          //     Routes.parkingManagementBookingsAndRequestScreen);
        } else {
          Navigator.popAndPushNamed(widget.parentContext,
                'space_management_bookings_and_request_screen');

          // Navigator.popAndPushNamed(widget.parentContext,
          //     Routes.spaceManagementBookingsAndRequestScreen);
        }
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
              'Thank you for Booking!',
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
