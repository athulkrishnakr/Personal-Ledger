import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'transaction.dart';

class TransactionDB {
  static final TransactionDB instance = TransactionDB.init();

  static Database? database;

  TransactionDB.init();

  Future<Database> get DB async {
    if (database != null) {
      print('DBTest1');
      return database!;
    }
    print("DBTest0");
    database = await initDB('transaction.db');

    return database!;
  }

  Future<Database> initDB(String filepath) async {
    // final dbPath = '/data/data/personal_ledger/databases/';
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    print("DBTest2");
    return await openDatabase(path, version: 2, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE TRANSACTIONDB(WALLETNAME VARCHAR(20) NOT NULL,DC VARCHAR(20) NOT NULL,CATEGORY VARCHAR(20),AMOUNT VARCHAR(20) NOT NULL)
''');
  }

  Future<void> create() async {
    final db = await TransactionDB.database!;
    //final json = await ts.toJson();
    print("${tField.WN} ${tField.dc} ${tField.Cat} ${tField.amt}");
    final id = await db.rawInsert(
        'INSERT INTO TRANSACTIONDB(WALLETNAME,DC,CATEGORY,AMOUNT) VALUES("${tField.WN}","${tField.dc}","${tField.Cat}","${tField.amt.toString()}")');
    //var id = db.insert('TRANSACTIONDB', ts.toJson());
  }

  Future<List<Map<String, Object?>>> read() async {
    final db = await TransactionDB.database!;
    List<Map<String, Object?>> id = await db.rawQuery(
        'SELECT DC,CATEGORY,AMOUNT FROM TRANSACTIONDB WHERE WALLETNAME= "${tField.WN}" ');
    return id;
  }

  Future<void> delete() async {
    final db = await TransactionDB.database!;
    final id = await db.rawDelete('DELETE FROM TRANSACTIONDB');
  }

  Future<void> deletetransaction() async {
    final db = await WalletDB.database1!;
    final id = await db.rawQuery(
        'DELETE FROM TRANSACTIONDB WHERE WALLETNAME = "${wField.wn}" ');
  }

  Future close() async {
    final db = await TransactionDB.database;
  }
}

class WalletDB {
  static final WalletDB instance = WalletDB.init();
  static Database? database1;
  WalletDB.init();

  Future<Database> get WDB async {
    if (database1 != null) {
      print('WDBTest1');
      return database1!;
    }
    print("WDBTest0");
    database1 = await initDB('wallet.db');

    return database1!;
  }

  Future<Database> initDB(String filepath) async {
    // final dbPath = '/data/data/personal_ledger/databases/';
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    print("WDBTest2");
    // print("${dbPath}");
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE WALLETDB(WNAME VARCHAR(20) NOT NULL,AMOUNT VARCHAR(20) NOT NULL)
''');
  }

  Future<void> create() async {
    final db = await WalletDB.database1!;
    //final json = await ts.toJson();
    print("${wField.wn} ${wField.amt}");
    final id = await db.rawInsert(
        'INSERT INTO WALLETDB(WNAME,AMOUNT) VALUES("${wField.wn}","${wField.amt}")');
    //var id = db.insert('TRANSACTIONDB', ts.toJson());
  }

  Future<List<Map<String, Object?>>> read() async {
    final db = await WalletDB.database1!;
    List<Map<String, Object?>> id = await db.rawQuery('SELECT * FROM WALLETDB');
    return id;
  }

  Future<void> delete() async {
    final db = await WalletDB.database1!;
    final id = await db.rawDelete('DELETE FROM WALLETDB');
  }

  Future<void> deletewallet() async {
    final db = await WalletDB.database1!;
    final id = await db
        .rawDelete('DELETE FROM WALLETDB WHERE WNAME = ?', ['${wField.wn}']);
  }
}
