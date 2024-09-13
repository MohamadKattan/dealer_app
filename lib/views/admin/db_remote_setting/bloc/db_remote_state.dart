abstract class DbRemoteState {}

class Inite extends DbRemoteState {}

class LoudingState extends DbRemoteState {
  bool? isLouding;
  LoudingState({this.isLouding});
}

class ClickCreateTableState extends DbRemoteState {
  bool? isClicked;

  ClickCreateTableState({this.isClicked});
}

class CancleCreateTableState extends DbRemoteState {
  bool? isClicked;
  CancleCreateTableState({this.isClicked});
}

class AddNewColumnState extends DbRemoteState {}

class RemoveOneColumnState extends DbRemoteState {}

class RefreshTableState extends DbRemoteState {}
