/** @babel */

export default class ReporterProxy {
  constructor () {
    this.reporter = null
    this.queue = []
  }

  setReporter (reporter) {
    this.reporter = reporter
    let customEvent
    while ((customEvent = this.queue.shift())) {
      this.reporter.addCustomEvent(customEvent.category, customEvent)
    }
  }

  sendEvent (action, label, value) {
    const event = { action, label, value, category: 'welcome-v1' }
    if (this.reporter) {
      this.reporter.addCustomEvent(event.category, event)
    } else {
      this.queue.push([event])
    }
  }
}
