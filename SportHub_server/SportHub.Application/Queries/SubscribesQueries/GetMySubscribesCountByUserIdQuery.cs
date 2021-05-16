using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    public class GetMySubscribesCountByUserIdQuery : IRequest<int>
    {
        public Guid SubscriberId { get; set; }

        public GetMySubscribesCountByUserIdQuery(Guid subscriberId)
        {
            SubscriberId = subscriberId;
        }
    }
}
