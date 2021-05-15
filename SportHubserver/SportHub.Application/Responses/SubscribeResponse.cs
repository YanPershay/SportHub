using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Responses
{
    public class SubscribeResponse
    {
        //public Guid UserId { get; set; }
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public UserResponse User { get;set; }

        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public UserResponse Subscriber { get; set; }
        //public Guid SubscriberId { get; set; }
    }
}
