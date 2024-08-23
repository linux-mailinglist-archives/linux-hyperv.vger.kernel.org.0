Return-Path: <linux-hyperv+bounces-2812-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035895C4FA
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 07:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292801F25543
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 05:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18B4DA00;
	Fri, 23 Aug 2024 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="hArhfTxu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961F8493;
	Fri, 23 Aug 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392013; cv=none; b=eEvElwsgDyDJ85MNOqx/qOrNAgcL8VJLWLOcMigszX7WdZeoJ4rTOv1lrpwxmMwBchU/6k1+dDYh4Fz0lwrriroODWBU6RouK3wHC0JRVGQdvcrHzec++R2RCXprYIX05ofy6E0riVSwLgsHiL+M2OjP01B23tAvht574631Da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392013; c=relaxed/simple;
	bh=j0J+gRKI1Fa1LARPANHyNgvIF1RrlyUDQWkIFewK1/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8dLNHJJXuQZPbarPBzlKqD+rlusgB7AVZPtoYAnyNGempElqZeDmQuNVFRMrtw8YavMevn+D4KpftMOmLT0G6ng7rzyDPKnnlSOMl3cDiY3LLfkQpLiHPm7Zld+hVuJEDssaw8hObopvyGJEmsRWx5MfB8N/klmeayLYWWzbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=hArhfTxu; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8F2631EF9C3;
	Fri, 23 Aug 2024 07:46:47 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724392007; bh=uNgK0Dw8bT4+ACHl9uiGmvZCvs2LRUQX0MM+PNrbWDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hArhfTxuJpmZy/QI44DOLL8nlhwSAV1Q8F1UtEyCSO5NL1kCOZK6ttzq/lQiWWDqe
	 kAiqXcUX5Po+oc4guRJNR8VCytBV0GoIM2NaVIfE9ooBlwUyBeVBRcCHgLCa1XUNpS
	 KehaezkcyCG6ZTGnxI8d5B4GMWWpoTVhQlHWNxUk1wxxYpQtFuY3zWJbyWloHjiXrb
	 luYwVGbGGPSdYtkVoJPjiA+jn+VuH+uHgwOZlATHnVlx+rftiKDO5m0Q0NdsrVZ2PL
	 5/FERS4zek5TReS9TUqMY7iJAHXNDkTNeDv5Xjyc1cljzjV9w2UCy2gEcke3KP2VBA
	 PmNuoJAC7O28Q==
Date: Fri, 23 Aug 2024 07:46:46 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Bart Van Assche <bvanassche@acm.org>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240823074646.555009d6@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<f8bb65ed-cdf2-4d23-b794-765ce0b48a4b@acm.org>
	<SN6PR02MB41577F000FD7A5EC70CF54D0D4882@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 02:20:41 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Bart Van Assche <bvanassche@acm.org> Sent: Thursday, August 22, 2024 12:29 PM
> > 
> > On 8/22/24 11:37 AM, mhkelley58@gmail.com wrote:  
> > > Linux device drivers may make DMA map/unmap calls in contexts that
> > > cannot block, such as in an interrupt handler.  
> > 
> > Although I really appreciate your work, what alternatives have been
> > considered? How many drivers perform DMA mapping from atomic context?
> > Would it be feasible to modify these drivers such that DMA mapping
> > always happens in a context in which sleeping is allowed?
> >   
> 
> I had assumed that allowing DMA mapping from interrupt context is a
> long-time fundamental requirement that can't be changed.  It's been
> allowed at least for the past 20 years, as Linus added this statement to
> kernel documentation in 2005:
> 
>    The streaming DMA mapping routines can be called from interrupt context.
> 
> But I don't have any idea how many drivers actually do that. There are
> roughly 1700 call sites in kernel code/drivers that call one of the
> dma_map_*() variants, so looking through them all doesn't seem
> feasible.

Besides, calls from interrupt context are not the only calls which are
not allowed to schedule (e.g. lock nesting comes to mind). Even if we
agreed to make DMA mapping routines blocking, I believe the easiest way
would be to start adding DMA_ATTR_MAY_BLOCK until it would be used by
all drivers. ;-)

But most importantly, if streaming DMA could block, there would be no
need for a SWIOTLB, because you could simply allocate a bounce buffer
from the buddy allocator when it's needed.

Petr T

