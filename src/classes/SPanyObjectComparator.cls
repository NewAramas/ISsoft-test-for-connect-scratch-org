/**
 * Created by mryzhkouskaya on 29.05.2019.
 */



    public class SPanyObjectComparator extends SPComparator {
        public override Integer compare(Object a, Object b) {
            return ((SPnewWrapper)a).fieldName.compareTo(((SPnewWrapper)b).fieldName);
        }
    }