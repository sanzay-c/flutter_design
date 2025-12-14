import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/core/constants/app_color.dart';

/// Simple Recipe App AppBar Widget
class RecipeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? customTitleWidget;
  final Color? backgroundColor;
  final double appbarHeight;
  final double elevation;
  
  // Leading
  final Widget? customLeadingWidget;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  
  // Title
  final bool isCenterTitle;
  final Color? titleColor;
  final double? titleFontSize;
  
  // Actions
  final List<Widget> actions;
  final bool showNotification;
  final bool showProfileIcon;
  final bool showSearch;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSearchTap;
  final int? notificationCount;
  
  // User info
  final String? userName;
  
  const RecipeAppBar({
    super.key,
    this.title,
    this.customTitleWidget,
    this.backgroundColor,
    this.appbarHeight = 56,
    this.elevation = 2,
    
    // Leading
    this.customLeadingWidget,
    this.showBackButton = true,
    this.onBackButtonPressed,
    
    // Title
    this.isCenterTitle = true,
    this.titleColor,
    this.titleFontSize,
    
    // Actions
    this.actions = const <Widget>[],
    this.showNotification = false,
    this.showProfileIcon = false,
    this.showSearch = false,
    this.onNotificationTap,
    this.onProfileTap,
    this.onSearchTap,
    this.notificationCount,
    
    // User
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? getColorByTheme(context: context, colorClass: AppColors.backgroundColor),
      elevation: elevation,
      automaticallyImplyLeading: showBackButton,
      
      // Leading widget
      leading: customLeadingWidget,

      surfaceTintColor: Colors.transparent,
      
      // Title
      title: customTitleWidget ?? Text(
        title ?? '',
        style: TextStyle(
          color: titleColor ?? getColorByTheme(context: context, colorClass: AppColors.textColor),
          fontSize: titleFontSize ?? 28.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: isCenterTitle,
      
      // Actions
      actions: _buildActions(context),
      
      // System UI
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark 
            ? Brightness.light 
            : Brightness.dark,
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final List<Widget> actionWidgets = [];
    
    // Custom actions
    if (actions.isNotEmpty) {
      actionWidgets.addAll(actions);
    }
    
    // Search icon
    if (showSearch) {
      actionWidgets.add(
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearchTap,
        ),
      );
    }
    
    // Notification icon with badge
    if (showNotification) {
      actionWidgets.add(_buildNotificationIcon(context));
    }
    
    // Profile icon
    if (showProfileIcon) {
      actionWidgets.add(
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _buildProfileIcon(context),
        ),
      );
    }
    
    return actionWidgets;
  }

  Widget _buildNotificationIcon(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: onNotificationTap,
        ),
        if (notificationCount != null && notificationCount! > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  notificationCount! > 9 ? '9+' : notificationCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileIcon(BuildContext context) {
    return InkWell(
      onTap: onProfileTap,
      borderRadius: BorderRadius.circular(20),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.orange,
        child: Text(
          _getInitials(userName ?? 'U'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Size get preferredSize => Size.fromHeight(appbarHeight);
}

// Example 1: Basic Usage
class RecipeHomeScreen extends StatelessWidget {
  const RecipeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        title: 'Recipe App',
        backgroundColor: Colors.white,
        showNotification: true,
        showProfileIcon: true,
        showSearch: true,
        notificationCount: 3,
        userName: 'John Doe',
        isCenterTitle: false,
        onNotificationTap: () {
          print('Notification clicked');
        },
        onProfileTap: () {
          print('Profile clicked');
        },
        onSearchTap: () {
          print('Search clicked');
        },
      ),
      body: const Center(
        child: Text('Recipe List Here'),
      ),
    );
  }
}

// Example 2: Simple AppBar
class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RecipeAppBar(
        title: 'Recipe Details',
        showBackButton: true,
      ),
      body: const Center(
        child: Text('Recipe Details Here'),
      ),
    );
  }
}

// Example 3: Custom Actions
class RecipeFavoritesScreen extends StatelessWidget {
  const RecipeFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RecipeAppBar(
        title: 'Favorites',
        showProfileIcon: true,
        userName: 'Jane Smith',
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              print('Filter clicked');
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              print('Sort clicked');
            },
          ),
        ],
        onProfileTap: () {
          print('Profile tapped');
        },
      ),
      body: const Center(
        child: Text('Favorite Recipes Here'),
      ),
    );
  }
}