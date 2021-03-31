using MediatR;
using SportHub.Application.Commands;
using SportHub.Application.Mappers;
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
    public class SubscribeToUserHandler : IRequestHandler<SubscribeToUserCommand, SubscribeResponse>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public SubscribeToUserHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<SubscribeResponse> Handle(SubscribeToUserCommand request, CancellationToken cancellationToken)
        {
            var subscribeEntity = SubscribeMapper.Mapper.Map<Subscribe>(request);

            if (subscribeEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newSubscribe = await _subscribeRepository.AddAsync(subscribeEntity);
            var subscribeResponse = SubscribeMapper.Mapper.Map<SubscribeResponse>(newSubscribe);
            return subscribeResponse;
        }
    }
}
