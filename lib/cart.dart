// import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/model/foodModel.dart';
import 'package:food_delivery/provider/cartListProvider.dart';
import 'package:food_delivery/provider/listTtileColorProvider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FoodModel> foodItems;
    return Consumer<CartListProvider>(
      builder: (context, data, child) {
        if (data.getFoodItems() == null) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                children: [
                  Text(
                    "error in Stream Builder!!!",
                    style: TextStyle(fontSize: 40),
                  ),
                  CupertinoButton(
                    child: Icon(CupertinoIcons.add),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
        } else {
          foodItems = data.getFoodItems();
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(child: CartBody(foodItems)),
            bottomNavigationBar: BottomBar(foodItems),
          );
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget {
  final List<FoodModel> foodItems;

  BottomBar(this.foodItems);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          totalAmount(foodItems),
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          persons(),
          nextButtonBar()
        ],
      ),
    );
  }

  Container persons() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Persons",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              )),
          CustomPersonWidget(),
        ],
      ),
    );
  }

  Container nextButtonBar() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Color(0xfffeb324), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          Text(
            "15-25 min",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Text(
            "Next",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

Container totalAmount(List<FoodModel> foodItems) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    padding: EdgeInsets.all(25),
    child: Row(
      children: [
        Text(
          'Total:',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ),
        Text(
          '\Br ${returnTotalAmount(foodItems)}:',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

String returnTotalAmount(List<FoodModel> foodItems) {
  double totalAmount = 0.0;

  for (int i = 0; i < foodItems.length; i++) {
    totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
  }
  return totalAmount.toStringAsFixed(2);
}

class CartBody extends StatelessWidget {
  final List<FoodModel> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: [
          CustomAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          )
        ],
      ),
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text(
          'No More items left in the cart',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (builder, index) {
        return CartListItem(foodItem: foodItems[index]);
      },
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'My',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
          ),
          Text(
            'Order',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 35,
            ),
          ),
        ],
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final FoodModel foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: foodItem,
      maxSimultaneousDrags: 1,
      child: DraggableChild(foodItem: foodItem),
      feedback: DraggableChildFeedBack(foodItem: foodItem),
      childWhenDragging: foodItem.quantity > 1
          ? DraggableChild(foodItem: foodItem)
          : Container(),
    );
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodModel foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(foodItem: foodItem),
    );
  }
}

class DraggableChildFeedBack extends StatelessWidget {
  const DraggableChildFeedBack({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodModel foodItem;

  @override
  Widget build(BuildContext context) {
    // final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

    return Opacity(
      opacity: 0.7,
      child: Material(
        // child: StreamBuilder<Object>(
        //     stream: ColorBloc().colorStream,
        //     builder: (context, snapshot) {
        child: Container(
          margin: EdgeInsets.only(bottom: 25),
          child: ItemContent(foodItem: foodItem),
          // decoration: BoxDecoration(
          //     color:
          //         snapshot.data != null ? snapshot.data : Colors.white),
          // );
        ),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  final FoodModel foodItem;

  ItemContent({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodItem.imgUrl,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: foodItem.quantity.toString(),
                ),
                TextSpan(
                  text: 'x',
                ),
                TextSpan(
                  text: foodItem.title.toString(),
                ),
              ],
            ),
          ),
          Text(
            '\Br${foodItem.quantity * foodItem.price}',
            style:
                TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartListProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(
              CupertinoIcons.back,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        DragTargetWidget(),
      ],
    );
  }
}

class CustomPersonWidget extends StatefulWidget {
  @override
  _CustomPersonWidgetState createState() => _CustomPersonWidgetState();
}

class _CustomPersonWidgetState extends State<CustomPersonWidget> {
  int noOfPersons = 1;

  double _buttonWidth = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300], width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  if (noOfPersons > 1) {
                    noOfPersons--;
                  }
                });
              },
              child: Text(
                "-",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
          Text(
            noOfPersons.toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  noOfPersons++;
                });
              },
              child: Text(
                "+",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DragTargetWidget extends StatefulWidget {
  Provider provider;

  // DragTargetWidget(Provider provider);

  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  @override
  Widget build(BuildContext context) {
    FoodModel currentFoodItem;
    var provider = Provider.of<CartListProvider>(context);
    var _provider = Provider.of<ColorProvider>(context);

    return DragTarget<FoodModel>(
      onAccept: (FoodModel foodItem) {
        currentFoodItem = foodItem;
        provider.removeFromList(foodItem);
        _provider.setColor(Colors.white);
        // widget.provider.removeFromList(currentFoodItem);
      },
      onWillAccept: (FoodModel foodItem) {
        _provider.setColor(Colors.red);
        return true;
      },
      onLeave: (foodItem) {
        _provider.setColor(Colors.white);
      },
      builder: (BuildContext context, List incoming, List rejected) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            CupertinoIcons.delete,
            size: 35,
          ),
        );
      },
    );
  }
}
