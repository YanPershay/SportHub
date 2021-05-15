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
    public class GetSubscribersByUserIdHandler : IRequestHandler<GetSubscribersByUserIdQuery, IEnumerable<SubscribeResponse>>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public GetSubscribersByUserIdHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<IEnumerable<SubscribeResponse>> Handle(GetSubscribersByUserIdQuery request, CancellationToken cancellationToken)
        {
            var subscribe = await _subscribeRepository.GetSubscribersByUserId(request.UserId);
            var subscribeResponse = SubscribeMapper.Mapper.Map<IEnumerable<SubscribeResponse>>(subscribe);
            return subscribeResponse;
        }
    }
}
