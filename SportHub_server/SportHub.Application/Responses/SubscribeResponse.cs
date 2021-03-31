using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Responses
{
    public class SubscribeResponse
    {
        public Guid UserId { get; set; }

        public Guid SubscriberId { get; set; }
    }
}
