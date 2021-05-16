using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries.SubscribesQueries;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class GetSubscriptionsCountHandler : IRequestHandler<GetSubscriptionsCountByUserIdQuery, SubscriptionsCountResponse>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public GetSubscriptionsCountHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<SubscriptionsCountResponse> Handle(GetSubscriptionsCountByUserIdQuery request, CancellationToken cancellationToken)
        {
            var subscribersCount = await _subscribeRepository.GetSubscriptionsCountByUserId(request.UserId);
            var subscribersCountResponse = SubscriptionsCountMapper.Mapper.Map<SubscriptionsCountResponse>(subscribersCount);
            return subscribersCountResponse;
        }
    }
}
