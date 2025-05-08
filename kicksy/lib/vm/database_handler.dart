import 'package:kicksy/model/document.dart';
import 'package:kicksy/model/employee.dart';
import 'package:kicksy/model/images.dart';
import 'package:kicksy/model/model.dart';
import 'package:kicksy/model/model_with_image.dart';
import 'package:kicksy/model/orderying.dart';
import 'package:kicksy/model/orderying_with_document.dart';
import 'package:kicksy/model/product.dart';

import 'package:kicksy/model/product_with_model.dart';
import 'package:kicksy/model/signin.dart';
import 'package:kicksy/model/user.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'kicksy.db'),
      onCreate: (db, version) async {
        // entity
        await db.execute(
          'create table user(email text primary key unique , password text, phone text, address text, signupdate date, sex text)',
        );
        await db.execute(
          'create table product(prod_code integer primary key autoincrement, model_code integer, size integer, maxstock integer, registration date, foreign key (model_code) references model(mod_code))',
        );
        await db.execute(
          'create table store(str_code integer primary key autoincrement, name text, tel text, address text)',
        );
        await db.execute(
          'create table employee(emp_code integer primary key, password text, division text, grade text)',
        );
        await db.execute(
          'create table document(doc_code integer primary key autoincrement, propser text, title text, contents text, date date)',
        );
        await db.execute(
          'create table image(img_code integer primary key autoincrement, model_name text ,img_num integer, image blob, foreign key (model_name) references model(mod_name))',
        );
        await db.execute(
          'create table model(mod_code integer primary key autoincrement, image_num integer ,name text, category text, company text, color text, saleprice integer, foreign key (image_num) references image(img_num))',
        );
        // relation
        await db.execute(
          'create table management(mag_num integer primary key autoincrement, employee_code integer, product_code integer, store_code integer ,mag_type integer, mag_date date, mag_count integer, foreign key (employee_code) references employee(emp_code), foreign key (product_code) references product(prod_code), foreign key (store_code) references store(str_code))',
        );
        await db.execute(
          'create table oderying(ody_num integer primary key autoincrement, employee_code integer, product_code integer, document_code integer, ody_type integer, ody_date date, ody_count integer, reject_reason text, foreign key (employee_code) references employee(emp_code), foreign key (product_code) references product(prod_code), foreign key (document_code) references document(doc_code))',
        );
        await db.execute(
          'create table request(req_num integer primary key autoincrement, user_email text, product_code integer, store_code integer, req_type integer, req_date date, req_count integer, reason text , foreign key (user_email) references user(email), foreign key (product_code) references product(prod_code), foreign key (store_code) references store(str_code))',
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
      'select * from model ',
    );
    return queryResult.map((e) => Model.fromMap(e)).toList();
  }

  Future<List<Model>> queryCompany() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from model group by company',
    );
    return queryResult.map((e) => Model.fromMap(e)).toList();
  }

  Future<List<Images>> queryImages(String mName) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      '''select * from Image where model_name = '$mName'
      ''',
    );
    return queryResult.map((e) => Images.fromMap(e)).toList();
  }

  Future<List<User>> querySignUP(String email) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
      select * from user where email like '%$email%'
      ''');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<List<User>> querySignINUser(String id) async {
    final Database db = await initializeDB();

    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
      select * from user where email = '$id'
      ''');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<List<Employee>> querySignINEmp(String id) async {
    final Database db = await initializeDB();

    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
      select * from employee where emp_code = '$id'
      ''');
    return queryResult.map((e) => Employee.fromMap(e)).toList();
  }

  Future<List<ModelWithImage>> queryModelwithImage(String where) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from model m join image i on i.img_num = m.image_num and m.name = i.model_name $where',
    );
    return queryResult.map((e) => ModelWithImage.fromMap(e)).toList();
  }

  Future<List<ProductWithModel>> queryProductwithImageModel(
    String modelName,
    int modelCode,
  ) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
         SELECT *
        FROM product p, model m
        WHERE p.model_code = m.mod_code
        AND m.name = '$modelName'
        AND p.model_code = $modelCode
      ''');
    return queryResult.map((e) => ProductWithModel.fromMap(e)).toList();
  }

  Future<List<Orderying>> queryOderying() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from oderying,document where document.code = orderying.document_code',
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
      'insert into image(model_name, img_num, image) values(?,?,?)',
      [images.modelname, images.num, images.image],
    );
    return result;
  }

  Future<int> insertUser(User user) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into user(email, password, phone, address, signupdate, sex) values(?,?,?,?,?,?)',
      [
        user.email,
        user.password,
        user.phone,
        user.address,
        user.signupdate,
        user.sex,
      ],
    );
    return result;
  }

  Future<int> insertUserfisrt() async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into user(email, password, phone, address, signupdate, sex) values(?,?,?,?,?,?)',
      ['01', '01', '01', 'user.address', DateTime.now().toString(), 'sex'],
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

  Future<int> insertProduct(Product product) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into product(model_code, size, maxstock, registration) values(?,?,?,?)',
      [product.modelCode, product.size, product.maxstock, product.registration],
    );
    return result;
  }

  Future<List<OrderyingWithDocument>> queryOderyingWithDocument() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery('''
    SELECT 
      o.num, o.employee_code, o.product_code, o.document_code, 
      o.type, o.date, o.count, o.reject_reason, 
      d.code as document_code, d.propser, d.title, d.contents, d.date as document_date
    FROM orderying o
    JOIN document d ON d.code = o.document_code
    ''');

    return queryResult.map((e) => OrderyingWithDocument.fromMap(e)).toList();
  }

  Future<List<String>> getModelNames() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'SELECT name FROM model',
    );
    return queryResult.map((e) => e['name'].toString()).toList();
  }

  Future<int> getModelNum() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'SELECT MAX(mod_code) as max_code FROM model',
    );

    // 결과는 하나의 row만 나오므로 첫 번째 row만 보면 됩니다
    if (queryResult.isNotEmpty && queryResult.first['max_code'] != null) {
      return queryResult.first['max_code'] as int;
    } else {
      return 0; // 테이블이 비어있는 경우
    }
  }
}
