//
//  VideoDetailSwiftUIView.swift
//  RedzExplorer
//
//  Created by homyt on 22/02/2025.
//

import SwiftUI

struct VideoDetailSwiftUIView: View {
    @ObservedObject var viewModel: VideoDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // User Information Section
                HStack(spacing: 15) {
                    // User Image
                    AsyncImage(url: URL(string: viewModel.video.user.profileThumbnailURL)) { image in
                        image.resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .frame(width: 90, height: 90)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 50, height: 50)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        // User Name
                        Text("\(viewModel.video.user.userName)")
                            .font(.title2)
                            .bold()
                        
                        // Follower/Following/Likes counts
                        HStack(spacing: 20) {
                            Text("Followers\n \(viewModel.video.user.followedsCount)").fontWeight(.semibold)
                            Text("Following\n \(viewModel.video.user.followingsCount)").fontWeight(.semibold)
                            Text("Likes\n \(viewModel.video.user.totalLikes)").fontWeight(.semibold)
                        }
                        .font(.subheadline)
                    }
                }
                
                Divider()
                Text("Current Video").fontWeight(.bold).font(.title)
                
                // Video Cover Image
                AsyncImage(url: URL(string: viewModel.video.image.url)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 10)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 50, height: 50)
                }
                
                
                // Video Stats Section - Likes, Comments, etc.
                VStack(alignment: .leading, spacing: 10) {
                    Text("Video Stats").font(.title).fontWeight(.bold)
                    
                    // likes section
                    HStack(spacing: 30) {
                        HStack {
                            LikeButtonRepresentable(viewModel: viewModel)
                                .frame(width: 30, height: 30)
                            
                            Text("\(viewModel.likeCount) Likes")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        // Comments Section
                        HStack {
                            Text("💬 \(viewModel.video.totalCommentsCount) Comments")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        // views Section
                        HStack {
                            Text("Views \(viewModel.video.totalViewsCount)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                Text("Publish Date: \(viewModel.video.publishedAt.toDate()?.toString() ?? "")").font(.subheadline)
                
                Text("\(viewModel.video.postCategory.count > 1 ? "Categories: " : "Category: ")\(viewModel.video.postCategory.joined(separator: ", ") )").font(.subheadline).fontWeight(.semibold)
                
                Text("Description\n \(viewModel.video.description)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .lineLimit(nil)  // Allow multi-lines
                    .padding(.bottom, 10)
            }
            .padding()
        }
        .navigationBarTitle("Video Details", displayMode: .large)
    }
}


struct VideoDetailSwiftUIView_Previews: PreviewProvider {
    
    static var previews: some View {
        let mockVideo = Video(id: 1, description: "This is a sample description where asdfjslfkjiowejfks fsdiofjewoiklsv iwfjeiowfjlwkf xnckvjiojwfislf aifsfjlskfklasmf aslkjiojiorjgioq", category: "Popular", image: PostImage(url: "https://prod-assets.redzapp.net/users/961256/post_images/71397081-d484-4bd0-ba3a-ad4df02a8be9.png?expires=1740317615&signature=a0a97f40575920420e6f38d38ddb77e648fe80687465471280cfff3d7cc461df"), postThumbnailImageURL: "https://prod-assets.redzapp.net/public/users/961256/post_thumbnails/71397081-d484-4bd0-ba3a-ad4df02a8be9.png", totalLikesCount: 500, totalViewsCount: 1000, totalCommentsCount: 10, user: User(id: 1, userName: "Lotfi", phoneNumber: "0569598104", profileThumbnailURL: "https://prod-assets.redzapp.net/public/triggered/users/961256/profile_thumbnails/4a39fd20-6325-49fe-86e6-82a212b07274.jpg", email: "Lutfi@gmail.com", bio: "Hello redz", countryCode: "+333", followedsCount: 100, followingsCount: 50, totalLikes: 1200), postCategory: ["Popular"], publishedAt: "12-10-2022")
        
        let viewModel = VideoDetailViewModel(video: mockVideo)
        
        // Preview the view with the ViewModel
        VideoDetailSwiftUIView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)  // Ensure the view adjusts to fit content
            .padding()
    }
    
}

