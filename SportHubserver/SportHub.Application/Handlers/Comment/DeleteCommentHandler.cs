using MediatR;
using SportHub.Application.Commands;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class DeleteCommentHandler : IRequestHandler<DeleteCommentCommand, int>
    {
        private readonly ICommentRepository _commentRepository;

        public DeleteCommentHandler(ICommentRepository commentRepository)
        {
            _commentRepository = commentRepository;
        }

        public async Task<int> Handle(DeleteCommentCommand request, CancellationToken cancellationToken)
        {
            var comment = await _commentRepository.GetByIdAsync(request.Id);

            await _commentRepository.DeleteAsync(comment);
            return comment.Id;
        }
    }
}
