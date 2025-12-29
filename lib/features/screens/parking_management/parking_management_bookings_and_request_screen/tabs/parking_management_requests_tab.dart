import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_requests_tab_provider.dart';

import 'package:flutter_pkg_lockated_book_parking/features/screens/parking_management/parking_management_screen/widgets/parking_management_seat_approval_request_widget.dart';

class ParkingManagementRequestsTab extends StatefulWidget {
  const ParkingManagementRequestsTab({Key? key}) : super(key: key);

  @override
  State<ParkingManagementRequestsTab> createState() =>
      _SpaceManagementBookingsTabState();
}

class _SpaceManagementBookingsTabState
    extends State<ParkingManagementRequestsTab> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ParkingManagementRequestsTabProvider>(context,
                listen: false)
            .init(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingManagementRequestsTabProvider>(
      builder: (context, state, child) {
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.seatApprovalRequests.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: state.seatApprovalRequests.length,
                      itemBuilder: (context, index) {
                        final item = state.seatApprovalRequests[index];
                        return ParkingManagementSeatApprovalRequestWidget(
                          item: item,
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
