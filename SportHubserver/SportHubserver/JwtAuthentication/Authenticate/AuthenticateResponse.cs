using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportHub.API.JwtMiddlewareTest
{
    public class AuthenticateResponse
    {
        public Guid GuidId { get; set; }
        public string Username { get; set; }
        public bool IsAdmin { get; set; }
        public string Token { get; set; }


        public AuthenticateResponse(UserResponse user, string token)
        {
            GuidId = user.GuidId;
            Username = user.Username;
            IsAdmin = user.IsTrainer;
            Token = token;
        }
    }
}
