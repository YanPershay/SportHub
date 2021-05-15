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
    public class GetTrainerPostsHandler : IRequestHandler<GetTrainerPostsQuery, IEnumerable<TrainerPostResponse>>
    {
        private readonly ITrainerPostRepository _adminPostRepository;

        public GetTrainerPostsHandler(ITrainerPostRepository adminPostRepository)
        {
            _adminPostRepository = adminPostRepository;
        }

        public async Task<IEnumerable<TrainerPostResponse>> Handle(GetTrainerPostsQuery request, CancellationToken cancellationToken)
        {
            var adminPost = await _adminPostRepository.GetTrainerPostsAsync();
            var adminPostResponse = TrainerPostMapper.Mapper.Map<IEnumerable<TrainerPostResponse>>(adminPost);
            return adminPostResponse;
        }
    }
}
