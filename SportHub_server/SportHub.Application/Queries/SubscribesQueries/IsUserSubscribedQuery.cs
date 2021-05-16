using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    public class IsUserSubscribedQuery : IRequest<bool>
    {
        public Guid UserId { get; set; }
        public Guid SubscriberId { get; set; }

        public IsUserSubscribedQuery(Guid subscriberId, Guid userId)
        {
            SubscriberId = subscriberId;
            UserId = userId;
        }
    }
}
