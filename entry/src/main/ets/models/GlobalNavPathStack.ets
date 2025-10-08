export default class GlobalNavPathStack {
  private static instance: GlobalNavPathStack;

  constructor(pageStack: NavPathStack) {
    this._pageStack = pageStack;
  }

  private _pageStack: NavPathStack;

  get pageStack(): NavPathStack {
    return this._pageStack;
  }

  static getInstance() {
    if (!GlobalNavPathStack.instance) {
      const pageStack = new NavPathStack();
      GlobalNavPathStack.instance = new GlobalNavPathStack(pageStack);
    }
    return GlobalNavPathStack.instance;
  }
}