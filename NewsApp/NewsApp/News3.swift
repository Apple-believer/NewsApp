import SwiftUI

struct News3: View {
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
                }.navigationTitle("Wall Street Journal News")
            }
        }.onAppear(perform: {
            LoadNews()
        })
    }
    
    func LoadNews(){
        let url_string = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=c23af018cfed46aea7268ed62469db6e"
        
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

struct News3_Previews: PreviewProvider {
    static var previews: some View {
        News3()
    }
}
struct Article3:Codable {
    let title:String?
    let url:String?
}
