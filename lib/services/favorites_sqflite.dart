import 'package:logger/logger.dart';
import 'package:shopping_app/constants/models/product.dart';
import 'package:shopping_app/services/authentication.dart';
import 'package:shopping_app/services/service_database.dart';
import 'package:shopping_app/services/service_locator.dart';
import 'package:shopping_app/services/service_product_sqflite.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesSqflite {
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  FavoritesSqflite() {
    _init();
  }

  Future<void> _init() async {
    if (serviceLocator<Authentication>().userId == null) {
      Logger().log(Level.info, 'User is not logged in.');
    }
  }

  Future<bool> isProductFavorite(Product product) async {
    final db = await _databaseService.open();
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'favorites',
        where: 'product_id = ?',
        whereArgs: [product.id],
      );

      return maps.isNotEmpty;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return false;
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<bool> insertFavoriteProduct(Product product) async {
    final db = await _databaseService.open();
    try {
      await db.insert(
        'favorites',
        {
          'user_id': serviceLocator<Authentication>().userId,
          'product_id': product.id,
        },
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

  Future<bool> deleteFavoriteProduct(Product product) async {
    final db = await _databaseService.open();
    try {
      await db.delete(
        'favorites',
        where: 'product_id = ?',
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

  Future<List<Product>> getFavoriteProductsByUserId() async {
    final db = await _databaseService.open();
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'favorites',
        where: 'user_id = ?',
        whereArgs: [serviceLocator<Authentication>().userId],
      );
      final List<Product> products = [];
      for (final map in maps) {
        final serviceProductSqflite = serviceLocator<ProductSqflite>();
        final Product? product = await serviceProductSqflite.getProductById(map['product_id']);
        if (product != null) {
          products.add(product);
        }
      }
      return products;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return [];
    } finally {
      await _databaseService.close(db);
    }
  }
}
