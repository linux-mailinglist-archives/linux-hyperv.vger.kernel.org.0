Return-Path: <linux-hyperv+bounces-8966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFFFJgeCnWlsQQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8966-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 11:48:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351D185A1F
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 11:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8E523008E23
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790423783C7;
	Tue, 24 Feb 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOub5Huj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55345371047;
	Tue, 24 Feb 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929983; cv=none; b=d0FHGimnbKl/cDJ5rxtM7hrzCjs1RBS0iNLFX23o64AEylJhsOl7T4z04vrxbTguyiROFVboZ8449F5PV12owbJEJKhAqllHvERdHmgXv5zw6vmxhBgDwle9PfVbgBFN4MUsTZOCc3NJzxgx+w5UEyeDMzw+wj9NQkRYqGyvjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929983; c=relaxed/simple;
	bh=HoP5fJAicR6teMJFt4DKkW+JkP5LbKRJWcf04vaykBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awaKuXBvTLPSF3qnRANIacI/Prn8lagzyIKDg+Ui6RJQ8sOzd5Ypiraa+p7n5g7XnTXGMLjBn9BxXJGLle8tZqg0kMaNlSy1eL8O9lIBq9JXOUC+lX/G0Z/3OUMfd9aWkn8mPERcJ8ffyMTiGBjEfpPA3QqMU6uxC5G8XXyXlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOub5Huj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D193C116D0;
	Tue, 24 Feb 2026 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771929982;
	bh=HoP5fJAicR6teMJFt4DKkW+JkP5LbKRJWcf04vaykBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOub5HujeTkXdANgJ55GUZ5CYwGpn2k6ytz5eG7oFwOuY7hbxHQRh5j4zzQU+/XG0
	 MDhfvnwuUX5ANryHzTdI3QRXTrmpXCOQyDFUnGyDcgBBvHwUTQ8SB//MuzKNs0Bo1r
	 DX5s8CRkfujyb8ugANRopZsCZgoDtyHb1M2gxFPKy/7Cf7hK7/1D+JaqkfT8bGc4T/
	 2eX9/kXpiY+bewCwWcrAOJMQFLePCShCHOOLMHpTiq71UARwAsEDrostlO/lQFamNr
	 DhtzbsItntd6hU4j4uwpdNMkM3Wom9tQsD8TWWx6zICSrrL7HCRB4opAGVRSUMzVZC
	 LI2Lvo6eSpIUw==
Date: Tue, 24 Feb 2026 12:46:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
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
Subject: Re: [PATCH rdma-next 26/50] RDMA/erdma: Separate user and kernel CQ
 creation paths
Message-ID: <20260224104618.GJ10607@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-26-f3be85847922@nvidia.com>
 <b1070bb3-5963-2e2b-288c-ac5912b6c22e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1070bb3-5963-2e2b-288c-ac5912b6c22e@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8966-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3351D185A1F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:20:39AM +0800, Cheng Xu wrote:
> 
> 
> On 2/13/26 6:58 PM, Leon Romanovsky wrote:
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
> > 
> 
> Hi Leon,
> 
> The driver name in this patch's title should be "RDMA/hns".

Right, thanks

