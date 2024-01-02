import 'package:logger/logger.dart';
import 'package:shopping_app/constants/models/shopping_cart.dart';
import 'package:shopping_app/services/service_database.dart';
import 'package:shopping_app/services/service_locator.dart';
import 'package:sqflite/sqflite.dart';

class ShoppingCartSqflite {
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  Future<List<ShoppingCart>> getShoppingCarts() async {
    final db = await _databaseService.open();
    try {
      final List<Map<String, dynamic>> maps = await db.query('shopping_cart');
      return List.generate(maps.length, (i) {
        return ShoppingCart.fromSqflite(maps[i]);
      });
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return [];
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<ShoppingCart?> getShoppingCartByCartId(int id) async {
    final db = await _databaseService.open();
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'shopping_cart',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return ShoppingCart.fromSqflite(maps.first);
      }
      return null;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return null;
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<List<ShoppingCart?>> getShoppingCartByUserId(String userId) async {
    final db = await _databaseService.open();
    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'shopping_cart',
        where: 'user_id = ?',
        whereArgs: [userId],
      );
      return List.generate(maps.length, (i) {
        return ShoppingCart.fromSqflite(maps[i]);
      });
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return [];
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<bool> insertShoppingCart(ShoppingCart shoppingCart) async {
    final db = await _databaseService.open();
    try {
      await db.insert(
        'shopping_cart',
        {
          'user_id': shoppingCart.userId,
          'product_id': shoppingCart.productId,
          'quantity': shoppingCart.quantity,
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

  Future<bool> updateShoppingCart(ShoppingCart shoppingCart) async {
    final db = await _databaseService.open();
    try {
      await db.update(
        'shopping_cart',
        {
          'user_id': shoppingCart.userId,
          'product_id': shoppingCart.productId,
          'quantity': shoppingCart.quantity,
        },
        where: 'id = ?',
        whereArgs: [shoppingCart.id],
      );
      return true;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return false;
    } finally {
      await _databaseService.close(db);
    }
  }

  Future<bool> removeShoppingCart(ShoppingCart shoppingCart) async {
    final db = await _databaseService.open();
    try {
      await db.delete(
        'shopping_cart',
        where: 'id = ?',
        whereArgs: [shoppingCart.id],
      );
      return true;
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return false;
    } finally {
      await _databaseService.close(db);
    }
  }
}
