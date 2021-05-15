using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetMySubscribesByUserIdQuery : IRequest<IEnumerable<SubscribeResponse>>
    {
        public Guid SubscriberId { get; set; }

        public GetMySubscribesByUserIdQuery(Guid subscriberId)
        {
            SubscriberId = subscriberId;
        }
    }
}
