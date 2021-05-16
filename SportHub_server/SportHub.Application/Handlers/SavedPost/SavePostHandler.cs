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
    public class SavePostHandler : IRequestHandler<SavePostCommand, SavedPostResponse>
    {
        private readonly ISavedPostRepository _savedPostRepository;

        public SavePostHandler(ISavedPostRepository savedPostRepository)
        {
            _savedPostRepository = savedPostRepository;
        }

        public async Task<SavedPostResponse> Handle(SavePostCommand request, CancellationToken cancellationToken)
        {
            var savedPostEntity = SavedPostMapper.Mapper.Map<SavedPost>(request);

            if (savedPostEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newSavedPost = await _savedPostRepository.AddAsync(savedPostEntity);
            var savedPostResponse = SavedPostMapper.Mapper.Map<SavedPostResponse>(newSavedPost);
            return savedPostResponse;
        }
    }
}
