using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.PostQueries
{
    public class GetSubscribesPostsQuery : IRequest<IEnumerable<PostResponse>>
    {
        public Guid SubscriberId { get; set; }
        public GetSubscribesPostsQuery(Guid subscriberId)
        {
            SubscriberId = subscriberId;
        }
    }
}
