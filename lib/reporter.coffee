module.exports =
  reporter: null
  queue: []

  setReporter: (@reporter) ->
    for event in @queue
      @reporter.sendEvent.apply(@reporter, event)
    @queue = []

  sendEvent: (action, label, value) ->
    if @reporter
      @reporter.sendEvent('welcome-v1', action, label, value)
    else
      @queue.push(['welcome-v1', action, label, value])
