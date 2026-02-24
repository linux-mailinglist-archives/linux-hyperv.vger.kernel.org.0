Return-Path: <linux-hyperv+bounces-8967-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP/jCQmEnWlsQQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8967-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 11:57:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4B185B9C
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43B5C3019535
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E228936B054;
	Tue, 24 Feb 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgyjK4ux"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9512475D0;
	Tue, 24 Feb 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930626; cv=none; b=pzthDYw3QIk2BOhMuufe6OOyNtWWlMSgHUl9uGDrhsHKYif7Lm6Ox4MhKCDiWunYfJcWRsx94FVRkY7RgyAchG5Yf9+jgTOIZN7lzltcqRDVqiHrigqXnahXmZDuP8ubtwSMQlrHTJJs4mr/VKXsonzpppPCw9GzwFLiXCGuZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930626; c=relaxed/simple;
	bh=QHRRjkLHnkq8MZDJ0L/lMCIx215oX0qrtJpIv/OXca8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNUzSm1j7rqiwQHJwj58lBDfSthxVsC17iCgM018J+k4+zzFqm5sboo00eDCnL+UZwD6fhp6wXJDnVALWL9sRWrajoBnpJzZbYR7P8TKBr7w+V8N9Vbw21tjdSSMXDWTZwkk49Ivsdy01YKAGY/uKJu3pR0zwuSpWf+AHucIv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgyjK4ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99EEC116D0;
	Tue, 24 Feb 2026 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930626;
	bh=QHRRjkLHnkq8MZDJ0L/lMCIx215oX0qrtJpIv/OXca8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgyjK4uxgd9Mpz5qz+zQ9ZPRVs3lTWIXr0AXiCHGqQZniuhPKhfmiIz5V0QT7nll/
	 jKyICM8KftI0rjKGe/m6i5kN7zsUb1oxMsXR4LGaEzwhIiL0U+12ZbX4inQ33hD7tx
	 Fut1ZsHj0pMGhZ9mEH5uafeXzEAL0PDL+rZ/gSW+RWEOM7A4rvIWICNn+BT8lB3qRg
	 8ZBxDcrbSD3P2uOC7nv2Nwi7ir4Yjcnmdsb4DmQUMH343DL2QGP+9XX2LkFtAfyjtY
	 7YAm9TXYJmMfJfWEQ0NqDIGPs6PvhfQX7lABRvunFyVenF5EFMxOLUdC56aaoJydHV
	 HRgHYMbBlwhmw==
Date: Tue, 24 Feb 2026 12:57:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH rdma-next 18/50] RDMA/erdma: Separate user and kernel CQ
 creation paths
Message-ID: <20260224105702.GK10607@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-18-f3be85847922@nvidia.com>
 <d21833fa-a737-3b46-dda3-92837f78f8e4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d21833fa-a737-3b46-dda3-92837f78f8e4@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8967-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 7DA4B185B9C
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:51:41PM +0800, Cheng Xu wrote:
> 
> 
> On 2/13/26 6:57 PM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Split CQ creation into distinct kernel and user flows. The erdma driver,
> > inherited from mlx4, uses a problematic pattern that shares and caches
> > umem in erdma_map_user_dbrecords(). This design blocks the driver from
> > supporting generic umem sources (VMA, dmabuf, memfd, and others).
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/erdma/erdma_main.c  |  1 +
> >  drivers/infiniband/hw/erdma/erdma_verbs.c | 97 ++++++++++++++++++++-----------
> >  drivers/infiniband/hw/erdma/erdma_verbs.h |  2 +
> >  3 files changed, 67 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> > index f35b30235018..1b6426e89d80 100644
> > --- a/drivers/infiniband/hw/erdma/erdma_main.c
> > +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> > @@ -505,6 +505,7 @@ static const struct ib_device_ops erdma_device_ops = {
> >  	.alloc_pd = erdma_alloc_pd,
> >  	.alloc_ucontext = erdma_alloc_ucontext,
> >  	.create_cq = erdma_create_cq,
> > +	.create_user_cq = erdma_create_user_cq,
> >  	.create_qp = erdma_create_qp,
> >  	.dealloc_pd = erdma_dealloc_pd,
> >  	.dealloc_ucontext = erdma_dealloc_ucontext,
> 
> <...>
> 
> > +
> > +int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > +		    struct uverbs_attr_bundle *attrs)
> 
> create_cq will be used for kernel CQ creation, and the third input parameter
> 'struct uverbs_attr_bundle *attrs' will be useless, so it can be removed? Same to
> all drivers.

Yes, but only after conversion of all drivers. I have that removal patch
in my v2.

> 
> 
> > +{
> 
> <...>
> 
> > +	ret = create_cq_cmd(NULL, cq);
> > +	if (ret)
> > +		goto err_free_res;
> 
> 
> In create_cq_cmd, should add the following change:

I took slightly different approach and inlined create_cq_cmd() into erdma_create_*_cq().

Thanks

> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 8c30df61ae3d..eca28524e04b 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -240,7 +240,7 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
>                 req.first_page_offset = mem->page_offset;
>                 req.cq_dbrec_dma = cq->user_cq.dbrec_dma;
>  
> -               if (uctx->ext_db.enable) {
> +               if (uctx && uctx->ext_db.enable) {
>                         req.cfg1 |= FIELD_PREP(
>                                 ERDMA_CMD_CREATE_CQ_MTT_DB_CFG_MASK, 1);
>                         req.cfg2 = FIELD_PREP(ERDMA_CMD_CREATE_CQ_DB_CFG_MASK,
> 
> 
> Thanks,
> Cheng Xu
> 

