Return-Path: <linux-hyperv+bounces-8963-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN67Mnw8nWkGNwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8963-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 06:51:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6A182355
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 06:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EAD430193BD
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591AC2C326D;
	Tue, 24 Feb 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DkJe7ctG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A624E4A8;
	Tue, 24 Feb 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771912313; cv=none; b=u6RRoSzcc/wCeYanPAPqy5Cl8fv4i1IvCNFotlefV14ENl64hwyXrMMau25ByQNhOZOui+zt8FmlQ4F5dA46a4QnYCAuiI1KaqDZHUCH6yjHinR4z1TrD9A9v+cndpM0tYGNyYyRF0yBkj+qdTgBJyUKO+mJUFBWwjk6f7a/mpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771912313; c=relaxed/simple;
	bh=D8vFqNbIpPoOn3lNTUag9V78b9gUEZkWAiaBeStIVdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeXUpVhGaVZCmMeloXi2dLvMdo9LfNfoc8ucVanhsd3bwrNgEakyZUTVlEgFHyczyO5xNFc1GWtGWfX1DYRutZHHa/Q5e3sWDsRqe85Sqll8zCWButlZoAqVdvtbd73EV1sqj3kMm2vhY2XlVzZr8/YEAkj0tMueDKny8HAXE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DkJe7ctG; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771912303; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OEFxQwI+FVyJX8a4PDqTWWrAIpE78uEwzcxgoFGvbrs=;
	b=DkJe7ctGcHvn4HEE1i424+hJPxrRtgp7sDBQfZvy8mxN1f9TuFVRcuRAM6j9H2XoktCXr/GPpcjhMN2LJj5PTGYMW3qsiw3oFtcFPJLJAUwM5XTWpJsvizV97b44h2oZknAPPg6pUxGn/WNv6nunQubItWv4GeMUYtsJYo0Rsy0=
Received: from 30.221.115.171(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WziN6.B_1771912302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 13:51:42 +0800
Message-ID: <d21833fa-a737-3b46-dda3-92837f78f8e4@linux.alibaba.com>
Date: Tue, 24 Feb 2026 13:51:41 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next 18/50] RDMA/erdma: Separate user and kernel CQ
 creation paths
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-18-f3be85847922@nvidia.com>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20260213-refactor-umem-v1-18-f3be85847922@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8963-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengyou@linux.alibaba.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 44B6A182355
X-Rspamd-Action: no action



On 2/13/26 6:57 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Split CQ creation into distinct kernel and user flows. The erdma driver,
> inherited from mlx4, uses a problematic pattern that shares and caches
> umem in erdma_map_user_dbrecords(). This design blocks the driver from
> supporting generic umem sources (VMA, dmabuf, memfd, and others).
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_main.c  |  1 +
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 97 ++++++++++++++++++++-----------
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  2 +
>  3 files changed, 67 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> index f35b30235018..1b6426e89d80 100644
> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -505,6 +505,7 @@ static const struct ib_device_ops erdma_device_ops = {
>  	.alloc_pd = erdma_alloc_pd,
>  	.alloc_ucontext = erdma_alloc_ucontext,
>  	.create_cq = erdma_create_cq,
> +	.create_user_cq = erdma_create_user_cq,
>  	.create_qp = erdma_create_qp,
>  	.dealloc_pd = erdma_dealloc_pd,
>  	.dealloc_ucontext = erdma_dealloc_ucontext,

<...>

> +
> +int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +		    struct uverbs_attr_bundle *attrs)

create_cq will be used for kernel CQ creation, and the third input parameter
'struct uverbs_attr_bundle *attrs' will be useless, so it can be removed? Same to
all drivers.


> +{

<...>

> +	ret = create_cq_cmd(NULL, cq);
> +	if (ret)
> +		goto err_free_res;


In create_cq_cmd, should add the following change:

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 8c30df61ae3d..eca28524e04b 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -240,7 +240,7 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
                req.first_page_offset = mem->page_offset;
                req.cq_dbrec_dma = cq->user_cq.dbrec_dma;
 
-               if (uctx->ext_db.enable) {
+               if (uctx && uctx->ext_db.enable) {
                        req.cfg1 |= FIELD_PREP(
                                ERDMA_CMD_CREATE_CQ_MTT_DB_CFG_MASK, 1);
                        req.cfg2 = FIELD_PREP(ERDMA_CMD_CREATE_CQ_DB_CFG_MASK,


Thanks,
Cheng Xu


