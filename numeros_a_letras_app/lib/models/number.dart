class Number {
  final String letters;

  Number({this.letters});

  factory Number.fromJson(Map<String, dynamic> json) {
    return Number(letters: json['letras']);
  }
  factory Number.nullResponse() {
    return Number(letters: 'Letras');
  }
}