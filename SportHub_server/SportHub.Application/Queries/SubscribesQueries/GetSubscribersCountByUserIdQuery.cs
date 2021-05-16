using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    public class GetSubscribersCountByUserIdQuery : IRequest<int>
    {
        public Guid UserId { get; set; }

        public GetSubscribersCountByUserIdQuery(Guid userId)
        {
            UserId = userId;
        }
    }
}
