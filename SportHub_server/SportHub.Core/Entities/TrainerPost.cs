using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class TrainerPost : Entity
    {
        public string Title { get; set; }
        public string Text { get; set; }
        public int Duration { get; set; }
        public int Complexity { get; set; }
        public string ImageUrl { get; set; }
        public DateTime DateCreated { get; set; }

        public Guid UserId { get; set; }
        public User User { get; set; }

        public TrainerPost(string title, string text, int duration, int complexity,
            string imageUrl, DateTime dateCreated, Guid userId)
        {
            Title = title;
            Text = text;
            Duration = duration;
            Complexity = complexity;
            ImageUrl = imageUrl;
            DateCreated = dateCreated;
            UserId = userId;
        }
    }
}
