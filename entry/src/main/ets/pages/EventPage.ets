import Event from '../viewmodels/Event';
import EventView from '../views/EventView';

@Builder
export function EventPageBuilder(name: string, param: Object) {
  EventView({ event: param as Event })
}
