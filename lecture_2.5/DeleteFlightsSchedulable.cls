global class DeleteFlightsSchedulable implements Schedulable {
    global void execute(SchedulableContext ctx) {
        DeleteFlightsBatch myBatch = new DeleteFlightsBatch();
        database.executebatch(myBatch);
    }
}