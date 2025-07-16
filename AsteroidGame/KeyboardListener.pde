static class KeyboardListener{
  public final static HashMap<Integer, Boolean> keyboard = new HashMap<>();
  
  public static void addKey(int keyCode){
    keyboard.put(keyCode, true);
  }
  
  public static void removeKey(int keyCode){
    keyboard.put(keyCode, false);
  }
  
  public static boolean checkKey(int keyCode){
    return keyboard.getOrDefault(keyCode, false);
  }
}
