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
    public class CreateTrainerPostHandler : IRequestHandler<CreateTrainerPostCommand, TrainerPostResponse>
    {
        private readonly ITrainerPostRepository _trainerPostRepository;

        public CreateTrainerPostHandler(ITrainerPostRepository trainerPostRepository)
        {
            _trainerPostRepository = trainerPostRepository;
        }

        public async Task<TrainerPostResponse> Handle(CreateTrainerPostCommand request, CancellationToken cancellationToken)
        {
            var trainerPostEntity = TrainerPostMapper.Mapper.Map<TrainerPost>(request);

            if(trainerPostEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newTrainerPost = await _trainerPostRepository.AddAsync(trainerPostEntity);
            var trainerPostResponse = TrainerPostMapper.Mapper.Map<TrainerPostResponse>(newTrainerPost);
            return trainerPostResponse;
        }
    }
}
