using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries.SubscribesQueries;
using SportHub.Application.Responses;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class GetSubscribersCountByUserIdHandler : IRequestHandler<GetSubscribersCountByUserIdQuery, int>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public GetSubscribersCountByUserIdHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<int> Handle(GetSubscribersCountByUserIdQuery request, CancellationToken cancellationToken)
        {
            var subscribersCount = await _subscribeRepository.GetSubscribersCountByUserId(request.UserId);
            var subscribersCountResponse = SubscribeMapper.Mapper.Map<int>(subscribersCount);
            return subscribersCountResponse;
        }
    }
}
