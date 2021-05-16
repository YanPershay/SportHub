using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    public class GetSubscriptionsCountByUserIdQuery : IRequest<SubscriptionsCountResponse>
    {
        public Guid UserId { get; set; }

        public GetSubscriptionsCountByUserIdQuery(Guid userId)
        {
            UserId = userId;
        }
    }
}

