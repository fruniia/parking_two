abstract class Repository<T> {
  final List<T> _items = [];

  List<T> getAll() => _items;

  void add(T item) {
    _items.add(item);
  }

  void update(int index, T newItem) {
    _items[index] = newItem;
  }

  void delete(T item) => _items.remove(item);
}
