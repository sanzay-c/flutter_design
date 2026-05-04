import 'dart:isolate';
import 'dart:async';

/// Isolate.run() is the modern and simplest way to run a heavy task 
/// in the background and get a result back. It's essentially a better 
/// version of 'compute'.
Future<int> calculateSumWithIsolateRun(int n) async {
  // Isolate.run takes a function and runs it in a new isolate.
  // It handles all the port setup and cleanup for you.
  return await Isolate.run(() {
    int sum = 0;
    for (int i = 0; i < n; i++) {
      sum += i;
    }
    return sum;
  });
}

/// Isolate.spawn() gives you more control. It's used for long-running 
/// isolates or when you need bi-directional communication.
/// It requires manual port management using ReceivePort and SendPort.
Future<void> demonstrateIsolateSpawn() async {
  // 1. Create a ReceivePort for the main isolate to listen to.
  final receivePort = ReceivePort();

  // 2. Spawn the isolate, passing the SendPort of our ReceivePort.
  final isolate = await Isolate.spawn(_heavyTaskWorker, receivePort.sendPort);

  // 3. Listen for messages from the worker isolate.
  // We'll use a Completer to wait for the final result.
  final completer = Completer<String>();
  
  receivePort.listen((message) {
    if (message is SendPort) {
      // The worker sent its own SendPort, now we can send it tasks!
      message.send("Start Working");
    } else if (message is String) {
      print("Main Isolate received: $message");
      if (message == "Done") {
        completer.complete("Success");
        receivePort.close();
        isolate.kill();
      }
    }
  });

  await completer.future;
  print("Isolate.spawn demonstration finished.");
}

/// This is the entry point for the spawned isolate.
/// It MUST be a top-level function or a static method.
void _heavyTaskWorker(SendPort mainSendPort) {
  // 1. Create a ReceivePort for this worker to receive messages.
  final workerReceivePort = ReceivePort();

  // 2. Send the worker's SendPort back to the main isolate.
  mainSendPort.send(workerReceivePort.sendPort);

  // 3. Listen for commands from the main isolate.
  workerReceivePort.listen((message) {
    print("Worker received: $message");
    
    if (message == "Start Working") {
      // Simulate heavy work
      mainSendPort.send("Working...");
      
      int sum = 0;
      for (int i = 0; i < 1000000; i++) {
        sum += i;
      }
      
      mainSendPort.send("Work complete! Sum is $sum");
      mainSendPort.send("Done");
    }
  });
}
