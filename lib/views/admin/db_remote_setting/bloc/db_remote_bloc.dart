import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_event.dart';
import 'package:dealer/views/admin/db_remote_setting/bloc/db_remote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DbRemoteBloc extends Bloc<DbRemoteEvent, DbRemoteState> {
  DbRemoteBloc() : super(Inite()) {
    on<ClickCreateTableEvent>(_clickCreateNewTablebTN);
    on<CancleCreateTableEvent>(_cancleCreateTableBtn);
    on<AddNewColumnEvent>(_addNewColumn);
    on<RemoveOneColumnEvent>(_removeOneColumn);
    on<RefreshAllTablesEvent>(_refreshTablseBtn);
  }
  _clickCreateNewTablebTN(
      ClickCreateTableEvent event, Emitter<DbRemoteState> emit) {
    emit(ClickCreateTableState(isClicked: true));
  }

  _cancleCreateTableBtn(
      CancleCreateTableEvent event, Emitter<DbRemoteState> emit) {
    emit(CancleCreateTableState(isClicked: false));
  }

  _refreshTablseBtn(RefreshAllTablesEvent event, Emitter<DbRemoteState> emit) {}

  _addNewColumn(AddNewColumnEvent event, Emitter<DbRemoteState> emit) async {
    emit(AddNewColumnState());
    await Future.delayed(const Duration(seconds: 4));
    emit(Inite());
  }

  _removeOneColumn(RemoveOneColumnEvent event, Emitter<DbRemoteState> emit) {
    emit(RemoveOneColumnState());
  }
}
