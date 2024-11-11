import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// General spacing
const double space = 8.0;

// General spacing
double space0 = 0.0.w;
double spaceXXS = space * 0.25.w; // 2.0
double spaceXS = space * 0.5.w; // 4.0
double spaceS = space.w; // 8.0
double spaceM = space * 2.w; // 16.0
double spaceL = space * 3.w; // 24.0
double spaceXL = space * 4.w; // 32.0
double spaceXXL = space * 6.w; // 48.0

// Padding
EdgeInsets paddingAll0 = EdgeInsets.all(space0);
EdgeInsets paddingAllXS = EdgeInsets.all(spaceXS);
EdgeInsets paddingAllS = EdgeInsets.all(spaceS);
EdgeInsets paddingAllM = EdgeInsets.all(spaceM);
EdgeInsets paddingAllL = EdgeInsets.all(spaceL);

// Common horizontal paddings
EdgeInsets paddingH0 = EdgeInsets.symmetric(horizontal: space0);
EdgeInsets paddingHS = EdgeInsets.symmetric(horizontal: spaceS);
EdgeInsets paddingHM = EdgeInsets.symmetric(horizontal: spaceM);
EdgeInsets paddingHL = EdgeInsets.symmetric(horizontal: spaceL);
EdgeInsets paddingHXL = EdgeInsets.symmetric(horizontal: spaceXL);

// Common vertical paddings
EdgeInsets paddingV0 = EdgeInsets.symmetric(vertical: space0);
EdgeInsets paddingVXXS = EdgeInsets.symmetric(vertical: spaceXXS);
EdgeInsets paddingVXS = EdgeInsets.symmetric(vertical: spaceXS);
EdgeInsets paddingVS = EdgeInsets.symmetric(vertical: spaceS);
EdgeInsets paddingVM = EdgeInsets.symmetric(vertical: spaceM);
EdgeInsets paddingVL = EdgeInsets.symmetric(vertical: spaceL);

// App edge padding
EdgeInsets appEdgePadding =
    EdgeInsets.symmetric(horizontal: spaceM, vertical: spaceS);

// List item spacing
double listItemSpacing = spaceS;

// Card padding
EdgeInsets cardPadding = EdgeInsets.all(spaceM);

// Section spacing
double sectionSpacing = spaceL;

// Border Radius
double radiusS = 4.0.r;
double radiusM = 8.0.r;
double radiusL = 16.0.r;
double radiusXL = 20.0.r;
double radiusXXL = 24.0.r;

// Divider
double dividerThin = 0.5.w;
double dividerThick = 1.0.w;

// Icon sizes
double iconXS = 8.0.w;
double iconS = 16.0.w;
double iconM = 24.0.w;
double iconL = 32.0.w;
double iconXL = 48.0.w;
double iconXXL = 64.0.w;

// Text sizes
double textXXS = 10.0.sp;
double textXS = 12.0.sp;
double textS = 14.0.sp;
double textM = 16.0.sp;
double textL = 18.0.sp;
double textXL = 20.0.sp;
double textXXL = 24.0.sp;
double textXXXL = 32.0.sp;
double textXXXXL = 36.0.sp;

// Common widget heights
double appBarHeight = 56.0.h;
double buttonHeight = 48.0.h;
double inputFieldHeight = 40.0.h;

// Spacers
Widget verticalSpaceXXS = SizedBox(height: spaceXXS);
Widget verticalSpaceXS = SizedBox(height: spaceXS);
Widget verticalSpaceS = SizedBox(height: spaceS);
Widget verticalSpaceM = SizedBox(height: spaceM);
Widget verticalSpaceL = SizedBox(height: spaceL);
Widget verticalSpaceXL = SizedBox(height: spaceXL);

Widget horizontalSpaceXXS = SizedBox(width: spaceXXS);
Widget horizontalSpaceXS = SizedBox(width: spaceXS);
Widget horizontalSpaceS = SizedBox(width: spaceS);
Widget horizontalSpaceM = SizedBox(width: spaceM);
Widget horizontalSpaceL = SizedBox(width: spaceL);
Widget horizontalSpaceXL = SizedBox(width: spaceXL);

// Screen height
double screenHeightFull = 1.sh;
double screenHeightHalfPlus = 0.75.sh;
double screenHeightHalf = 0.5.sh;
double screenHeightQuarter = 0.25.sh;
double screenHeightFifth = 0.2.sh;
double screenHeightEighth = 0.125.sh;
double screenHeightTenth = 0.1.sh;
double logoSize = 0.15.sh;

// Screen width
double screenWidthFull = 1.sw;
double screenWidthNineTenth = 0.9.sw;
double screenWidthSeventeenTwentieth = 0.85.sw;
double screenWidthFourFifth = 0.8.sw;
double screenWidthHalfPlus = 0.75.sw;
double screenWidthHalf = 0.5.sw;
double screenWidthQuarter = 0.25.sw;
double screenWidthFifth = 0.2.sw;
double screenWidthEighth = 0.125.sw;
double screenWidthTenth = 0.1.sw;

// Define width device
const double tabletWidth = 1200.0;
const double smallTabletWidth = 600.0;
const double mobileWidth = 480.0;
