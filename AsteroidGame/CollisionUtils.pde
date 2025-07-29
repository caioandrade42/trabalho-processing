static class CollisionUtils{
  
  static boolean pointInsideShape(PShape shape, PVector pos, float px, float py) {
    int count = shape.getVertexCount();
    int crossing = 0;
    
    for (int i = 0; i < count; i++) {
      PVector v1 = shape.getVertex(i);
      PVector v2 = shape.getVertex((i + 1) % count);
  
      float x1 = v1.x + pos.x;
      float y1 = v1.y + pos.y;
      float x2 = v2.x + pos.x;
      float y2 = v2.y + pos.y;
  
      if ((y1 > py) != (y2 > py)) {
        float interX = (x2 - x1) * (py - y1) / (y2 - y1) + x1;
        if (px < interX) crossing++;
      }
    }
    return crossing % 2 == 1;
  }
  
  static boolean linesIntersect(PVector a1, PVector a2, PVector b1, PVector b2) {
    PVector d1 = PVector.sub(a2, a1);
    PVector d2 = PVector.sub(b2, b1);
  
    float cross = d1.x * d2.y - d1.y * d2.x;
    if (abs(cross) < 0.00001) return false;
  
    PVector delta = PVector.sub(b1, a1);
    float s = (delta.x * d2.y - delta.y * d2.x) / cross;
    float t = (delta.x * d1.y - delta.y * d1.x) / cross;
  
    return s >= 0 && s <= 1 && t >= 0 && t <= 1;
  }


}
