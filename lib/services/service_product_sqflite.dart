import 'package:logger/logger.dart';
import 'package:shopping_app/api/models/product.dart';
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

  Future<bool> insertOrUpdateIfExists(Product product) async {
    final productExists = await getProduct(product.id);

    if (productExists != null) {
      return await updateProduct(product);
    }
    return await insertProduct(product);
  }

  Future<bool> isProductMarkedAsFavorite(Product product) async {
    final db = await _databaseService.open();
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [product.id],
      );
      if (maps.isNotEmpty) {
        return maps.first['isFavorite'] == 1;
      }
      return false;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return false;
    } finally {
      await _databaseService.close(db);
    }
  }
}
