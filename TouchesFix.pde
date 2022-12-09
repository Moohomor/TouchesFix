import android.view.MotionEvent;
ArrayList<TE> ts = new ArrayList();
void touchStarted(TouchEvent e) {
  ts.add(new TE((MotionEvent)e.getNative()));
}
void touchMoved(TouchEvent e) {
  MotionEvent me = (MotionEvent) e.getNative();
  if (me.getActionMasked() != MotionEvent.ACTION_MOVE)
    return;
  int id = me.getPointerId(me.getActionIndex());
  int ptind = me.findPointerIndex(id);
  try {
    for (TE i:ts)
      if (i.id==id) {
        i.x=int(me.getX(ptind));
        i.y=int(me.getY(ptind));
        break;
      }
  } catch (java.util.ConcurrentModificationException ex) {
    background(255);
  }
}
void touchEnded(TouchEvent te) {
  MotionEvent me = (MotionEvent) te.getNative();
  if (me.getPointerCount()<2) {
    ts.clear();
    return;
  }
  int id = me.getPointerId(me.getActionIndex());
  //msg=me.getX()+" "+me.getY();
  int action = me.getActionMasked();
  try {
  for (int i = 0;i<ts.size();i++)
    if (ts.get(i).id==id) {
        ts.remove(i);
    }
  } catch(java.util.ConcurrentModificationException ex){
    background (255);
  }
  //println("touch end");
}

class TE {
  int id;
  int x,y;
  TE(MotionEvent me) {
    id=me.getPointerId(me.getPointerCount()-1);
    int ptind = me.findPointerIndex(id);
    x=int(me.getX(ptind));
    y=int(me.getY(ptind));
  }
  TE(){
    id=-1;
  }
}