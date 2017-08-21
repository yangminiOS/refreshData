# refreshData

一.仿照知乎的刷新功能 

1.下拉刷新   </br> 

2.出现“上次浏览到这里  点击更新”</br>

二.实现思路

1.dataArray  有两组数据，一组是刷新前的数据originalData   一组是刷新后的数组reData </br>

2.每次刷新后将reData数据放到originalData中，然后删除reData中的数据，再将最新的数据放在reData中</br>

3.刷新tableView  </br>



