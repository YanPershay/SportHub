using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.SubscribesQueries
{
    public class GetSubscribeObjectQuery : IRequest<SubscribeObjectResponse>
    {
        //public int Id { get; set; }
        public Guid SubscriberId { get; set; }
        public Guid UserId { get; set; }

        public GetSubscribeObjectQuery(Guid subscriberId, Guid userId)
        {
            //Id = id;
            UserId = userId;
            SubscriberId = subscriberId;
        }
    }
}
