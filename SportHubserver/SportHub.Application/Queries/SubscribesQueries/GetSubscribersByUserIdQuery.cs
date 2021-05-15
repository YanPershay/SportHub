using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    public class GetSubscribersByUserIdQuery : IRequest<IEnumerable<SubscribeResponse>>
    {
        public Guid UserId { get; set; }

        public GetSubscribersByUserIdQuery(Guid userId)
        {
            UserId = userId;
        }
    }
}
