import { ArcListItem, ArcListItemAttribute } from '@ohos.arkui.ArcList';
import GroupedEventModel from '../viewmodels/GroupedEventModel';
import ListDataSource from '../viewmodels/ListDataSource';
import Event from '../viewmodels/Event';
import EventListItem from './EventListItem';

@Component
export default struct DayListItem {
  @Prop @Require day: GroupedEventModel;
  private events: ListDataSource<Event> = new ListDataSource<Event>();

  aboutToAppear(): void {
    this.day.events.forEach((event) => this.events.pushData(event));
  }

  @Builder
  dividerBuilder() {
    Divider()
      .color(Color.Gray)
      .width('35vp')
      .strokeWidth(2)
      .borderRadius(5)
  }

  @Builder
  dayTitleBuilder() {
    Row() {
      this.dividerBuilder()
      Blank(4)
      Text(this.day.title)
        .fontSize('16vp')
        .fontWeight(FontWeight.Bold)
      Blank(4)
      this.dividerBuilder()
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    ArcListItem() {
      Column() {
        this.dayTitleBuilder()
        Column() {
          LazyForEach(
            this.events,
            (event: Event) => EventListItem({ event: event }),
            (event: Event) => event.title,
          )
        }
        .height('auto')
        .width('80%')
      }
    }
    .autoScale(false)
    .padding(10)
    .width('100%')
  }
}