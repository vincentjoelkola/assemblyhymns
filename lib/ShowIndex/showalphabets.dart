import 'package:flutter/material.dart';
import 'package:assemblyhymns/ShowIndex/showindex.dart';

class ShowAlphabets extends StatefulWidget {
  ShowAlphabets({Key? key}) : super(key: key);
  @override
  _ShowAlphabetsState createState() => _ShowAlphabetsState();
}

class _ShowAlphabetsState extends State<ShowAlphabets>
{
  ScrollController _controller = new ScrollController();
  List<String>? _alphabets = null;

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /*ShowIndexState data = ShowIndex.of(context);
    double width = 50.0* ShowIndex.of(context).alphabetIndex;
    if(_alphabets != null) {
      _controller.animateTo(width, duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut);
    }*/
  }

  Widget build(BuildContext context){

    if(ShowIndex.of(context)!.songsIndex != null)
    {
      return Container(
          height: 50.0,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: ShowIndex.of(context)!.songsIndex!.AlphaIndices!.length,
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context,index)
              {
                return InkWell(
                    child: Container(
                      padding: EdgeInsets.only(left: 15.0,right:15.0),
                      margin: EdgeInsets.only(right: 1.0),
                      child: Center(
                        child: Text(ShowIndex.of(context)!.songsIndex!.AlphaIndices![index].Letter,
                            style: TextStyle(fontSize: 20.0, color: Colors.white)),
                      ),
                      decoration: BoxDecoration(
                        color: (ShowIndex.of(context)!.alphabetIndex == index) ? Color(0xFF0682BF): Theme.of(context).primaryColor,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    onTap: (){
                      ShowIndex.of(context)!.setIndex(index);

                    }
                );
              })
      );
    }else{
      return Container();
    }


/*
    return FutureBuilder(
      future: SongRepository.GetAlphabets(ShowIndex.of(context).languageIndex),
      builder: (context, snapshot)
      {
        if(snapshot.hasData)
        {
          _alphabets = snapshot.data;
          ShowIndex.of(context).alphabetCount = _alphabets.length;
          return Container(
              height: 50.0,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _alphabets.length,
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  itemBuilder: (context,index)
                  {
                    return InkWell(
                        child: Container(
                          padding: EdgeInsets.only(left: 15.0,right:15.0),
                          margin: EdgeInsets.only(right: 1.0),
                          child: Center(
                            child: Text(_alphabets[index],style: TextStyle(fontSize: 20.0, color: Colors.white)),
                          ),
                          decoration: BoxDecoration(
                            color: (ShowIndex.of(context).alphabetIndex == index) ? Colors.lightGreen: Colors.green,
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        onTap: (){
                          ShowIndex.of(context).setIndex(index);
                        }
                    );
                  })
          );
        }else{
          return Container();
        }
      },
    );*/

  }


}