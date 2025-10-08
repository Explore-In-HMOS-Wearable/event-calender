import { calendarManager } from '@kit.CalendarKit';
import { formatDay, formatDayAsKey } from '../lib/utils';
import Event from './Event';

export default class GroupedEventModel {
  private _date: number;

  constructor(date: number, day: string) {
    this._day = day;
    this._date = date;
  }

  private _day: string;

  get day(): string {
    return this._day;
  }

  private _events: Event[] = [];

  get events(): Event[] {
    return this._events;
  }

  get title(): string {
    return formatDay(this._date);
  };

  public static groupEventByDay(events: calendarManager.Event[]) {
    let groupedEvents: GroupedEventModel[] = [];
    events.forEach((event) => {
      let day = formatDayAsKey(event.startTime)
      if (!(groupedEvents[day] instanceof GroupedEventModel)) {
        groupedEvents[day] = new GroupedEventModel(event.startTime, day);
      }
      groupedEvents[day].pushEvent(event);
    })
    return groupedEvents;
  }

  pushEvent(event: calendarManager.Event) {
    this._events.push(new Event(event));
  }
}

