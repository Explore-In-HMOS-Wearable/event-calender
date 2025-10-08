@Builder
export default function eventDot(color: ResourceColor) {
  Circle()
    .width(25)
    .height(25)
    .fill(color)
}