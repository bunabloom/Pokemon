ReadMe 

Rx의 구현은 강의에서 제공된 부분만 사용했습니다. 
viewDidLoad시점에 초기 값인 20의 데이터를 불러오고 


Model: 
포켓몬의 리스트를 순서대로 받아주기위한 Model 과 
Id값에 따른 포켓몬의 디테일한 정보를 받아오는것으로 구분하였습니다.

포켓몬에 Url링크에 포켓몬ID값이 있다는걸 착안하여 computedProperty로 Id값을 저장할수 있도록 
설정하였습니다. 


MainViewController :

bind 작업에서 subject에 들어오는 값을 순서대로 쌓일수 있도록 
append(ContentsOf:) 로 데이터를 추가하였습니다 
-> 추후에 데이터 값이 더 들어왔을때 모든셀의 업데이트를 방지하고 순서대로 차곡차곡 쌓기위해서 

셀이 터치 되었을때 
화면전환이 되는 DetailViewController에 Pokemon id값을 인자로 전달하였습니다. 


MainViewModel:

fetch내에서의 초기 offset값은 0 이지만 한번 호출되고 난후에 offset값이 20씩 증가하도록 하였습니다. 

스크롤이 끝에 도달하기 직전 fetch작업을  재실행하게 하여 
