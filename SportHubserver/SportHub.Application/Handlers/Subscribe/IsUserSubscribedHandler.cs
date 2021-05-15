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
    public class IsUserSubscribedHandler : IRequestHandler<IsUserSubscribedQuery, bool>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public IsUserSubscribedHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<bool> Handle(IsUserSubscribedQuery request, CancellationToken cancellationToken)
        {
            var isSubscribed = await _subscribeRepository.IsUserSubscribed(request.SubscriberId, request.UserId);
            var isSubscribeResponse = SubscribeMapper.Mapper.Map<bool>(isSubscribed);
            return isSubscribeResponse;
        }
    }
}
