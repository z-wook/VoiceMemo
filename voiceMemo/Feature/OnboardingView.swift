//
//  OnboardingView.swift
//  voiceMemo
//
//  Copyright (c) 2024 z-wook. All right reserved.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        // TODO: - 화면 전환 구현 필요
        OnboardingContentView(onboardingViewModel: onboardingViewModel)
    }
}

// MARK: - OnbardingContentView
private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            StartBtnView()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - OnboardingCellListView
private struct OnboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int
    
    init(
        onboardingViewModel: OnboardingViewModel,
        selectedIndex: Int = 0
    ) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, onboardingContent in
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(selectedIndex % 2 == 0 ? Color.customSky : Color.customBackgrondGreen)
        .clipped()
    }
}

// MARK: - OnboardingCellView
private struct OnboardingCellView: View {
    private var onboardingContent: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    
    fileprivate var body: some View {
        VStack {
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                        .frame(height: 46)
                    Text(onboardingContent.title)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                        .frame(height: 5)
                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                }
                
                Spacer()
            }
            .background(Color.customWhite)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}

// MARK: - StartBtnView
private struct StartBtnView: View {
    fileprivate var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Text("시작하기")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.customGreen)
                
                Image("startHome")
                    .renderingMode(.template)
                    .foregroundColor(.customGreen)
            }
        })
        .padding(.bottom, 50)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
