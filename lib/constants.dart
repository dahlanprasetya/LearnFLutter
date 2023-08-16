class MENU {
  // add a private constructor to prevent this class being instantiated
  // e.g. invoke `MENU()` accidentally
  MENU._();
  static const String CALCULATOR_PAGE = 'Calculator';
  static const String ADD_CONTACT_PAGE = 'Add Contact';
  static const String CONTACTS_LIST_PAGE = 'Contacts List';
  static const String OTHER_PAGE = 'Calculator Test';
  static int CURRENT_INDEX = 0;
}

class CALCULATOR {
  CALCULATOR._();
  static String OUTPUT = "0";
  static String CURRENT_NUMBER = "";
  static double NUM_1 = 0;
  static double NUM_2 = 0;
  static String OPERAND = "";
}
