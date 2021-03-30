class Validation {
  String password = '';
  String validateUser(String value) {
    if (value.isEmpty) {
      //JIKA VALUE KOSONG
      return 'Fill User'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  // FUNGSI validatePassword > NAMA FUNGSI BEBAS
  String validatePassword(String value) {
    password = value;
    //MENERIMA VALUE DENGAN TYPE STRING
    if (value.length < 4) {
      //VALUE TERSEBUT DI CEK APABILA KURANG DARI 6 KARAKTER
      return 'Minimum 4 Character'; //MAKA ERROR AKAN DITAMPILKAN
    }
    return null; //SELAIN ITU LOLOS VALIDASI
  }

  String validateRetype(String value) {
    //MENERIMA VALUE DENGAN TYPE STRING
    if (value != password) {
      //VALUE TERSEBUT DI CEK APABILA KURANG DARI 6 KARAKTER
      return 'Password did not match'; //MAKA ERROR AKAN DITAMPILKAN
    }
    return null; //SELAIN ITU LOLOS VALIDASI
  }

  String validateEmail(String value) {
    if (!value.contains('@')) {
      //JIKA VALUE MENGANDUNG KARAKTER @
      return 'Email not Valid'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      //JIKA VALUE KOSONG
      return 'Fill name'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validateAdd(String value) {
    if (value.isEmpty) {
      //JIKA VALUE KOSONG
      return 'Fill Address'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validateTelp(String value) {
    if (value.isEmpty) {
      //JIKA VALUE KOSONG
      return 'Fill Telephone'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validatelahan(String value) {
    if (value.isEmpty) {
      //JIKA VALUE KOSONG
      return 'Fill Luas lahan'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validateall(String value) {
    if (value.isEmpty) {
      //JIKA VALUE KOSONG
      return 'Fill the blank'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }
}
