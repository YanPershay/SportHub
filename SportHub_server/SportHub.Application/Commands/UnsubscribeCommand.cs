using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class UnsubscribeCommand : IRequest<int>
    {
        public int Id { get; set; }
        public Guid UserId { get; set; }

        public Guid SubscriberId { get; set; }
    }
}
