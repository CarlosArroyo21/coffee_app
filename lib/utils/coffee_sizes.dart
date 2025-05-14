enum CoffeeSize {
  small(price: 5),
  medium(price: 10),
  large(price: 15);

  final int price;

  const CoffeeSize({
    required this.price,
  });
  
}
