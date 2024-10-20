abstract class Repository<T> {
  final List<T> _items = [];

  Future<List<T>> getAll() async => _items;

  Future<T> add(T item) async{
    _items.add(item);
    return item;
  }

  Future<T> update(int index, T newItem) async{
    _items[index] = newItem;
    return _items[index];
  }

  Future<T> delete(T item) async{
     _items.remove(item);
    return item;
  }
}
