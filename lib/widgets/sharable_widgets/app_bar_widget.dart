import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPrefixIconClick;
  final IconData? prefixIconData;
  final String? appBarHeader;
  final VoidCallback? onSuffixIconClick; 
  final IconData? suffixIconData; 

  const AppBarWidget({
    super.key,
    this.onPrefixIconClick,
    this.prefixIconData,
    this.appBarHeader,
    this.onSuffixIconClick,
    this.suffixIconData,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
    
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actionsPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      title: Text(
        appBarHeader ?? "Shop",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Colors.black, 
          letterSpacing: 1.2, 
        ),
      ),
      leading: prefixIconData != null
          ? IconButton(
              onPressed: onPrefixIconClick,
              icon: Icon(prefixIconData, color: Colors.black), 
            )
          : null,
      actions: [
        ?suffixIconData != null ?
          IconButton(
            onPressed: onSuffixIconClick,
            icon: Icon(suffixIconData, color: Colors.black), 
          ) : null
      ],
    );
  }
  
 @override
  // ADD THIS GETTER
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // kToolbarHeight is the standard AppBar height (56.0)
}