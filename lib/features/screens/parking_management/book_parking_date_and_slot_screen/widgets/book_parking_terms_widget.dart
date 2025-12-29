import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/book_parking_date_and_slot_provider.dart';



class BookParkingTermsWidget extends StatelessWidget {
  const BookParkingTermsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value:
              Provider.of<BookParkingDateAndSlotProvider>(context, listen: true)
                  .isTermsChecked,
          onChanged: (value) {
            if (value == null) {
              return;
            }
            Provider.of<BookParkingDateAndSlotProvider>(context, listen: false)
                .onTermsCheckedChanged(value);
          },
        ),
        const Text('I agree to '),
        InkWell(
          onTap: () {
            //TODO Open Terms & Conditions
          },
          child: const Text(
            'Terms & Conditions',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
