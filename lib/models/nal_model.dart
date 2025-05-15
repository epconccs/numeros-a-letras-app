class NAL {
  final String letras;

  const NAL({
    required this.letras,
  });

  factory NAL.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'letras': String letras,
      } =>
        NAL(
          letras: letras,
        ),
      _ => throw const FormatException('Error al cargar NAL'),
    };
  }
}
