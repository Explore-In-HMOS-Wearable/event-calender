import Event from '../viewmodels/Event';
import GlobalNavPathStack from '../models/GlobalNavPathStack';


@Component
export default struct EventListItem {
  @Prop @Require event: Event
  private globalPathStack: GlobalNavPathStack = GlobalNavPathStack.getInstance();

  build() {
    Column() {
      Text(this.event.title)
        .fontSize('14vp')
        .fontWeight(FontWeight.Bold)

      Blank(5)
      Text(`${this.event.startTime} - ${this.event.endTime}`)
        .fontSize('12vp')
    }
    .onClick(() => {
      this.globalPathStack.pageStack.pushPathByName('EventPage', this.event);
    })
    .border({
      width: 2,
      color: this.event.color,
      radius: 15
    })
    .margin({
      left: 10,
      top: 5,
      right: 10,
      bottom: 5
    })
    .padding(5)
    .width('100%')
  }
}