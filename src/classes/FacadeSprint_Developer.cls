/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class FacadeSprint_Developer {
    public void doJobBeforeDeadline(Facade_BugTracker bugTracker) {
        if (bugTracker.isActiveSprint()) {
            System.debug('Developer is solving problems...');
        } else {
            System.debug('Developer is reading Habrhabra...');
        }
    }
}