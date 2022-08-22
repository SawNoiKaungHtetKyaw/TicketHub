import 'package:flutter/material.dart';

class Constants {
  static Color primary = const Color(0xFF2D58ED);
  static Color secondry = const Color(0xFF5578F1);
  static Color textLight = const Color(0xFFFFFFFF);
  static Color textDark = const Color(0xFF000000);
  static Color accent = const Color(0xFFF4F4F4);
  static Color normal = const Color(0xFFD4D4D4);
  static Color accentDark = const Color(0xFFD9D9D9);
  static Color error = Color.fromARGB(255, 228, 31, 31);
  static Color hint = Color.fromARGB(255, 143, 143, 143);

  static String fromCity = "Select City";
  static String toCity = "Select City";
  static String date = "Select Date";
  static String time = "08:00 AM";
  static String type = "Bus";
  static String busLineName = "";
  static String busLineImage = "";
  static String seatNo = "";
  static String price = "25000";
  static String bookingID = "10000001";
  static String busNo = "Y-123";
  static String arrival = "4:00 PM";
  static String duration = "8 Hours";
  static List<dynamic> soldout = [];
  static bool selected = false;
  static DateTime? selectedDay;

  //Passenger Info
  static String name = "";
  static String phone = "";
  static String email = "";
  static String gender = "";
  static String nrc = "";

  static String paymentType = "Select Payment";
  static List<String> payment = ["Select Payment", "Kbzpay", "Wave Pay"];
  static List paymentImage = [
    "assets/images/unselected.jpg",
    "assets/images/kpayLogo.jpg",
    "assets/images/wave_money.png"
  ];

  static List busLines = [
    ["assets/images/high_class.png", "High Class"],
    ["assets/images/mandalar_min.png", "ManDaLar Min"],
    ["assets/images/myat_mandalar_htun.png", "Myat Mandalar Tun"],
    ["assets/images/bagan_minthar.png", "Bagan Minthar"],
  ];

  static List planeLines = [
    ["assets/images/mna.png", "Myanmar National"],
    ["assets/images/airkbz.png", "Air KBZ"],
    ["assets/images/mai.png", "MAI"],
    ["assets/images/golden_myanmar.png", "Golden Myanmar"],
    ["assets/images/air-thanlwin.png", "Air Than Lwin"],
  ];

  static List<String> cities = [
    "Select City",
    "Yangon",
    "Mandalay",
    "Myitkyina",
    "Bagan",
    "Bago",
    "Putao",
    "Myeik",
    "Pha an"
  ];

  static TextStyle style(color, double fs, fw) {
    return TextStyle(
      color: color,
      fontSize: fs,
      fontWeight: fw,
    );
  }
}
