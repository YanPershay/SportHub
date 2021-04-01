using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class Post : Entity
    {
        public string Text { get; set; }
        public string ImageUrl { get; set; }
        public DateTime DateCreated { get; set; }
        public bool IsUpdated { get; set; }

        public Guid UserId { get; set; }
        public User User { get; set; }

        public List<Comment> Comments { get; set; }
        public List<Like> Likes { get; set; }
        public List<SavedPost> SavedPosts { get; set; }

        public Post(string text, string imageUrl, DateTime dateCreated, bool isUpdated, Guid userId)
        {
            Text = text;
            ImageUrl = imageUrl;
            DateCreated = dateCreated;
            IsUpdated = isUpdated;
            UserId = userId;
        }
    }
}
