// Stack(
// children: [
// Container(
// height: MediaQuery.of(context).size.width * 0.8,
// width: MediaQuery.of(context).size.width,
// child: Image.asset(
// "images/imgHomeScreen.png",
// fit: BoxFit.cover,
// ),
// ),
// Positioned(
// bottom: 30,
// left: 24,
// right: 24,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text("Hello"),
// Container(
// child: ElevatedButton(
// onPressed: () {
// Navigator.pushNamed(context, '/hotels');
// },
// child: Text('SEARCH HOTELS'),
// style: ElevatedButton.styleFrom(
// foregroundColor: Colors.black,
// backgroundColor: Colors.cyanAccent,
// elevation: 15,
// side: BorderSide(color: Colors.black12, width: 2),
// fixedSize: Size(200, 40),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// )),
// ))
// ],
// ),
// )
// ],
