/** @babel */

class Reporter {
  constructor () {
    this.reporter = null
    this.queue = []
  }

  setReporter (reporter) {
    this.reporter = reporter
    let event
    while (event = this.queue.shift()) {
      this.reporter.sendEvent(...event)
    }
  }

  sendEvent (action, label, value) {
    if (this.reporter) {
      this.reporter.sendEvent('welcome-v1', action, label, value)
    } else {
      this.queue.push(['welcome-v1', action, label, value])
    }
  }
}

export default new Reporter()
