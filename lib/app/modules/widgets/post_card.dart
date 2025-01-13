import 'package:blogapp/app/data/models/post_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // color: Colors.grey,
          // color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: post.coverImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          post.category,
                          style: TextStyle(
                              //fontSize: 16,
                              color: Get.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          DateFormat.yMMMd().format(post.createdAt),
                          style: TextStyle(
                              //fontSize: 18,
                              color: Get.theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          post.authorAvatar,
                        ),
                        radius: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(post.authorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                          Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BuildInteractionButton(
                              icon: Icons.favorite_border,
                              count: post.likesCount),
                          const SizedBox(
                            width: 8,
                          ),
                          BuildInteractionButton(
                              icon: Icons.bookmark_border,
                              count: post.commentsCount),
                        ],
                      )
                    ]),
                  ],
                ))
          ],
        ));
  }
}

class BuildInteractionButton extends StatelessWidget {
  final IconData icon;
  final int count;
  const BuildInteractionButton(
      {super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          //color: Get.theme.colorScheme.primary,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '$count',
          style: TextStyle(fontSize: 12),
          //color: Get.theme.colorScheme.primary,
        ),
      ],
    );
  }
}
