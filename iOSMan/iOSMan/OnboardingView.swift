//
//  OnboardingView.swift
//  iOSMan
//
//  Created by 임준협 on 2023/05/07.
//

import SwiftUI

struct OnboardingView: View {
    @State var viewLoaded: Bool = false
    @State var installGh: Bool = false
    @State var ghInstallLog: String = ""
    @State var showGhBtn: Bool = true
    @State var showLog: Bool = false
    @State var showNoBrewInstalled: Bool = false
    @State var welcomeLoaded: Bool = false
    @State var shortDesc: Bool = false
    @State var askGithubUserName: Bool = false
    @State var isNotValidGitHubAccount: Bool = false
    @State var askUserInformation: Bool = false
    @State var githubUserNameIsNotEmpty: Bool = false
    @State var githubUserNameIsEmpty: Bool = false
    @State var endSetup: Bool = false
    @State var ghShortInst: String = "Before we start, let's install GitHub CLI"
    @AppStorage("isFirstLaunching") var isFirstLaunching = true
    @AppStorage("brewPath") var brewPath = ""
    @State var showLoading: Bool = false
    @State var showLoadingGh: Bool = false
    @State var showCompleteGhInstallation = false
    @AppStorage("githubUserName") var githubUserName = ""
    @AppStorage("githubUserAvatar") var githubUserAvatar = ""
    @AppStorage("userName") var userName = ""
    @AppStorage("supportDir") var supportDir = ""

    var body: some View {
        VStack{
            if viewLoaded {
                HStack {
                    Text("👋🏻 Hey!")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .onAppear {
                                      
//                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
//
//                                executeSh("osascript -e 'tell application \"Terminal\" '")
//                            })
                            githubUserName = executeSh("\(brewPath)gh api user | \(brewPath)jq -r '.login'")
                            githubUserName.replace("\n", with: "")
                            githubUserAvatar = "https://avatars.githubusercontent.com/\(githubUserName)"
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                withAnimation { welcomeLoaded = true;githubUserName = "" }
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.8, execute: {
                                withAnimation { shortDesc = true }
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now()+3.5, execute: {
                                withAnimation {
                                    viewLoaded = false
                                    shortDesc = false
                                }
                            })
                            if CPUType() == "ARM" {
                                brewPath = "/opt/homebrew/bin/"
                            }

                                if executeSh("\(brewPath)gh").contains("command not found") || executeSh("\(brewPath)gh").contains("such file") {
                                    DispatchQueue.main.asyncAfter(deadline: .now()+4.0, execute: {
                                        withAnimation {
                                            installGh = true
                                        }
                                    })
                                }
                                
                            else {
                                DispatchQueue.main.asyncAfter(deadline: .now()+4.0, execute: {
                                    withAnimation { askUserInformation = true }
                                })
                            }
                        }
                    if welcomeLoaded {
                        Text("Welcome to iOSMan!")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                    }
                }
            }
            
                if installGh {
                    VStack{
                        Text(ghShortInst)
                            .fontWeight(.bold)
                            .font(.largeTitle)
                        HStack{
                            if showGhBtn {
                                
                                Button(action: {
                                    withAnimation {
                                        showGhBtn = false
                                        showLoadingGh = true
                                    }
                                    ghInstallLog.append("Checking brew\n")
                                    if executeSh("\(brewPath)brew").contains("command not found") || executeSh("\(brewPath)brew").contains("such file")  {
                                        ghInstallLog.append("CPU Type: \(CPUType())\nbrew not found\n")
                                        withAnimation { showNoBrewInstalled = true }
                                    } else {
                                        ghInstallLog.append("CPU Type: \(CPUType())\nbrew found\n")
                                        ghShortInst = "Installing GitHub CLI. Please wait"
                                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                            ghInstallLog.append(executeSh("\(brewPath)brew install gh"))
                                            ghInstallLog.append("✅ GitHub CLI Installed!")
                                            if executeSh("\(brewPath)jq").contains("command not found") || executeSh("\(brewPath)jq").contains("such file") {
                                                ghInstallLog.append("Installing jq\n")
                                                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                                                    ghInstallLog.append(executeSh("\(brewPath)brew install jq\n"))
                                                })
                                                ghInstallLog.append("✅ jq Installed!\n")
                                            }
                                            ghInstallLog.append("Configuring GitHub CLI\n")
                                            print(runShFile("setupGh.sh"))
                                            ghInstallLog.append("✅ Done!")
                                            withAnimation {
                                                showLoadingGh = false
                                                showCompleteGhInstallation = true
                                            }
                                        })
                                    }
                                }, label: {
                                    Text("Install GitHub CLI")
                                        .fontWeight(.bold)
                                        .font(.title2)
                                })
                                .buttonStyle(GrowingButtonBlue())
                                
                            }
                            else if showLoadingGh{
                                ProgressView()
                                    .padding()
                            }
                            else if showCompleteGhInstallation {
                                Button(action: {
                                    withAnimation {
                                        installGh = false
                                        askUserInformation = true
                                    }
                                }, label: {
                                    Text("Complete GitHub CLI installation")
                                        .font(.title)
                                        .fontWeight(.bold)
                                })
                                .buttonStyle(GrowingButtonBlue())
                            }
                        }
                        if showNoBrewInstalled {
                            Text("Brew is not installed. Install brew to fix this")
                                .fontWeight(.bold)
                                .font(.title)
                                .onAppear {
                                    withAnimation {
                                        showLoadingGh = false
                                    }
                                }
                            Button(action: {
                                ghInstallLog.append("Finish installation on terminal and restart iOSMan")
                                runShFile("installBrew.sh")
                            }, label: {
                                Text("Install Brew")
                                    .fontWeight(.bold)
                                    .font(.title2)
                            })
                            .buttonStyle(GrowingButtonBlue())
                        }
                    }
                    Button(action: {
                        withAnimation {
                            showLog.toggle()
                        }
                    }, label: {
                        Text("Show Log")
                            .foregroundColor(.secondary)
                    })
                    .buttonStyle(.borderless)
                    if showLog {
                        ScrollView {
                            Text(ghInstallLog)
                                .monospaced()
                                .frame(alignment: .leading)
                        }
                        .frame(width: 500, height: 300)
                    }
                }
            if shortDesc {
                Text("iOS Project Manager")
                    .fontWeight(.bold)
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            if askGithubUserName {
                Text("Please enter your GitHub user name")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .onAppear {
                        githubUserName = ""
                    }
                TextField("Enter your GitHub user name here", text: $githubUserName)
                    .frame(width: 300)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if githubUserName.isEmpty {
                            githubUserNameIsEmpty = true
                        } else {
                            withAnimation {
                                showLoading = true
                                askGithubUserName = false
                            }
                        }
                    }
                if !githubUserName.isEmpty{
                    Rectangle()
                        .frame(width: 0, height: 0)
                        .onAppear {
                            withAnimation {
                                githubUserNameIsNotEmpty = true
                            }
                        }
                } else if githubUserName.isEmpty {
                    Rectangle()
                        .frame(width: 0, height: 0)
                        .onAppear {
                            withAnimation {
                                githubUserNameIsNotEmpty = false
                            }
                        }
                }
                if githubUserNameIsNotEmpty {
                    Button(action: {
                        withAnimation {
                            showLoading = true
                            askGithubUserName = false
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
            } else if showLoading {
                ProgressView()
                    .onAppear{
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
                                askGithubUserName = true
                                showLoading = false
                            }
                            if response.statusCode == 200 {
                                print("this is valid github account")
                                //                                getRepos(githubUserName)
                                //                                print(runShFile("getUserData.sh \(githubUserName)"))
                                withAnimation{
                                    askUserInformation = true
                                    showLoading = false
                                }
                            }
                        }
                        
                        task.resume()
                    }
            }
            if askUserInformation {
                VStack{
                    Text("Is this you?")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .onAppear {
//                            githubUserName = executeSh("\(brewPath)gh api user | \(brewPath)jq -r '.login'")
                            print(githubUserAvatar)
                        }
                    HStack{
                        ZStack{
                            AsyncImage(url: URL(string: githubUserAvatar)) { image in
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
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                        .padding(.trailing)
                        VStack(alignment: .leading){
                            Text(getUserData()[0])
                                .fontWeight(.bold)
                                .font(.title)
                            Text(getUserData()[1])
                                .fontWeight(.bold)
                                .font(.title2)
                                .foregroundColor(.secondary)
                            Text(getUserData()[2])
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                    }
                    HStack{
                        Button(action: {
                            withAnimation {
                                askUserInformation = false
                                askGithubUserName = true
                            }
                        }, label: {
                            HStack{
                                Image(systemName: "arrow.left")
                                Text("No it's not me")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        })
                        .buttonStyle(GrowingButton())
                        .padding(.trailing)
                        Button(action: {
                            withAnimation {
                                askUserInformation = false
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
                                    withAnimation {
                                        endSetup = true
                                    }
                                })
                                
                            }
                        }, label: {
                            HStack{
                                Text("Yes it's me")
                                    .fontWeight(.bold)
                                Image(systemName: "arrow.right")
                            }
                        })
                        .buttonStyle(GrowingButtonBlue())
                    }
                }
            }
            if endSetup {
                Text("Welcome \(userName)")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .animation(Animation.default.delay(0.5))
                
                Text("Setup Complete!")
                    .animation(Animation.default.delay(1.0))
                
                    .fontWeight(.semibold)
                    .onAppear {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
                            withAnimation {
                                isFirstLaunching = false
                            }
                        })
                    }
                //                Button(action: {
                //                    withAnimation {
                //                        isFirstLaunching = false
                //                        confetti = 1
                //                    }
                //                }, label: {
                //                    Text("End Setup")
                //                })
                //                .buttonStyle(GrowingButtonBlue())
            }
        }
        .alert("Oops!", isPresented: $isNotValidGitHubAccount) {
            Button("Okay") {}
        } message: {
            Text("Coudln't find GitHub Account named '\(githubUserName)'")
        }
        .alert("Hey!", isPresented: $githubUserNameIsEmpty) {
            Button("Okay") {}
        } message: {
            Text("Don't leave textfield blank!")
        }
        .onAppear {
            let fileManager = FileManager.default
            let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            let manSupportURL = appSupportURL.appendingPathComponent("iOSMan")
            let man = manSupportURL.absoluteString
            let sup = appSupportURL.absoluteString
            let manInd = man.count
            let supInd = sup.count
            supportDir = String(man.suffix(manInd-7))
            supportDir = supportDir.replacingOccurrences(of: "%20", with: "\\ ")
            let manSupportDir = String(sup.suffix(supInd-7)).replacingOccurrences(of: "%20", with: "\\ ")
            print(supportDir)
            print(manSupportDir)
            print("Support Directory: \(supportDir)")
            print(executeSh("git --version"))
            print("checked git")
            print(executeSh("cd \(manSupportDir) && [ -d \"iOSMan\" ] &&  echo \"iOSMan Dir found(removing old one).\";rm -rf ./iOSMan/ || echo \"iOSMan Dir not found.\";mkdir iOSMan"))
            
            print("Created iOSMan directory at Application Support: \(supportDir)")
            print(executeSh("cd \(supportDir) && git clone https://github.com/Jonathan0827/iOSManHelpers.git"))
            print("Cloned iOSManHelpers repo")
            print(supportDir)
            print(executeSh("cd \(supportDir)/iOSManHelpers && for file in ./ *\n    do\n    echo \"$file\"\ndone"))
            print(executeSh("for file in \(supportDir) *\ndo\nchmod +x \"$file\"\ndone"))
            print("chmod done")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                withAnimation { viewLoaded = true }
            })
            
            
        }
    }
    func getUserData() -> [String] {
        let html = executeSh("""
\(brewPath)gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /user
""")
        var valueToReturn = [String]()
        let decoder = JSONDecoder()
        do{
            let data = try decoder.decode(UserData.self, from: html.data(using: .utf8)!)
            var gname = data.name ?? ""
            var glogin = data.login
            if gname.isEmpty {
                gname = glogin
                glogin = ""
            }
            userName = gname
            valueToReturn = [gname, glogin, data.bio ?? ""]
        }
        catch let error as NSError{
            print(error)
        }
        return valueToReturn // 0: name 1: account name bio: bio msg (maybe blank)
    }
    func CPUTypeInt() ->Int {
        
        var cputype = UInt32(0)
        var size = cputype.byteWidth
        
        let result = sysctlbyname("hw.cputype", &cputype, &size, nil, 0)
        if result == -1 {
            if (errno == ENOENT){
                return 0
            }
            return -1
        }
        return Int(cputype)
    }


    let CPU_ARCH_MASK = 0xff      // mask for architecture bits

    let CPU_TYPE_X86 = cpu_type_t(7)
    let CPU_TYPE_ARM = cpu_type_t(12)

    func CPUType() ->String {
        
        let type: Int = CPUTypeInt()
        if type == -1 {
            return "error in CPU type"
        }
        
        let cpu_arch = type & CPU_ARCH_MASK
        
        if cpu_arch == CPU_TYPE_X86{
            return "X86"
        }
        
        if cpu_arch == CPU_TYPE_ARM{
            return "ARM"
        }
        
        return "unknown"
    }
}
extension FixedWidthInteger {
    var byteWidth:Int {
        return self.bitWidth/UInt8.bitWidth
    }
    static var byteWidth:Int {
        return Self.bitWidth/UInt8.bitWidth
    }
}
