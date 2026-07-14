Return-Path: <linux-hyperv+bounces-11972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HeXWIyDdVWoqugAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11972-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 08:54:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D81751ADF
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 08:54:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=md00VrpU;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11972-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11972-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D48430463C1
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DFC3EA94A;
	Tue, 14 Jul 2026 06:54:21 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81943DA5C8;
	Tue, 14 Jul 2026 06:54:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784012060; cv=none; b=cGiIoBUQE0FdUfPAtqAB4dDCY+eKlAUXPjIRgsU7vTiMTGQJ2EWRcPmPKdkIus+2g68wcfh7duZbCiUCEmkxbOYtptlENEKh0+Uk4d9jih7HHyUISnFisHD9gF1ejU6+qAJCk6C9CErHWvUTMgPGtVRhO7OymWfmCbgHRcEhwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784012060; c=relaxed/simple;
	bh=tXtdMeIxXC16lr/HTg6ocj6kC0rh7wMG3yjZKMM4LLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWpxzfTMBg+qkXwl5jjyBdsFt5y2Kzjs0ANM99HA25XifzU4Czw20OIfhdzTDfMekRBm+Q2hjiDRmi7rAW3239Cv6qpXNsW0+ri8k0JzJDaA91dUVxt0of2fb6SbOlzic3xBu7dosfbsZhmi9ERNE5s4S2pLsPd+i8hQSgVG5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md00VrpU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4089E1F000E9;
	Tue, 14 Jul 2026 06:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784012059;
	bh=WBWfeyGDRmTf2+ZEY/DTuUFTz2+R4bqzLx7X051fex8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=md00VrpUzYZfZMnKJO9JzpUhNtP0D3OScAk6Dgj22VEjjhgzhyrL3QjJAOATXPH+/
	 PxOHsG0pBryfZKpKhernt7ta8SPxZyq5IbEgE1HXz/fiGP2D1yxOLy8R95O0b+c042
	 2mkksHMIUsgfzEfbeC+rap2vNWkSNWp4WLlC/a7z6AOpz6Safeo2zqbm3z6we9JS6H
	 na9S6GpSrN9mHF72ZxFGk5u2IdYHVEH/htUiZBzuhBs0IRza4K96lP1zC8DdSrrE9C
	 1Oi3tmHhGT2mSl65s1wN5VWcKu57drtTaTvQWnEMUje2NFGKxDDfR08aIPpEgOcK2R
	 DTxgvTnMSrynQ==
Date: Tue, 14 Jul 2026 09:54:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Bernard Metzler <bernard.metzler@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/2] RDMA: Small batch of cleanups
Message-ID: <20260714065414.GA19233@unreal>
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:mrgolin@amazon.com,m:gal.pressman@linux.dev,m:sleybo@amazon.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:yishaih@nvidia.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bernard.metzler@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11972-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0D81751ADF

On Mon, Jul 13, 2026 at 11:10:33AM +0300, Leon Romanovsky wrote:
> This series contains two independent cleanups. One fixes the problematic placemen
>  of a newly introduced in-kernel API, which should be called at the beginning of
> destroy functions and not at the end. The other removes a redundant memset().
> 
> Thanks.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Leon Romanovsky (2):
>       RDMA/bnxt_re: Validate udata before destroying resources

I'll resend this one.

>       RDMA: Remove redundant memset() from query_device callbacks

And applied this.

