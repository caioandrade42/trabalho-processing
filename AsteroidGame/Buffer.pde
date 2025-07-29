import java.lang.reflect.Array;
import java.util.function.Supplier;

abstract class Buffer<T extends Entity>{
  protected final T[] buffer;
  private final Supplier<T> supplier;
  
  Buffer(Class<T> clazz, int MAX_CAPACITY, Supplier<T> supplier) {
        this.supplier = supplier;
        this.buffer = (T[]) Array.newInstance(clazz, MAX_CAPACITY);

        for (int i = 0; i < MAX_CAPACITY; i++) {
            buffer[i] = supplier.get();
        }
    }
  
  void draw(){
    for(T obj : buffer){
      obj.draw();
    }
  }
  
  T[] getBuffer() {
    return buffer;
  }
}
