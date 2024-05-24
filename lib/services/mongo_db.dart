import 'package:mongo_dart/mongo_dart.dart';
import 'package:takeit/utils/app_constants.dart';

class DatabaseService {
  Db? _db; // Replace with your string

  Future<void> connect() async {
    final _db = await Db.create(
        'mongodb+srv://Cypherash:cypherash@takeitbackend.30tasry.mongodb.net/?retryWrites=true&w=majority&appName=TakeItBackend');
    try {
      await _db!.open();
      print('Connected to MongoDB Atlas'); // Add this line for confirmation
    } catch (e) {
      print('Error connecting to MongoDB Atlas: $e'); // Log the error
    }
  }

  Db get db {
    if (_db == null) {
      throw Exception("Database not connected");
    }
    return _db!;
  }
}
