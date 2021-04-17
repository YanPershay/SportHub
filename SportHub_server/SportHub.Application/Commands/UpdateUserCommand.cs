using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class UpdateUserCommand : IRequest<UserResponse>
    {
        public Guid GuidId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
