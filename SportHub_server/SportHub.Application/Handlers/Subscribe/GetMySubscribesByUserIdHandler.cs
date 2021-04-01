using MediatR;
using SportHub.Application.Commands;
using SportHub.Application.Mappers;
using SportHub.Application.Queries;
using SportHub.Application.Responses;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class GetMySubscribesByUserIdHandler : IRequestHandler<GetMySubscribesByUserIdQuery, IEnumerable<SubscribeResponse>>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public GetMySubscribesByUserIdHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<IEnumerable<SubscribeResponse>> Handle(GetMySubscribesByUserIdQuery request, CancellationToken cancellationToken)
        {
            var subscribe = await _subscribeRepository.GetMySubscribesByUserId(request.SubscriberId);
            var subscribeResponse = SubscribeMapper.Mapper.Map<IEnumerable<SubscribeResponse>>(subscribe);
            return subscribeResponse;
        }
    }
}
