import GlobalNavPathStack from '../models/GlobalNavPathStack';
import PermissionHandler from '../services/PermissionHandler';
import HomeView from '../views/HomeView';
import { ArcSwiper } from '@ohos.arkui.ArcSwiper';
import SmartCalendarPicker from '../components/Calendar/SmartCalendarPicker';


@Entry
@Component
struct Index {
  private globalPathStack: GlobalNavPathStack = GlobalNavPathStack.getInstance();

  aboutToAppear(): void {
    PermissionHandler.getInstance().checkPermissionGrant();
  }

  build() {
    Navigation(this.globalPathStack.pageStack) {
      Column() {
        ArcSwiper() {
          HomeView()
          SmartCalendarPicker()
        }
      }
      .width('100%')
      .height('100%')
      .background($r('app.color.app_background'))
    }
    .hideTitleBar(true)
  }
}