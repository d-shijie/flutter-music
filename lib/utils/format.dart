class Format {
  formatPlayCount(String playCount) {
    var count = double.parse(playCount);
    int w = 10000;
    int y = 100000000;
    if (count < w && count > 0) {
      return count.toStringAsFixed(0).toString();
    } else if (count >= w && count < y) {
      return '${(count / w).toStringAsFixed(0)}万';
    } else if (count >= y) {
      return '${(count / y).toStringAsFixed(0)}亿';
    }
  }
}
