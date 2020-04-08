/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Facade_BugTracker {
    private boolean activeSprint;

    public boolean isActiveSprint(){
        return activeSprint;
    }

    public void startSprint(){
        System.debug('Sprint is active');
        activeSprint = true;
    }

    public void finishSprint(){
        System.debug('Sprint is not active');
        activeSprint = false;
    }
    
}