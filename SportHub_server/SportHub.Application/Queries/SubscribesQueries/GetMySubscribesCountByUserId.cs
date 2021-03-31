using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    class GetMySubscribesCountByUserId : IRequest<int>
    {
        public Guid SubscriberId { get; set; }

        public GetMySubscribesCountByUserId(Guid subscriberId)
        {
            SubscriberId = subscriberId;
        }
    }
}
