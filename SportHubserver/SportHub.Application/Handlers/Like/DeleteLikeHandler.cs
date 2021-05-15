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
    public class DeleteLikeHandler : IRequestHandler<DeleteLikeCommand, int>
    {
        private readonly ILikeRepository _likeRepository;

        public DeleteLikeHandler(ILikeRepository likeRepository)
        {
            _likeRepository = likeRepository;
        }

        public async Task<int> Handle(DeleteLikeCommand request, CancellationToken cancellationToken)
        {
            var likeEntity = LikeMapper.Mapper.Map<Like>(request);

            if (likeEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            await _likeRepository.DeleteAsync(likeEntity);
            return likeEntity.Id;
        }

    }
}
