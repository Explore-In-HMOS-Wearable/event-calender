import CalendarService from '../services/CalendarService';
import GroupedEventModel from '../viewmodels/GroupedEventModel';
import ListDataSource from '../viewmodels/ListDataSource';
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcButtonStyleMode,
  ArcList,
  ArcListAttribute,
  ArcListItem,
  ArcListItemAttribute,
  ColorMetrics,
  ComponentContent,
  LengthMetrics
} from '@kit.ArkUI';
import DayListItem from '../components/DayListItem';
import { EventsHeaderBuilder } from '../components/EventsHeaderBuilder';

@Component
export default struct HomeView {
  @State loading: boolean = true;
  context: UIContext = this.getUIContext()
  header: ComponentContent<Object> = new ComponentContent(this.context, wrapBuilder(EventsHeaderBuilder));
  private calendarManager: CalendarService = CalendarService.getInstance()
  private days: ListDataSource<GroupedEventModel> = new ListDataSource<GroupedEventModel>();

  loadEvents() {
    this.calendarManager.getDefaultCalendarEvents().then((events) => {
      this.loading = false;
      const groupedBy = GroupedEventModel.groupEventByDay(events)
      this.days.resetData();
      groupedBy.forEach((item) => {
        this.days.pushData(item);
      })
    });
  }

  addEvent() {
    this.calendarManager.addEvent().then(() => {
      this.loadEvents();
    })
  }

  aboutToAppear(): void {
    this.loadEvents()
  }

  /**
   * @throws
   */
  build() {
    Refresh({ refreshing: $$this.loading }) {
      Flex({
        justifyContent: FlexAlign.Center,
        direction: FlexDirection.Column,
        alignItems: ItemAlign.Center
      }) {
        ArcList({ header: this.header }) {
          LazyForEach(
            this.days,
            (day: GroupedEventModel) => DayListItem({ day: day }),
            (day: GroupedEventModel) => day.day
          )
          ArcListItem() {
            ArcButton({
              options: new ArcButtonOptions({
                label: 'Add Event',
                position: ArcButtonPosition.BOTTOM_EDGE,
                styleMode: ArcButtonStyleMode.EMPHASIZED_LIGHT,
                backgroundColor: ColorMetrics.resourceColor($r('app.color.primary')),
                onClick: () => {
                  this.addEvent();
                }
              })
            })
          }
        }
        .cachedCount(5)
        .layoutWeight(1)
        .scrollBar(BarState.On)
        .space(LengthMetrics.px(10))
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
    .onRefreshing(() => this.loadEvents())
    .layoutWeight(1)
    .height('100%')
    .width('100%')
  }
}