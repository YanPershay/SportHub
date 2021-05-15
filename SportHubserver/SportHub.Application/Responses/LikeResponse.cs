using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Responses
{
    public class LikeResponse
    {
        public int Id { get; set; }

        public Guid UserId { get; set; }
        public int PostId { get; set; }
    }
}
