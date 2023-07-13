//
//  MainView.swift
//  CAFGPT
//
//  Created by CAF , twitter @ivd_2 CAF , twitter @ivd_2.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @FocusState var isTextFieldFocused: Bool
    
    @EnvironmentObject var vm: ViewModel
    #if os(iOS)
    @StateObject private var keyboard = KeyboardInfo.shared
    #endif
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 0) {
                ChatScrollView()
                    #if os(iOS)
                    .onChange(of: keyboard.height) { newValue in
                        if newValue != 0 {
                            DispatchQueue.asyncAfterOnMain {
                                withAnimation {
                                    scrollToBottom(proxy: proxy)
                                }
                            }
                        }
                    }
                    #endif
                Divider()
                BottomView(proxy: proxy)
                Spacer()
            }
            .onChange(of: vm.messages.last?.responseText) { _ in
                scrollToBottom(proxy: proxy)
            }
            .onAppear {
                withAnimation {
                    scrollToBottom(proxy: proxy)
                }
            }
        }
        .background(backgroundColor)
        .onTapGesture {
            isTextFieldFocused = false
        }
        .alert(vm.errorMessage, isPresented: $vm.isShowError) {
            Button("OK", role: .cancel) {
                vm.reset()
            }
        }
    }
    
    func ChatScrollView() -> some View {
        ScrollView {
            /// fix bug: use LazyVStack in iOS can't be scroll to the bottom at the appearence.
            #if os(macOS)
            LazyVStack(spacing: 0) {
                MessageViewList()
            }
            #else
            MessageViewList()
            #endif
        }
    }
    
    func MessageViewList() -> some View {
        ForEach(vm.messages) { message in
            MessageView(message: message) { message in
                Task { @MainActor in
                    await vm.retry(message: message)
                }
            }
            .tag(message.id)
        }
    }
    
    func BottomView(proxy: ScrollViewProxy) -> some View {
        HStack(alignment: .center) {
            
            if let data = vm.imageData {
                ProfileView(data: data)
            } else {
                ProfileView(name: "person")
            }
            
            InputView(proxy: proxy)
            
            if vm.isInteractingWithChatGPT {
                ThreeDotLoadingView()
                    .frame(width: 50, height: 30)
            } else {
                SendButton(proxy: proxy)
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    func InputView(proxy: ScrollViewProxy) -> some View {
        TextField("Send message", text: $vm.inputMessage)
            .textFieldStyle(.roundedBorder)
            .focused($isTextFieldFocused)
            .disabled(vm.isInteractingWithChatGPT)
            .onSubmit {
                send(proxy: proxy)
            }
    }
    
    func SendButton(proxy: ScrollViewProxy) -> some View {
        Button {
            send(proxy: proxy)
        } label: {
            Image(systemName: "paperplane.circle.fill")
                .rotationEffect(.degrees(45))
            #if os(iOS)
                .font(.system(size: 25))
            #else
                .font(.system(size: 20))
            #endif
        }
        .buttonStyle(.borderless)
        .keyboardShortcut(.defaultAction)
        .foregroundColor(.accentColor)
        .disabled(vm.isEmptyInput)
    }
    
    private func send(proxy: ScrollViewProxy) {
        
        isTextFieldFocused = false
        scrollToBottom(proxy: proxy)
        
        Task { @MainActor in
            await vm.sendTapped()
        }
        
#if os(macOS)
        DispatchQueue.asyncAfterOnMain {
            isTextFieldFocused = true
        }
#endif
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = vm.messages.last?.id else {
            return
        }
        proxy.scrollTo(id, anchor: .bottomTrailing)
    }
    
    private var backgroundColor: Color {
        if colorScheme == .light {
            return .white
            
        }
        return Color(red: 52/255, green: 53/255, blue: 65/255, opacity: 0.5)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MainView()
        }
        .environmentObject(ViewModel())
    }
}
