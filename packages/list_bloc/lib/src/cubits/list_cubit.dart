import 'package:list_bloc/list_bloc.dart';

class ListCubit<T, F> extends DataCubit<List<T>, F> {
  ListCubit(Future<List<T>> Function([F?]) loader, [Data<List<T>, F>? state])
      : super(loader, state);

  Future<void> reload([F? filter]) => super.load(filter);

  Future<void> append([F? filter]) async {
    emit(Data.loading(data: state.data, filter: state.filter));
    try {
      emit(Data(
          data: [...state.data ?? [], ...await loader(filter ?? state.filter)],
          filter: filter ?? state.filter));
    } catch (e) {
      emit(Data.error(data: state.data, filter: state.filter, error: e));
    }
  }
}
