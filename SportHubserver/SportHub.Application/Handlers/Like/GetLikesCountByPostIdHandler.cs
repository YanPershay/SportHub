using MediatR;
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
    public class GetLikesCountByPostIdHandler : IRequestHandler<GetLikesCountByPostIdQuery, int>
    {
        private readonly ILikeRepository _likeRepository;

        public GetLikesCountByPostIdHandler(ILikeRepository likeRepository)
        {
            _likeRepository = likeRepository;
        }

        public async Task<int> Handle(GetLikesCountByPostIdQuery request, CancellationToken cancellationToken)
        {
            var likesCount = await _likeRepository.GetLikesCountByPostIdAsync(request.PostId);
            var likesCountResponse = LikeMapper.Mapper.Map<int>(likesCount);
            return likesCountResponse;
        }
    }
}
