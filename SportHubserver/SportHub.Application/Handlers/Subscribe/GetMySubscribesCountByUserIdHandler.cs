using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries.SubscribesQueries;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class GetMySubscribesCountByUserIdHandler : IRequestHandler<GetMySubscribesCountByUserIdQuery, int>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public GetMySubscribesCountByUserIdHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<int> Handle(GetMySubscribesCountByUserIdQuery request, CancellationToken cancellationToken)
        {
            var subscribersCount = await _subscribeRepository.GetMySubscribesCountByUserId(request.SubscriberId);
            var subscribersCountResponse = SubscribeMapper.Mapper.Map<int>(subscribersCount);
            return subscribersCountResponse;
        }
    }
}
