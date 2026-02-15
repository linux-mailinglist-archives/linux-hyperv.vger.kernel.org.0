Return-Path: <linux-hyperv+bounces-8857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKVMLmtwkWnOigEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8857-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Feb 2026 08:06:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E1013E2D9
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Feb 2026 08:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD9253002F7E
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Feb 2026 07:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01028244675;
	Sun, 15 Feb 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMx7KEnM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF217993;
	Sun, 15 Feb 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771139174; cv=none; b=WMvztaYU56wzTY4+r1F4CraRpO619x7iHdlJWKKedEA6aYR8CdYAvQpgMyjLj+dHvrW7geV+BLTo8ipAHUeIiiHLqLbE97vMzAJMn8RajEYpgpuWi3YcBp8G5+/KZiG1OGPPp4cnPE+iuo5eqEWryJIJqHVSGuofRn3WkNv63Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771139174; c=relaxed/simple;
	bh=YcTAU9BUNbHhzUc4v6zujt0b+hevJHKAHNMpsWwE8gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZK2bg4MW+hDuGnl8KZ5D4+nGbPKeEwZqBblNPgACX8xKYblGjATRR6WWsGke07gUvdFTup+KsgmLt+OVEvmMaFDI4slTJfyoBQYrIoQSntInrGcm2p7LS/aTlM1XvzA3I2px5t92GRokdeKfCdbTl04L7VRa36GgRHQCrO2UgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMx7KEnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6A8C4CEF7;
	Sun, 15 Feb 2026 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771139174;
	bh=YcTAU9BUNbHhzUc4v6zujt0b+hevJHKAHNMpsWwE8gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMx7KEnMfzch0QVhOSk5y9VXkH7cpo+uvYjuasm5c6RC/ZBdHVH4SHkRhzi34R6fS
	 CdhTIyf//nmbRsYDkd0NGjmj6/FcexywTjjEP7nyQg7xcMLm3nkSWzwEAhpBT7SdWf
	 U0WQWU/FRD6lG5jQnwieOfXD2g4/yI99l/Pcl52P1PE4GywLQG+eLoNBYrunXqxjrJ
	 DB4eSAKG8st/Z3kyFPN/zUWMeB8smqlD8BKR9MEXvB25rXYP8X80jWKpJhkVe+/efn
	 EQqtB0YoZvatd8HjGEwb6N6eqlg9q3E2GILFHjIys9uC6gqHs3N5JdMz1frgw7SAIe
	 c5BLzUTmjwrOA==
Date: Sun, 15 Feb 2026 09:06:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH rdma-next 29/50] RDMA/rxe: Split user and kernel CQ
 creation paths
Message-ID: <20260215070609.GB691383@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-29-f3be85847922@nvidia.com>
 <459a01fe-8f23-4114-a127-98ec95c53464@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459a01fe-8f23-4114-a127-98ec95c53464@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8857-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4E1013E2D9
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 03:22:13PM -0800, yanjun.zhu wrote:
> On 2/13/26 2:58 AM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Separate the CQ creation logic into distinct kernel and user flows.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_verbs.c | 81 ++++++++++++++++++++---------------
> >   1 file changed, 47 insertions(+), 34 deletions(-)

<...>

> > +	if (err)
> > +		return err;
> >   	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
> >   			       uresp);
> 
> Neither rxe_create_user_cq() nor rxe_create_cq() explicitly validates
> attr->comp_vector. Is this guaranteed to be validated by the core before
> reaching the driver, or should rxe still enforce device-specific limits?

We should validate it in IB/core level.
https://github.com/linux-rdma/rdma-core/blob/8b9cdb7c6bd2b6e4e64e08888c10124b0d1873f2/libibverbs/man/ibv_create_cq.3#L32
.I comp_vector
for signaling completion events; it must be at least zero and less than
.I context\fR->num_comp_vectors.

> 
> > -	if (err) {
> > -		rxe_dbg_cq(cq, "create cq failed, err = %d\n", err);
> > +	if (err)
> >   		goto err_cleanup;
> 
> The err_cleanup label is only used for this specific error path. It may
> improve readability to inline the cleanup logic at this site and remove the
> label altogether.

Ill delete. Thanks

