using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Responses
{
    public class AdminPostResponse
    {
        public string Title { get; set; }
        public string Text { get; set; }
        public int Duration { get; set; }
        public int Complexity { get; set; }
        public string ImageUrl { get; set; }
        public DateTime DateCreated { get; set; }
        public bool IsUpdated { get; set; }

        public int CategoryId { get; set; }

        public Guid UserId { get; set; }
    }
}
