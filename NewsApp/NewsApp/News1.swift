import SwiftUI

struct News1: View {
    @State var results:ResultJson?
    var body: some View {
       
        NavigationView{
            if let arts = results?.articles{
                List(arts,id:\.title){ item in
                    if let tit = item.title{
                        Text(tit)
                            .onTapGesture {
                                if let url_string = item.url{
                                    if let url = URL(string: url_string){
                                        UIApplication.shared.open(url)
                                    }
                                }
                            }
                    }
                }.navigationTitle("ニュースリスト")
            }
        }.onAppear(perform: {
            LoadNews()
        })
    }
    
    func LoadNews(){
        let url_string = "https://newsapi.org/v2/everything?q=apple&from=2022-08-09&to=2022-08-09&sortBy=popularity&apiKey=c23af018cfed46aea7268ed62469db6e"
        
        guard let url = URL(string: url_string)else{return}
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request){(data,response,error) in
        guard let data = data else {return}
            let decoder = JSONDecoder()
            guard let res = try? decoder.decode(ResultJson.self,from:data) else {return}
            DispatchQueue.main.async{
                results = res
            }
    
    }
        task.resume()
    }
}

struct News1_Previews: PreviewProvider {
    static var previews: some View {
        News1()
    }
}
struct Article1:Codable {
    let title:String?
    let url:String?
}
struct ResultJson:Codable {
    let articles:[Article1]?
}
