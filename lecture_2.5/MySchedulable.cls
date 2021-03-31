global class MySchedulable implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Batch myBatch = new Batch();
        ID batchprocessid = Database.executeBatch(myBatch);
    }
}