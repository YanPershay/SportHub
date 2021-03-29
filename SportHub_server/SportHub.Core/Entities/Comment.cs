using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class Comment : Entity
    {
        public string Text { get; set; }
        public DateTime DateCreated { get; set; }
        public bool IsUpdated { get; set; }

        public Guid UserId { get; set; }
        public User User { get; set; }

        public int PostId { get; set; }
        public Post Post { get; set; }

        public Comment(string text, DateTime dateCreated, bool isUpdated, Guid userId, int postId)
        {
            Text = text;
            DateCreated = dateCreated;
            IsUpdated = isUpdated;
            UserId = userId;
            PostId = postId;
        }
    }
}
