using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class IsUsernameBusyQuery : IRequest<bool>
    {
        public string Username { get; set; }

        public IsUsernameBusyQuery(string username)
        {
            Username = username;
        }
    }
}
