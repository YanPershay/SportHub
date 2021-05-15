using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class CreateUserInfoCommand : IRequest<UserInfoResponse>
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Country { get; set; }
        public string City { get; set; }
        public string DateOfBirth { get; set; }
        public string SportLevel { get; set; }
        public float Height { get; set; }
        public float Weight { get; set; }
        public string AboutMe { get; set; }
        public string Motivation { get; set; }
        public string AvatarUrl { get; set; }
        public Guid UserId { get; set; }
    }
}
