using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class SubscribeToUserCommand : IRequest<SubscribeResponse>
    {
        public Guid UserId { get; set; }

        public Guid SubscriberId { get; set; }
    }
}
