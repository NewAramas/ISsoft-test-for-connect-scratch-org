/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Facade_WorkFlow {

    Facade_Job job = new Facade_Job();
    Facade_BugTracker bugTracker = new Facade_BugTracker();
    FacadeSprint_Developer developer = new FacadeSprint_Developer();

    public void solveProblems() {
        job.doJob();
        bugTracker.startSprint();
        developer.doJobBeforeDeadline(bugTracker);
    }
}