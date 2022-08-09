extension DistanceExtension on double{
  String doubleToString(){
    if(this<1.0){
      return (this *1000.0).toStringAsFixed(2);
    }else{
      return toStringAsFixed(2);
    }
  }
}