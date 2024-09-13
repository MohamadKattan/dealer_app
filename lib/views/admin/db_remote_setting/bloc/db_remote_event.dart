abstract class DbRemoteEvent {}

class ClickCreateTableEvent extends DbRemoteEvent {}

class CancleCreateTableEvent extends DbRemoteEvent {}

class AddNewColumnEvent extends DbRemoteEvent {}

class RemoveOneColumnEvent extends DbRemoteEvent {}

class RefreshAllTablesEvent extends DbRemoteEvent {}
