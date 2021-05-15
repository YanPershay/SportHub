using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Responses
{
    public class SubscribeObjectResponse
    {
        public int Id { get; set; }
        public Guid UserId { get; set; }
        public Guid SubscriberId { get; set; }
    }
}
