using MediatR;
using SportHub.Application.Commands;
using SportHub.Application.Mappers;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class UnsubscribeHandler : IRequestHandler<UnsubscribeCommand, int>
    {
        private readonly ISubscribeRepository _subscribeRepository;

        public UnsubscribeHandler(ISubscribeRepository subscribeRepository)
        {
            _subscribeRepository = subscribeRepository;
        }

        public async Task<int> Handle(UnsubscribeCommand request, CancellationToken cancellationToken)
        {
            var subEntity = SubscribeMapper.Mapper.Map<Subscribe>(request);

            if (subEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            await _subscribeRepository.DeleteAsync(subEntity);
            return subEntity.Id;
        }
    }
}
