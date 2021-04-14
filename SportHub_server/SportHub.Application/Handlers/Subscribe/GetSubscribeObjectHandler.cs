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
    public class GetSubscribeObjectHandler : IRequestHandler<GetSubscribeObjectQuery, SubscribeObjectResponse>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public GetSubscribeObjectHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<SubscribeObjectResponse> Handle(GetSubscribeObjectQuery request, CancellationToken cancellationToken)
        {
            var subscribeObj = await _subscribeRepository.GetSubscribeObject(request.SubscriberId, request.UserId);
            var subscribeObjResponse = SubscribeObjectMapper.Mapper.Map<SubscribeObjectResponse>(subscribeObj);
            return subscribeObjResponse;
        }
    }
}
