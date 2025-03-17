class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: '¡Cuidado y salud para tu familia!',
      image: 'images/Farmaceutica.svg',
      discription:
          "Encuentra los mejores productos para el bienestar de toda tu familia. "
          "Medicinas, vitaminas y más, siempre al mejor precio."),
  UnbordingContent(
      title: '¡Atención rápida y segura!',
      image: 'images/Farmacia.svg',
      discription: "Compra fácil y recibe tu pedido en minutos. "
          "Contamos con servicio a domicilio y retiro en tienda para tu comodidad."),
  UnbordingContent(
      title: '¡Promociones y descuentos!',
      image: 'images/Medicinas.svg',
      discription: "Ahorra en tus compras con nuestras ofertas especiales. "
          "¡Cuida tu salud y cuida tu bolsillo! "),
];
