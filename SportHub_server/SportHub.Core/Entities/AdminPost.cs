using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class AdminPost : Entity
    {
        public string Title { get; set; }
        public string Text { get; set; }
        public int Duration { get; set; }
        public int Complexity { get; set; }
        public string ImageUrl { get; set; }
        public DateTime DateCreated { get; set; }
        public bool IsUpdated { get; set; }

        public int CategoryId { get; set; }
        public PostCategory PostCategory { get; set; }

        public Guid UserId { get; set; }
        public User User { get; set; }

        public AdminPost(int categoryId, string title, string text, int duration, int complexity,
            string imageUrl, DateTime dateCreated, bool isUpdated, Guid userId)
        {
            CategoryId = categoryId;
            Title = title;
            Text = text;
            Duration = duration;
            Complexity = complexity;
            ImageUrl = imageUrl;
            DateCreated = dateCreated;
            IsUpdated = isUpdated;
            UserId = userId;
        }
    }
}
