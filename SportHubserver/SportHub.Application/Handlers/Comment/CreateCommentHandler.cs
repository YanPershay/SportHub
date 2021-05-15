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
    public class CreateCommentHandler : IRequestHandler<CreateCommentCommand, CommentResponse>
    {
        private readonly ICommentRepository _commentRepository;

        public CreateCommentHandler(ICommentRepository commentRepository)
        {
            _commentRepository = commentRepository;
        }

        public async Task<CommentResponse> Handle(CreateCommentCommand request, CancellationToken cancellationToken)
        {
            var commentEntity = CommentMapper.Mapper.Map<Comment>(request);

            if (commentEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newComment = await _commentRepository.AddAsync(commentEntity);
            var commentResponse = CommentMapper.Mapper.Map<CommentResponse>(newComment);
            return commentResponse;
        }
    }
}
