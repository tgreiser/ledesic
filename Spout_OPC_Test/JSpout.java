class JSpout {

  static {  
    System.loadLibrary("JSpout");
  }
 
  
  static native int InitSender(String name, int width, int height, int mode);

  static native int InitReceiver(String name, int[] dim, int mode);

  static native boolean ReleaseSender();

  static native boolean ReleaseReceiver();

  static native void WriteToSharedMemory(int w, int h, int[] pix);

  static native boolean ReadFromSharedMemory(int[] dim, int[] pix);

  static native boolean ReadTexture(int[] dim, int[] pix);

  static native void WriteTexture(int w, int h, int texID, int texTarget, boolean bInvert);

  static native String GetSenderName();
  
  static native boolean SenderDialog();

 
}
