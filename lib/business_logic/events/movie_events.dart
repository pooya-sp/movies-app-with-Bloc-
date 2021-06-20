abstract class MovieEvent {
  const MovieEvent();
}

class MovieRequested extends MovieEvent {}

class TrailerRequested extends MovieEvent {}
