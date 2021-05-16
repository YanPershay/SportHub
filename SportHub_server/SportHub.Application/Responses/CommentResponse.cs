using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Responses
{
    public class CommentResponse
    {
        public int Id { get; set; }
        public string Text { get; set; }
        public DateTime DateCreated { get; set; }

        public Guid UserId { get; set; }
        public int PostId { get; set; }
        public UserResponse User { get; set; }
    }
}
