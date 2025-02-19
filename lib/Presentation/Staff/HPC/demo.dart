// Expanded(
// child: Container(
// height: MediaQuery.of(context).size.height * 0.5,
// width: MediaQuery.of(context).size.width,
// child: ListView.builder(
// itemCount: provider.studententrieslist.length,
// itemBuilder: (context, index) {
// final studentEntries = provider.studententrieslist[index].progressGrids;
//
// return Padding(
// padding: const EdgeInsets.symmetric(vertical: 8.0),
// child: Container(
// padding: EdgeInsets.all(8),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.grey.withOpacity(0.5)),
// borderRadius: BorderRadius.circular(10),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Row(
// children: [
// Text(
// provider.studententrieslist[index].rollNo?.toString() ?? "0",
// style: TextStyle(fontWeight: FontWeight.w500),
// ),
// SizedBox(width: 10),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.6,
// child: Text(
// provider.studententrieslist[index].studentName.toString(),
// style: TextStyle(
// color: UIGuide.light_Purple,
// fontWeight: FontWeight.w500,
// ),
// overflow: TextOverflow.ellipsis,
// ),
// ),
// ],
// ),
// IconButton(
// icon: Icon(Icons.visibility, color: UIGuide.light_Purple),
// onPressed: () {
//
// },
// ),
// ],
// ),
// Row(
// children: [
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.5,
// child: Text(
// "Entry Staff : ${provider.studententrieslist[index].entryStaffName ?? ""}",
// style: TextStyle(
// color: UIGuide.light_Purple,
// fontWeight: FontWeight.w500,
// ),
// overflow: TextOverflow.ellipsis,
// ),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.3,
// child: Text(
// "Entry Date : ${_formatDate(provider.studententrieslist[index].entryDate)}",
// style: TextStyle(
// color: UIGuide.light_Purple,
// fontWeight: FontWeight.w500,
// ),
// overflow: TextOverflow.ellipsis,
// ),
// ),
// ],
// ),
// SizedBox(height: 5),
// // Uncomment to show missing entries or completed status
// // if (missingEntriesCount > 0)
// //   Text(
// //     '$missingEntriesCount entry(s) missing',
// //     style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
// //   )
// // else
// //   Text(
// //     'Completed',
// //     style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
// //   ),
// ],
// ),
// ),
// );
// },
// ),
// ),
// )