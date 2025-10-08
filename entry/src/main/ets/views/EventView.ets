import { ArcList, ComponentContent } from '@kit.ArkUI';
import { calendarManager } from '@kit.CalendarKit';
import EventDot from '../components/EventDot';
import Event from '../viewmodels/Event';
import eventDetailRowBuilder from '../components/EventDetailRowBuilder';

@Builder
function eventHeaderBuilder(color: ResourceColor) {
  EventDot(color)
}

@Component
export default struct EventView {
  @Prop @Require event: Event;
  pathStack: NavPathStack = new NavPathStack();
  context: UIContext = this.getUIContext();
  header: ComponentContent<Object> =
    new ComponentContent(this.context, wrapBuilder<[ResourceColor]>(eventHeaderBuilder), this.event.color);

  build() {
    NavDestination() {
      Flex({
        justifyContent: FlexAlign.Start,
        direction: FlexDirection.Column,
        alignItems: ItemAlign.Start
      }) {
        ArcList({ header: this.header }) {
          eventDetailRowBuilder($r('sys.symbol.label'), this.event.title)
          eventDetailRowBuilder($r('sys.symbol.calendar_1'), this.event.startDate)
          eventDetailRowBuilder($r('sys.symbol.timer'),
            this.event.event.type === calendarManager.EventType.NORMAL ? 'Normal' : 'Important')
          eventDetailRowBuilder($r('sys.symbol.calendar'), this.event.event.isAllDay ? 'All Day' : 'One Day')
          if (this.event.event.location && this.event.event.location.location) {
            eventDetailRowBuilder($r('sys.symbol.location_up'), this.event.event.location.location ?? '')
          }
          eventDetailRowBuilder(this.event.event.isLunar ? $r('sys.symbol.moon') : $r('sys.symbol.star_calendar'),
            this.event.event.isLunar ? 'Lunar' : 'Georgian')
          if (this.event.event.description) {
            eventDetailRowBuilder($r('sys.symbol.notepad'), this.event.event.description)
          }
        }
      }
      .width('100%')
      .height('100%')
      .background($r('app.color.app_background'))
    }
    .onBackPressed(() => {
      this.pathStack.pop();
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
    .hideToolBar(true)
    .hideBackButton(true)
    .hideTitleBar(true)
  }
}