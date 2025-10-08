import { ArcListItem } from '@kit.ArkUI'

@Builder
export default function eventDetailRowBuilder(symbol: Resource, label: string) {
  ArcListItem() {
    Row() {
      SymbolGlyph(symbol)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor([Color.White])
        .margin({ right: 10 })
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .margin({ left: 20, bottom: 20 })
  }
}