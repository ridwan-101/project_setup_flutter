enum Flavor { dev, qa, prod }

class F {
  static Flavor? appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Project Setup Dev';
      case Flavor.qa:
        return 'Project Setup Qa';
      case Flavor.prod:
        return 'Project Setup';
      default:
        return 'title';
    }
  }
}
