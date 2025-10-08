@Builder
export function LoaderBuilder() {
  Column() {
    LoadingProgress()
      .color(Color.White)
      .width('50vp')
      .height('50vp')
  }
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .width('100%')
  .height('100%')
}