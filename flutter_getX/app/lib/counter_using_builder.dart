import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterUsingBuilder extends StatefulWidget {
  const CounterUsingBuilder({super.key});

  @override
  State<CounterUsingBuilder> createState() => _CounterUsingBuilderState();
}

//1. create the controller
class CounterController extends GetxController {
  var count = 0; //2. using the GetBuilder the .obs is not written

  //3. increment method
  void increment() {
    // count = count + 1; // can be written as count++
    count++;
    update();
  }
}

class _CounterUsingBuilderState extends State<CounterUsingBuilder> {
  //4. creating the objects of the controller using Get.put(controller_name());
  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("getX Counter app using GetBuileder()"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            //5. uisng builder method and define the type here, as CounterController
            child: GetBuilder<CounterController>(
              builder: (controller) => Text(
                "count: ${controller.count}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              controller.increment();
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
 *    - Define a class that extends `GetxController` to manage your app's state.
 *    - The `GetxController` class will contain logic for controlling and updating your app’s data.
 *    - Unlike `GetX` and `Obx()`, `GetBuilder` uses a manual update approach to trigger UI rebuilds.
 *    - Example:
 *      ```dart
 *      class MyController extends GetxController {
 *        var counter = 0;
 *        
 *        void increment() {
 *          counter++;
 *          update(); // Triggers the UI rebuild in GetBuilder
 *        }
 *      }
 *      ```
 * 
 * 2. Instantiate the Controller:
 *    - Use `Get.put()` to initialize your controller. This creates an instance of the controller and makes it available throughout the widget tree.
 *    - This step ensures the controller is accessible in any widget that requires it.
 *    - Example: `final controller = Get.put(MyController());`
 * 
 * 3. Use GetBuilder to Build the UI:
 *    - Wrap your widget (or part of it) with `GetBuilder`. 
 *    - Unlike `Obx()`, which automatically rebuilds when an observable changes, `GetBuilder` requires a manual call to the `update()` method in the controller to trigger the UI update.
 *    - `GetBuilder` only rebuilds the widget when the `update()` method is called in the controller, making it more efficient when you want to control when the UI is rebuilt.
 *    - Example:
 *      ```dart
 *      GetBuilder<MyController>(
 *        builder: (controller) {
 *          return Text('Counter: ${controller.counter}');
 *        },
 *      );
 *      ```
 *    - In this case, `GetBuilder` listens for changes in the controller, but it only rebuilds the widget when `controller.update()` is called.
 * 
 * 4. Trigger UI Update Manually:
 *    - In your controller, when you want to trigger a UI update (for example, after a button press), call `update()` on the controller.
 *    - This will cause all `GetBuilder` widgets associated with that controller to rebuild.
 *    - Example:
 *      ```dart
 *      controller.increment(); // This will trigger the GetBuilder to rebuild the UI.
 *      ```
 * 
 * 5. Benefit of GetBuilder:
 *    - `GetBuilder` provides more control over when the UI is updated, allowing for better performance in certain cases where you don’t need the UI to rebuild every time an observable value changes.
 *    - Use `GetBuilder` when you want to manually manage state updates or trigger updates only for specific actions.
 * 
 * 
 * ------For get builder we don't use observeable .obs and obX, 
 *       we use manual update(); for the updates, 
 *       and wrap up with GetBuilder<Controller_name>() ---------
 */
