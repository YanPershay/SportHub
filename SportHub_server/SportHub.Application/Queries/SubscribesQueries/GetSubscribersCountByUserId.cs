using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    public class GetSubscribersCountByUserId : IRequest<int>
    {
        public Guid UserId { get; set; }

        public GetSubscribersCountByUserId(Guid userId)
        {
            UserId = userId;
        }
    }
}
