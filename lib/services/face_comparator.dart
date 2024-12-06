import 'dart:math';

class FaceEmbeddingComparator {
  /// Compare deux embeddings en utilisant la distance euclidienne.
  /// [embedding1] et [embedding2] sont des listes représentant les vecteurs d'embedding.
  /// Retourne une valeur double représentant la distance.
  static double calculateEuclideanDistance(
      List<double> embedding1, List<double> embedding2) {
    if (embedding1.length != embedding2.length) {
      throw ArgumentError('Les embeddings doivent avoir la même dimension.');
    }

    double sum = 0.0;
    for (int i = 0; i < embedding1.length; i++) {
      sum += pow(embedding1[i] - embedding2[i], 2);
    }
    return sqrt(sum);
  }

  /// Compare deux embeddings en utilisant la similarité cosinus.
  /// Retourne une valeur double entre -1 et 1.
  static double calculateCosineSimilarity(
      List<double> embedding1, List<double> embedding2) {
    if (embedding1.length != embedding2.length) {
      throw ArgumentError('Les embeddings doivent avoir la même dimension.');
    }

    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < embedding1.length; i++) {
      dotProduct += embedding1[i] * embedding2[i];
      normA += pow(embedding1[i], 2);
      normB += pow(embedding2[i], 2);
    }

    if (normA == 0 || normB == 0) {
      throw ArgumentError(
          'Les vecteurs d\'embedding ne doivent pas être nuls.');
    }

    return dotProduct / (sqrt(normA) * sqrt(normB));
  }

  /// Détermine si les deux embeddings correspondent.
  /// [threshold] est la distance maximale pour considérer les deux vecteurs comme similaires.
  static bool isMatch(
    List<double> embedding1,
    List<double> embedding2, {
    double threshold = 0.9,
  }) {
     final distance = calculateEuclideanDistance(embedding1, embedding2);
    return distance <= threshold;
  }
}
