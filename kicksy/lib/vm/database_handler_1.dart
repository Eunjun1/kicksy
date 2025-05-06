import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:team_project_5_2/model/document.dart';
import 'package:team_project_5_2/model/images.dart';
import 'package:team_project_5_2/model/model.dart';
import 'package:team_project_5_2/model/model_with_image.dart';
import 'package:team_project_5_2/model/orderying.dart';
import 'package:team_project_5_2/model/orderying_with_document.dart';
import 'package:team_project_5_2/model/product.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'kicksy.db'),
      onCreate: (db, version) async {
        // entity
        await db.execute(
          'create table user(id text primary key unique, password text, phone text, address text, signupdate date, email text, sex text)',
        );
        await db.execute(
          'create table product(code integer primary key, model_code integer, size integer, maxstock integer, registration date, foreign key (model_code) references model(code))',
        );
        await db.execute(
          'create table store(code integer primary key, name text, tel text, address text)',
        );
        await db.execute(
          'create table employee(code integer primary key, password text, division text, grade text)',
        );
        await db.execute(
          'create table document(code integer primary key, propser text, title text, contents text, date date)',
        );
        await db.execute(
          'create table image(code integer, model_name text ,num integer unique, image blob, primary key(code, num))',
        );
        await db.execute(
          'create table model(code integer primary key, image_num integer ,name text, category text, company text, color text, saleprice integer, foreign key (image_num) references image(num))',
        );
        // relation
        await db.execute(
          'create table management(num integer primary key, employee_code integer, product_code integer, store_code integer ,type integer, date date, count integer, foreign key (employee_code) references employee(code), foreign key (product_code) references product(code), foreign key (store_code) references store(code))',
        );
        await db.execute(
          'create table oderying(num integer primary key, employee_code integer, product_code integer, document_code integer, type integer, date date, count integer, reject_reason text, foreign key (employee_code) references employee(code), foreign key (product_code) references product(code), foreign key (document_code) references document(code))',
        );
        await db.execute(
          'create table request(num integer primary key, user_id text, product_code integer, store_code integer, type integer, date date, count integer, reason text , foreign key (user_id) references user(id), foreign key (product_code) references product(code), foreign key (store_code) references store(code))',
        );
      },
      version: 1,
    );
  }

  Future<List<Product>> queryProduct() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from product',
    );
    return queryResult.map((e) => Product.fromMap(e)).toList();
  }

  Future<List<Model>> queryModel() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from model',
    );
    return queryResult.map((e) => Model.fromMap(e)).toList();
  }

  Future<List<ModelWithImage>> queryModelwithImage() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from model m join image i on i.num = m.image_num and m.name = i.model_name',
    );
    return queryResult.map((e) => ModelWithImage.fromMap(e)).toList();
  }

  Future<List<Orderying>> queryOderying() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from oderying, document where document.code = orderying.document_code',
    );
    return queryResult.map((e) => Orderying.fromMap(e)).toList();
  }

  Future<List<Document>> queryDocument() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from document',
    );
    return queryResult.map((e) => Document.fromMap(e)).toList();
  }
  
  Future<List<OrderyingWithDocument>> queryOderyingWithDocument() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
    '''
    select o.num, o.employee_code, o.product_code, o.document_code, o.type, o.date, o.count, o.reject_reason, 
    d.code as document_code, d.propser, d.title, d.contents, d.date as document_date 
    from orderying o 
    join document d on d.code = o.document_code
    '''
    );
    return queryResult.map((e) => OrderyingWithDocument.fromMap(e)).toList();
  }

  Future<int> insertModel(Model model) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into model(name,image_num,category,company,color,saleprice) values(?,?,?,?,?,?)',
      [
        model.name,
        model.imageNum,
        model.category,
        model.company,
        model.color,
        model.saleprice,
      ],
    );
    return result;
  }

  Future<int> insertimage(Images images) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into image(code, model_name, num, image) values(?,?,?,?)',
      [images.code, images.modelname, images.num, images.image],
    );
    return result;
  }

  Future<int> insertEmployee() async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into employee(code,password,division,grade) values(?,?,?,?)',
      [01 + 1, 00, '본사', '회장'],
    );
    return result;
  }

  
}
