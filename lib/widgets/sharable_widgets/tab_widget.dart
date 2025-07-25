import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for HapticFeedback

class TabWidget extends StatelessWidget {
  final String tabCta;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback tabClick;

  const TabWidget({
    super.key,
    required this.tabCta,
    this.prefixIcon,
    this.suffixIcon,
    required this.tabClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // The onTap callback is where you'll trigger the haptic feedback
      onTap: () {
        HapticFeedback.lightImpact(); // This will trigger a light haptic vibration
        tabClick(); // Call the provided tabClick callback
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(prefixIcon),
                    )
                  : const SizedBox.shrink(),
              Text(tabCta, style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),),
              suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(suffixIcon),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}