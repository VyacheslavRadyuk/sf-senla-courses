global class DeleteFlightsBatchSchedulable implements Schedulable {
    global void execute(SchedulableContext ctx) {
        DeleteFlightsBatch myBatch = new DeleteFlightsBatch();
        database.executebatch(myBatch);
    }
}