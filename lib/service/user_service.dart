import 'package:dashky_finance/models/user_models.dart';
import 'package:get_storage/get_storage.dart';

class UserService {
  static List<User> _users = [];
  static User? _currentUser;
  double _balance = 0.00; // Initial balance
  final box = GetStorage();

  double get saldo {
    _balance = box.read("saldo") ?? 0.0; // Berikan nilai default 0.0 jika null
    return _balance;
  }

  addBalance(double amount) {
    _balance = _balance + amount;
    box.write('saldo', _balance);
    print("saldo $_balance");
  }

  penguranganBalance(double amount) {
    _balance = _balance - amount;
    print("saldo $_balance");
  }

  // Email dan password untuk admin hardcoded
  static const String adminEmail = 'dashky@gmail.com';
  static const String adminPassword = '5754';

  // Fungsi untuk login
  static Future<User?> login(String email, String password) async {
    // Cek apakah login sebagai admin
    if (email == adminEmail && password == adminPassword) {
      _currentUser = User(id: '1', email: adminEmail, password: adminPassword);
      return _currentUser;
    }

    // Cari pengguna biasa
    for (var user in _users) {
      if (user.email == email && user.password == password) {
        _currentUser = user;
        return user;
      }
    }

    return null; // Jika tidak ditemukan
  }

  // Fungsi untuk register pengguna baru
  static Future<User?> register(String email, String password) async {
    // Cek apakah email sudah terdaftar
    for (var user in _users) {
      if (user.email == email) {
        return null; // Email sudah terdaftar
      }
    }

    // Validasi format email
    if (!isValidEmail(email)) {
      return null; // Email tidak valid
    }

    // Simulasi ID unik (misalnya dengan nomor urut)
    String newUserId = (_users.length + 1).toString();
    User newUser = User(id: newUserId, email: email, password: password);

    _users.add(newUser); // Menambahkan pengguna baru ke dalam "database" sementara
    _currentUser = newUser; // Simpan data pengguna yang baru saja terdaftar
    return newUser;
  }

  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  static Future<User?> getUser() async {
    return _currentUser;
  }

  static Future<void> logout() async {
    _currentUser = null; // Hapus data pengguna yang sedang login
  }

  static List<User> getAllUsers() {
    return _users;
  }
}
