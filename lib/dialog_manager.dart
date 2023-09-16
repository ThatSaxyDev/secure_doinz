import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secure_doinz/main.dart';

// class GlobalDialogManager {
//   static OverlayState? overlayState;

//   static void initOverlay(BuildContext context) {
//     overlayState = Overlay.of(context);
//   }

//   static void showCustomDialog(Widget dialog) {
//     if (overlayState != null) {
//       OverlayEntry overlayEntry = OverlayEntry(
//         builder: (BuildContext context) {
//           return Center(
//             child: Material(
//               color: Colors.transparent,
//               child: dialog,
//             ),
//           );
//         },
//       );

//       overlayState!.insert(overlayEntry);
//     }
//   }

//   // static void hideCustomDialog() {
//   //   // Remove the topmost overlay entry, effectively hiding the dialog.
//   //   if (overlayState != null && overlayState!.mounted) {
//   //     overlayState!.removeLast();
//   //   }
//   // }
// }

StateNotifierProvider<AppSessionService, int> appSessionServiceProvider =
    StateNotifierProvider((ref) {
  return AppSessionService(ref: ref);
});

class AppSessionService extends StateNotifier<int> {
  final Ref _ref;
  AppSessionService({required Ref ref})
      : _ref = ref,
        super(0);

  Timer? _timer;

  void countTime() {
    state = 0;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _timer = timer;
        state++;
        print("Session time in seconds: $state");
        switch (state) {
          //! actual value: 720
          case 5:
            print('SESSION DIALOGUE ACTIVATED!!!!!!!');
            //! SHOW DIALOGUE
            try {
              showDialog(
                  context: navigatorKey.currentContext!,
                  builder: (context) => Center(
                        child: Material(
                          color: Colors.transparent,
                          child: AlertDialog(
                            title: const Text('Custom Dialog'),
                            content: const Text('This is a custom dialog.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ));
              // GlobalDialogManager.showCustomDialog(
              //   AlertDialog(
              //     title: const Text('Custom Dialog'),
              //     content: const Text('This is a custom dialog.'),
              //     actions: <Widget>[
              //       TextButton(
              //         child: const Text('Close'),
              //         onPressed: () {},
              //       ),
              //     ],
              //   ),
              // );
              // showGeneralDialog(
              //     context: context,
              //     barrierDismissible: true,
              //     barrierLabel: "Go Home",
              //     barrierColor: Colors.black.withOpacity(0.2),
              //     transitionBuilder: (context, a1, a2, widget) =>
              //         const SessionTimeoutDialogue(),
              //     transitionDuration: const Duration(milliseconds: 200),
              //     pageBuilder: (context, animation1, animation2) =>
              //         const Text(""));
            } catch (e) {
              print(e.toString());
            }

            break;

          //! actual value: 900
          case 10:
            // _ref.read(authControllerProvider.notifier).logout(context: context);
            print('LOGGED OUT BY DEFAULT!!!!!!!');
            timer.cancel();
            state = 0;
            break;
          default:
            () {};
        }
      },
    );
  }

  //! set counter to zero and cancel the timer
  void resetTime() {
    _timer!.cancel();
    state = 0;
  }

  //! set counter to zero
  void resetTimerState() {
    state = 0;
  }
}
