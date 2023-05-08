//
//  OnboardingView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import SwiftUI

struct OnboardingView: View {
    @State var viewLoaded: Bool = false
    @State var welcomeLoaded: Bool = false
    @State var shortDesc: Bool = false
    @State var askGithubUserName: Bool = false
    @State var isNotValidGitHubAccount: Bool = false
    @State var askUserInformation: Bool = false
    @AppStorage("githubUserName") var githubUserName = ""
    var body: some View {
        VStack{
            if viewLoaded {
                HStack {
                    Text("👋🏻 Hey!")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                withAnimation { welcomeLoaded = true }
                            })
                        }
                    if welcomeLoaded {
                        Text("Welcome to iOSMan!")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                    }
                }
            }
            if shortDesc {
                Text("iOS Project Manager")
                    .fontWeight(.bold)
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            if askGithubUserName {
                Text("Please enter your GitHub user name (Optional)")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                TextField("Enter your GitHub user name here", text: $githubUserName)
                    .frame(width: 300)
                    .textFieldStyle(.roundedBorder)
                    .onAppear{
                        githubUserName = ""
                    }
                    .onSubmit {
                        if githubUserName.isEmpty {
                            print("Not Github User")
                        } else {
                            let url = URL(string: "https://github.com/\(githubUserName)")!
                            
                            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                                guard let response = response as? HTTPURLResponse else {
                                    print("No response or response is not an HTTPURLResponse")
                                    return
                                }
                                
                                print("HTTP response status code: \(response.statusCode)")
                                
                                if response.statusCode == 404 {
                                    print("this is not valid github account")
                                    isNotValidGitHubAccount = true
                                }
                                if response.statusCode == 200 {
                                    print("this is valid github account")
                                    //                                getRepos(githubUserName)
                                    //                                print(runShFile("getUserData.sh \(githubUserName)"))
                                    withAnimation{
                                        askUserInformation = true
                                    }
                                }
                            }
                            
                            task.resume()
                        }
                    }
                Button(action: {
                    if githubUserName.isEmpty {
                        print("Not Github User")
                    } else {
                        let url = URL(string: "https://github.com/\(githubUserName)")!
                        
                        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let response = response as? HTTPURLResponse else {
                                print("No response or response is not an HTTPURLResponse")
                                return
                            }
                            
                            print("HTTP response status code: \(response.statusCode)")
                            print(response)
                            if response.statusCode == 404 {
                                print("this is not valid github account")
                                isNotValidGitHubAccount = true
                            }
                            if response.statusCode == 200 {
                                print("this is valid github account")
                                //                                getRepos(githubUserName)
                                //                                print(runShFile("getUserData.sh \(githubUserName)"))
                                withAnimation{
                                    askUserInformation = true
                                }
                            }
                        }
                        
                        task.resume()
                    }
                }, label: {
                    HStack{
                        Text("Continue")
                            .fontWeight(.semibold)
                            .font(.title3)
                        Image(systemName: "arrow.right")
                    }
                    .zIndex(1)
                })
                .buttonStyle(.borderless)
            }
            if askUserInformation {
                HStack{
                    ZStack{
                        AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/\(githubUserName)")) { image in
                            image
                                .image?.resizable()
                        }
                        .onAppear {
                            withAnimation{
                                askGithubUserName = false
                            }
                        }
                        .zIndex(1)
                        ProgressView()
                            .zIndex(0)
                    }
                    //            placeholder: {
                    //                    VStack{
                    //                        Text("Loading Your Avatar")
                    //                        ProgressView()
                    //                    }
                    //                }
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
                    //                    API Call URL: https://api.github.com/users/\(githubUserName)
                    
                }
            }
        }
        .alert("Error!", isPresented: $isNotValidGitHubAccount) {
            Button("Okay") {}
        } message: {
            Text("Coudln't find GitHub Account named '\(githubUserName)'")
        }
        .onAppear {
            print(executeSh("cd ~/ && rm -rf ./iOSManHelpers"))
            print("removed old iOSManHelpers")
            print(executeSh("git --version"))
            print("checked git")
            print(executeSh("cd ~/ && git clone https://github.com/Jonathan0827/iOSManHelpers.git"))
            print("downloaded iOSManHelpers")
            print(executeSh("for file in ~/iOSManHelpers/*;do;chmod +x \"$file\";done"))
            print("chmod done")
            print(executeSh("rm -rf ~/iOSManHelpers/.git"))
            print("removed git folder")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                withAnimation { viewLoaded = true }
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
                withAnimation { shortDesc = true }
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+3.5, execute: {
                withAnimation {
                    viewLoaded = false
                    shortDesc = false
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+4.0, execute: {
                withAnimation { askGithubUserName = true }
            })
        }
    }
    func getUserData() -> [String] {
        let url = "https://api.github.com/users/\(githubUserName)"
        let html = executeSh("curl https://api.github.com/users/\(githubUserName)")
        let decoder = JSONDecoder()
        do{
            let data = try decoder.decode(UserData.self, from: html.data(using: .utf8)!)
            return []
        }
        catch {
            print("I got error")
        }
    }
}
