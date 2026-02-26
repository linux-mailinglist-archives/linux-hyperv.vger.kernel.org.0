Return-Path: <linux-hyperv+bounces-8996-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDKLESPun2nYewQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8996-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 07:54:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C31A176D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 07:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC19300E717
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E325938BF67;
	Thu, 26 Feb 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKW7n9zF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E838B7B7;
	Thu, 26 Feb 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088848; cv=none; b=VM4e4JTI9nu3h1N9sgoaTppnftVAL3Qj58iaoyicK+xvVbqkgEffIAXRMHuJl1DVGrp0YrWuzzQOOYW1/WsQvchk4oHO44dLsfS+r/L1fp4Ob6+JtY31t+yeHLMhelEmuyW1a6iw00shEMMvSPx1+NLb/PRORBURFvU+ReQ0P1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088848; c=relaxed/simple;
	bh=6wP04o8J/I3iQSrV6t04KpfXZMm7q3Dov8vdpAFTXSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdbEf8VYW98+T+5OyieS4hgheQcb5lnlIPh6xxTU4dLCLWd8H9q31nAwz5weQ2A2eDG4XdupXUlAwmRx0fnHDgE3Xy6SBVLEN/QpH4nKvM7Yd2eO2KsAc6yhXHjm3GuYx4+Vd5+0zEJIscOJcsCIIMHEiqL/N+uckJbyXuRmT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKW7n9zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD0AC19422;
	Thu, 26 Feb 2026 06:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772088848;
	bh=6wP04o8J/I3iQSrV6t04KpfXZMm7q3Dov8vdpAFTXSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKW7n9zFwdS8zU411mBQS86BhhwIc9msdiNSFTEJu53jvPmZfWzljbggV7CId+s2N
	 LMpqlT3+pWskQ0IjAMizG4f4eJ0rRrXIg45hVdEw7p7RQyCrZd2OJrBIORkgIiVK+6
	 +mhR+U38x9ByuGSOIYdrWPcxK2Yrg3mmfEvqHpBloFYFvbFGA5IdBUhEDR9Y8rYiSu
	 iShDfdkyP30ZJ71ymG+uYY5Jxtbt9gAeOqbVjAYZEVaq6/VAF2UeEwGEtFgtPPcBXF
	 zf6SGqDBRVduEwws8KG9LKyqROK+SQB/nD0IaR/tgc3NqWg/a56aIB2GamKio35H+0
	 mg9//hERz7DyA==
Date: Thu, 26 Feb 2026 08:54:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
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
Subject: Re: [PATCH rdma-next 26/50] RDMA/erdma: Separate user and kernel CQ
 creation paths
Message-ID: <20260226065404.GB12611@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-26-f3be85847922@nvidia.com>
 <ce205a5a-0b10-449e-0a84-39d3f43aeb53@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce205a5a-0b10-449e-0a84-39d3f43aeb53@hisilicon.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8996-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F9C31A176D
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:17:38PM +0800, Junxian Huang wrote:
> 
> 
> On 2026/2/13 18:58, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Split CQ creation into distinct kernel and user flows. The hns driver,
> > inherited from mlx4, uses a problematic pattern that shares and caches
> > umem in hns_roce_db_map_user(). This design blocks the driver from
> > supporting generic umem sources (VMA, dmabuf, memfd, and others).
> > 
> > In addition, let's delete counter that counts CQ creation errors. There
> > are multiple ways to debug kernel in modern kernel without need to rely
> > on that debugfs counter.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_cq.c      | 103 ++++++++++++++++++++-------
> >  drivers/infiniband/hw/hns/hns_roce_debugfs.c |   1 -
> >  drivers/infiniband/hw/hns/hns_roce_device.h  |   3 +-
> >  drivers/infiniband/hw/hns/hns_roce_main.c    |   1 +
> >  4 files changed, 82 insertions(+), 26 deletions(-)

<...>

> > +int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
> > +		       struct uverbs_attr_bundle *attrs)
> > +{
> > +	struct hns_roce_dev *hr_dev = to_hr_dev(ib_cq->device);
> > +	struct hns_roce_ib_create_cq_resp resp = {};
> > +	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
> > +	struct ib_device *ibdev = &hr_dev->ib_dev;
> > +	struct hns_roce_ib_create_cq ucmd = {};
> 
> ucmd and resp are not needed since we don't have udata here.

Thanks, will fix.

> 
> Junxian

