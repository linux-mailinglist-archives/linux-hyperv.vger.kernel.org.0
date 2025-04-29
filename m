Return-Path: <linux-hyperv+bounces-5218-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD8AA0638
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC233BC9D3
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266529C340;
	Tue, 29 Apr 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cgjw/DkY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E9296D05;
	Tue, 29 Apr 2025 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916686; cv=none; b=k3rF/+/BbdtIYxAmWDaxmMjFX7+J9vK5cOMjD2m9du5ht/b9zADQItDL3XXBXv1w+/7EVso7GDE3qkkd6L+5Q75w35ZENM9mSj2gQEgidapgGO/eu5nOik5Aqvcn6balSwGYs67gTHY3F7OCOMuq/qCY1pxaHQEch6Jf5VjZHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916686; c=relaxed/simple;
	bh=i/zN+eLtunYqB8Jo8o4ZtByDNbSfXn6uTc2DKMgPDy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaAVX2F6QANt9Ad88eKir1Yk9KdmAIZ84Avy6sBcbHYKEkrFhw+ElAr/EvQxRR6GK1Pq44gorIKACdKK1OZH1X0+kGFYgs9kDlqThGRW/qnvpSSa2XTHMJ0bukTf0YCP3f65+QnC7NEwbKdw2lUbj5N6m7S+10g/xPWNQ1ofwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cgjw/DkY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id E3B2320BCAD1; Tue, 29 Apr 2025 01:51:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3B2320BCAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745916684;
	bh=bH/gRq3HkYAXOdTEm1wWVnhs8e9j9zydL0IGXdJm9z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgjw/DkYa5RLPVsfa6JDQm+dTp5wS2msU1njQGR9PFHfHPdRXRN/MfFd7Cdtsqceo
	 51OTUVgym3hohVal4H1IaQ9w9ihTFNs5egVT7EOIdvMsRPX0H3Beyoe3k6dpDz5hyG
	 fLNGYYUCi3uj3ZLKjhLc5V89rUxB75dSa7hMu7+w=
Date: Tue, 29 Apr 2025 01:51:24 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Message-ID: <20250429085124.GC10839@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
 <aA-Evojnzt2z0RdH@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA-Evojnzt2z0RdH@yury>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 28, 2025 at 09:38:06AM -0400, Yury Norov wrote:
> On Fri, Apr 25, 2025 at 03:54:38AM -0700, Shradha Gupta wrote:
> > Currently, the MANA driver allocates MSI-X vectors statically based on
> > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> > up allocating more vectors than it needs. This is because, by this time
> > we do not have a HW channel and do not know how many IRQs should be
> > allocated.
> > 
> > To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> > after getting the value supported by hardware, dynamically add the
> > remaining MSI-X vectors.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  Changes in v2:
> >  * Use string 'MSI-X vectors' instead of 'pci vectors'
> >  * make skip-cpu a bool instead of int
> >  * rearrange the comment arout skip_cpu variable appropriately
> >  * update the capability bit for driver indicating dynamic IRQ allocation
> >  * enforced max line length to 80
> >  * enforced RCT convention
> >  * initialized gic to NULL, for when there is a possibility of gic
> >    not being populated correctly
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 323 ++++++++++++++----
> >  include/net/mana/gdma.h                       |  11 +-
> >  2 files changed, 269 insertions(+), 65 deletions(-)
> 
> To me, this patch looks too big, and it doesn't look like it does
> exactly one thing.
> 
> Can you split it to a few small more reviewable chunks? For example,
> I authored irq_setup() helper. If you split its rework and make it
> a small preparation patch, I'll be able to add my review tag.
> 
> Thanks,
> Yury

Thank you for the comments Yury. I think I can split this patch into the 
irq_setup() preparation patch and other functionalities. Would also
investigate if these other functionalities can also be split, before sending
out the next version.

Regards,
Shradha.

