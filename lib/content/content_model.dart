class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: '¡Excelencia Académica!',
      image: 'images/Academica.jpg',
      discription:
          "Descubre nuestros programas académicos de alta calidad. "
          "Ofrecemos una amplia variedad de carreras y cursos para tu desarrollo profesional."),
  UnbordingContent(
      title: '¡Campus Moderno y Seguro!',
      image: 'images/Campus.jpeg',
      discription: "Disfruta de nuestras instalaciones de última generación. "
          "Contamos con un campus seguro y equipado con todo lo necesario para tu comodidad."),
  UnbordingContent(
      title: '¡Oportunidades de Becas!',
      image: 'images/Becas.jpeg',
      discription: "Aprovecha nuestras becas y ayudas financieras. "
          "Facilitamos tu acceso a la educación superior con diversas opciones de apoyo económico."),
];
