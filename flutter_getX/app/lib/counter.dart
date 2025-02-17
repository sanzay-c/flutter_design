import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

//1. create a controller
class CounterController extends GetxController {
  var count =
      0.obs; //2. create observeable usint .obs which value to be observer

  //3. create method for increment
  void increment() {
    count++;
  }
}

class _CounterState extends State<Counter> {
  //4. creating the object of the controller, or use it using Get.put(CounterController())
  // final CounterController controller = CounterController(); // default object
  final CounterController controller = Get.put(
      CounterController()); // use the controller using Get.put(controller_name()); is called a managing dependencies.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("getX counter app with .obs and obx((){})"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Obx(
              () {
                //5. using obx or can use GetBuilder for the state change
                return Text(
                  'count: ${controller.count}', //6. here controller.count , *count is variable which is being observed in controller
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              controller.increment(); //7. using method increment which is inside a controller, trigger it.
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF303030),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ), // Rounded corners
              ),
              padding: EdgeInsets.all(13)
            ),
            child: Text("Click here for the increment", style: TextStyle(color: Colors.white, fontSize: 16),),
          ),
        ],
      ),
    );
  }
}

/**
 * 1. Create a Controller Class:
 *    - Define a class that extends GetxController. This class will manage the state and logic of your app.
 *    - GetxController provides an easy way to manage state with the reactivity features of GetX.
 * 
 * 2. Make Variables Observable:
 *    - Use `.obs` to make variables observable. This allows GetX to automatically track changes to those variables.
 *    - The `.obs` modifier converts a variable into an observable, which can be reacted to in the UI.
 *    - Example: `var counter = 0.obs;`
 * 
 * 3. Add Functions to the Controller:
 *    - Create functions inside the controller that modify or update the observable variables.
 *    - Functions allow you to change the state in response to user interactions or other events.
 *    - Example: `void increment() => counter.value++;`
 * 
 * 4. Instantiate the Controller:
 *    - In your `Stateful` or `Stateless` widget, use `Get.put()` to initialize the controller and make it accessible throughout your widget tree.
 *    - `Get.put()` ensures that the controller is created and kept alive until you no longer need it (e.g., when the screen is disposed).
 *    - Example: `final controller = Get.put(MyController());`
 * 
 * 5. Use Obx to Make UI Reactive:
 *    - Wrap parts of your widget tree with `Obx()` to make them reactive.
 *    - `Obx()` listens for changes in the controller’s observable variables and rebuilds the UI whenever a change occurs.
 *    - Inside the `Obx` widget, use the observable variable like normal, and it will update automatically when changed.
 *    - Example:
 *      ```dart
 *      Obx(() {
 *        return Text('Counter: ${controller.counter}');
 *      });
 *      ```
 */

