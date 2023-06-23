import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//COLOR
const Color primaryColor = Color.fromRGBO(42, 107, 143,1);
const Color primaryTextColor = Color.fromRGBO(46, 46, 46, 1);
const Color hintTextColor = Color.fromRGBO(107, 107, 107, 1);
const Color softGreyColor = Color.fromRGBO(65, 65, 65, 1);
const Color lineColor = Color.fromRGBO(181, 181, 181, 1);
const Color offButtonColor = Color.fromRGBO(203, 203, 203, 1);
const Color warningColor = Color.fromRGBO(143, 42, 42, 1);


figmaFontsize(int fontSize) {
  return fontSize * 0.95;
}

//FONT STYLES INITIAL
TextStyle primaryTextStyle = GoogleFonts.montserrat(
  textStyle: TextStyle(
    color: softGreyColor,
    fontWeight: FontWeight.w500,
    fontSize: figmaFontsize(18)
  )
);

TextStyle hintTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: hintTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(14)
    )
);

TextStyle sectionTitle = GoogleFonts.montserrat(
  textStyle: TextStyle(
    color: primaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: figmaFontsize(26)
  )
);

TextStyle sectionSlogan = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(22)
    )
);

TextStyle sloganHomePage = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w200,
        fontSize: figmaFontsize(10)
    )
);

TextStyle iconStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: figmaFontsize(12)
    )
);

TextStyle termsText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(10)
    )
);

TextStyle buttonText({required bool isGoogle}) {
  return isGoogle ? GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: primaryTextColor,
          fontWeight: FontWeight.w400,
          fontSize: figmaFontsize(16)
      )
  ) : GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: figmaFontsize(20)
      )
  );
}

TextStyle authMethodText({required bool isTextButton}) {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: primaryColor,
          fontWeight: isTextButton ? FontWeight.w600 : FontWeight.w400,
          fontSize: figmaFontsize(16)
      )
  );
}

TextStyle welcomeText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: figmaFontsize(14)
    )
);

TextStyle headerText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(14)
    )
);

TextStyle nameText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: figmaFontsize(23)
    )
);

TextStyle titleProduct = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(12)
    )
);

TextStyle usernameProduct = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: figmaFontsize(9)
    )
);

TextStyle priceProduct = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: figmaFontsize(12)
    )
);

TextStyle courseButton = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(12)
    )
);

TextStyle dialogText({required bool isTextDescription}) {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: primaryTextColor,
          fontWeight: isTextDescription ? FontWeight.w300 : FontWeight.w500,
          fontSize: isTextDescription ? figmaFontsize(16) : 22,
      )
  );
}

TextStyle sessionButtonText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: figmaFontsize(20)
    )
);

//Details Product TextStyle
TextStyle detailsCourseName = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(15)
    )
);

TextStyle detailsMentorText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w300,
        fontSize: figmaFontsize(10)
    )
);

TextStyle detailsDescriptionText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        height: 2,
        fontWeight: FontWeight.w400,
        fontSize: figmaFontsize(12)
    )
);

TextStyle detailsPriceText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(14)
    )
);

TextStyle editTextStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w500,
        fontSize: figmaFontsize(15)
    )
);

TextStyle detailButtonsText({required bool isDelete}) {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: isDelete? warningColor : Colors.white,
        fontWeight: isDelete ? FontWeight.w400 : FontWeight.w600,
        fontSize: isDelete ? figmaFontsize(15) : 18,
      )
  );
}

TextStyle appBarText = GoogleFonts.montserrat(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w600,
        fontSize: figmaFontsize(18)
    )
);



//IMAGE ASSETS
String bigLogo = "assets/logo/courdev-big.svg";
String smallLogo = "assets/logo/courdev-small.svg";
String googleIcon = "assets/logo/google-icons.svg";
String topDecoration = "assets/top-decoration.svg";
String iconName = "assets/icon/icon-name.svg";
String iconEmail = "assets/icon/icon-email.svg";
String iconPassword = "assets/icon/icon-password.svg";
String iconTrash = "assets/icon/icon-trash.svg";
String iconArrow = "assets/icon/icon-arrow.svg";
String iconLogout = "assets/icon/icon-logout.svg";












