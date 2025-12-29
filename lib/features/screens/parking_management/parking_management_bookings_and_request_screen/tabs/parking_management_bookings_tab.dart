import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_bookings_tab_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_booked_seats_item_widget.dart';



class ParkingManagementBookingsTab extends StatefulWidget {
  const ParkingManagementBookingsTab({Key? key}) : super(key: key);

  @override
  State<ParkingManagementBookingsTab> createState() =>
      _ParkingManagementBookingsTabState();
}

class _ParkingManagementBookingsTabState
    extends State<ParkingManagementBookingsTab> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ParkingManagementBookingsTabProvider>(context,
                listen: false)
            .init(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingManagementBookingsTabProvider>(
      builder: (context, state, child) {
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.seatBookings.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: state.seatBookings.length,
                      itemBuilder: (context, index) {
                        final item = state.seatBookings[index];
                        return ParkingManagementBookedSeatsItemWidget(
                          item: item,
                          isFromList: true,
                          parentContext: context,
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text('No Data Available'),
                  );
      },
    );
  }
}
