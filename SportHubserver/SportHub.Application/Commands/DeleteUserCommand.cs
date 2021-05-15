using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class DeleteUserCommand : IRequest<bool>
    {
        public Guid UserId { get; set; }
    }
}
