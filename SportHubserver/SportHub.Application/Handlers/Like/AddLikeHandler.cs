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
    public class AddLikeHandler : IRequestHandler<AddLikeCommand, LikeResponse>
    {
        private readonly ILikeRepository _likeRepository;

        public AddLikeHandler(ILikeRepository likeRepository)
        {
            _likeRepository = likeRepository;
        }

        public async Task<LikeResponse> Handle(AddLikeCommand request, CancellationToken cancellationToken)
        {
            var likeEntity = LikeMapper.Mapper.Map<Like>(request);

            if (likeEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newLike = await _likeRepository.AddAsync(likeEntity);
            var likeResponse = LikeMapper.Mapper.Map<LikeResponse>(newLike);
            return likeResponse;
        }
    }
}
