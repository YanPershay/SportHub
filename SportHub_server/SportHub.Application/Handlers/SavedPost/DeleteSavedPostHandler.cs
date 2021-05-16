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
    public class DeleteSavedPostHandler : IRequestHandler<DeleteSavedPostCommand, int>
    {
        private readonly ISavedPostRepository _savedPostRepository;

        public DeleteSavedPostHandler(ISavedPostRepository savedPostRepository)
        {
            _savedPostRepository = savedPostRepository;
        }

        public async Task<int> Handle(DeleteSavedPostCommand request, CancellationToken cancellationToken)
        {
            var savedPostEntity = SavedPostMapper.Mapper.Map<SavedPost>(request);

            if (savedPostEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            await _savedPostRepository.DeleteAsync(savedPostEntity);
            return savedPostEntity.Id;
        }
    }
}
