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
        public bool IsTrainer { get; set; }
        public UserInfoResponse UserInfo { get; set; }
    }
}
