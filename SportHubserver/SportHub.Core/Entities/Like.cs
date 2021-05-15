using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class Like : Entity
    {
        public Guid UserId { get; set; }
        public User User { get; set; }

        public int PostId { get; set; }
        public Post Post { get; set; }

        public Like(Guid userId, int postId)
        {
            UserId = userId;
            PostId = postId;
        }
    }
}
