import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/data/my_data.dart';
part 'weather_event.dart';
part 'weather_state.dart';

final class WeatherBloc extends Bloc<WeatherBlocEvent , WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<WeatherBlocEvent >((event, emit)async {
      // TODO: implement event handler
      emit(WeatherBlocLoading());
      try{
        WeatherFactory wf=WeatherFactory(API_KEY,language: Language.ENGLISH);
        Weather weather =await wf.currentWeatherByLocation(
            event.position.latitude,
            event.position.longitude,

        );
        print(weather);
        emit(WeatherBlocSuccess(weather));
      }
      catch(e)
      {
        emit(WeatherBlocFailure());
      }
    });
  }
}
