import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:team_project_5_2/model/document.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'kicksy.db'),
      onCreate: (db, version) async {
        // entity
        await db.execute(
          'create table user(id text primary key unique , password text, phone text, address text, signupdate date, email text, sex text)',
        );
        await db.execute(
          'create table product(code integer primary key autoincrement, model_code integer, size integer, saleprice integer, maxstock integer, registration date, foreign key (model_code) references model(code))',
        );
        await db.execute(
          'create table store(code integer primary key autoincrement, name text, tel text, address text)',
        );
        await db.execute(
          'create table employee(code integer primary key, password text, division text, grade text)',
        );
        await db.execute(
          'create table document(code integer primary key autoincrement, propser text, title text, contents text, date date)',
        );
        await db.execute(
          'create table image(code integer primary key autoincrement, name text, image blob)',
        );
        await db.execute(
          'create table model(code integer primary key autoincrement, image_code integer ,name text, category text, company text, color text,foreign key (image_code) references image(code))',
        );

        // relation
        await db.execute(
          'create table management(num integer primary key autoincrement, employee_code integer, product_code integer, store_code integer ,type integer, date date, count integer, foreign key (employee_code) references employee(code), foreign key (product_code) references product(code), foreign key (store_code) references store(code))',
        );
        await db.execute(
          'create table oderying(num integer primary key autoincrement, employee_code integer, product_code integer, document_code integer, type integer, date date, count integer, reject_reason text, foreign key (employee_code) references employee(code), foreign key (product_code) references product(code), foreign key (document_code) references document(code))',
        );
        await db.execute(
          'create table request(num integer primary key autoincrement, user_id text, product_code integer, store_code integer, type integer, date date, count integer, reason text , foreign key (user_id) references user(id), foreign key (product_code) references product(code), foreign key (store_code) references store(code))',
        );
      },
      version: 1,
    );
  }

  Future<List<Document>> queryDocument() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery('select * from document');
    return queryResults.map((e) => Document.fromMap(e)).toList(); 
  }

  Future<int> insertEmployee() async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into employee(code,password,division,grade) values(?,?,?,?)',
      [01, 00, '본사', '회장'],
    );
    return result;
  }
  Future<int> insertDocument() async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into document(code,propser,title,contents,date) values(?,?,?,?,?)',
      [01, '김태민', '기안1', '일단 쓰긴함', 20250502],
    );
    return result;
  }
}
