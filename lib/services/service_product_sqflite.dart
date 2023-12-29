import 'package:logger/logger.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/services/service_database.dart';
import 'package:shopping_app/services/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class ProductSqflite {
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  Future<List<Product>> getProducts() async {
    final db = await _databaseService.open();
    try {
      final List<Map<String, dynamic>> maps = await db.query('products');
      return List.generate(maps.length, (i) {
        return Product.fromSqflite(maps[i]);
      });
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return [];
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<Product?> getProduct(int id) async {
    final db = await _databaseService.open();

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return Product.fromSqflite(maps.first);
      }
      return null;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return null;
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<Product?> getProductById(int productId) async {
    final db = await _databaseService.open();

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [productId],
      );
      return Product.fromSqflite(maps.first);
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return null;
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<bool> updateProduct(Product product) async {
    final db = await _databaseService.open();
    try {
      await db.update(
        'products',
        product.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      return true;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return false;
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<bool> insertProduct(Product product) async {
    final db = await _databaseService.open();
    try {
      await db.insert(
        'products',
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return false;
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<bool> insertProductIfNotExists(Product product) {
    return getProductById(product.id).then((value) async {
      if (value == null) {
        return await insertProduct(product);
      }
      return true;
    });
  }
}
