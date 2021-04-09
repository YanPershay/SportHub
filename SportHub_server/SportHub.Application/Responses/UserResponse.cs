using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json.Serialization;

namespace SportHub.Application.Responses
{
    public class UserResponse
    {
        public Guid GuidId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }

        [JsonIgnore]
        public string Password { get; set; }
        public bool IsOnline { get; set; }
        public bool IsAdmin { get; set; }
        public UserInfoResponse UserInfo { get; set; }
    }
}
