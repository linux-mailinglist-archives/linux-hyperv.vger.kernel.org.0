Return-Path: <linux-hyperv+bounces-5524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25DDAB7CDB
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 07:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F16A8C3113
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E2286D56;
	Thu, 15 May 2025 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R19ToO3I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E18C1F;
	Thu, 15 May 2025 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747285857; cv=none; b=VQpAfoBgZ2yvphDBrF55VS9QQUMnAvsCBxRsYibnflSK8J3nsOThMiewmX6u00puuEzozLp6a+eknKB4wg7slNp9CZAXeFTh0y++29AECxRgCTjf2j2VguT4ZPaOb8ORj8Uky+O+lCYFgYkb5UgSDo5vPWmF7WXMuS0f/zx9NQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747285857; c=relaxed/simple;
	bh=N6w/HO6/hiIcVn8Mlbq1eqIktw/a+TpEjZyydRXBTT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy49P7M4gMSX129VMLfuJwPhlHU1UMyX37/kkS5/J6hgzJk9+OKp3aA++9ja3olVrZa5bsrZYQvVEt2FBK/rwssxXvLNPrAyNVWQMufHaatIEB1WnbfJ8MpJs/6TKFlsNVGqRD1oL1y6DNuv01IIcDeTAOvRfAP5nwcWHqd41Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R19ToO3I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8C73F201DB03; Wed, 14 May 2025 22:10:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C73F201DB03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747285855;
	bh=3eGmczkQBBf0262xVEkapjIYwwsqXyJjSBXuy7w9jwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R19ToO3IocROPgOcAGE+GebaOZ2vJmKlpZeMbpWSl7T2ShIImYCR2Rzq3YcMJBkqJ
	 EeAT9Gmp1ojKGrijjV0gOvG2OboruWhh/ZFuPlpySJA2vHLDLahpRsksCNOpgHNQaj
	 olQNrBxvxWg+w66YYqhjthnfAsYg5jCFWfb8Aclc=
Date: Wed, 14 May 2025 22:10:55 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 4/4] net: mana: Allocate MSI-X vectors dynamically
Message-ID: <20250515051055.GC5681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785637-4881-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB4157AD1A0BA2C0C9237FEAA3D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aCTN4yfHBsJGXvnB@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCTN4yfHBsJGXvnB@yury>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 14, 2025 at 01:07:47PM -0400, Yury Norov wrote:
> On Wed, May 14, 2025 at 05:04:03AM +0000, Michael Kelley wrote:
> > From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, May 9, 2025 3:14 AM
> > > 
> > > Currently, the MANA driver allocates MSI-X vectors statically based on
> > > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> > > up allocating more vectors than it needs. This is because, by this time
> > > we do not have a HW channel and do not know how many IRQs should be
> > > allocated.
> > > 
> > > To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> > > after getting the value supported by hardware, dynamically add the
> > > remaining MSI-X vectors.
> > 
> > After this patch is applied, there are two functions for setting up IRQs:
> > 1. mana_gd_setup_dyn_irqs()
> > 2. mana_gd_setup_irqs()
> > 
> > #1 is about 78 lines of code and comments, while #2 is about 103 lines of
> > code and comments. But the two functions have a lot of commonality,
> > and that amount of commonality raises a red flag for me.
> > 
> > Have you looked at parameterizing things so a single function can serve
> > both purposes? I haven't worked through all the details, but at first
> > glance it looks very feasible, and without introducing unreasonable
> > messiness. Saving 70 to 80 lines of fairly duplicative code is worth a bit
> > of effort.
> > 
> > I have some other comments on the code. But if those two functions can
> > be combined, I'd rather re-review the result before adding comments that
> > may become irrelevant due to the restructuring.
> > 
> > Michael
> 
> On previous iteration I already mentioned that this patch is too big,
> doesn't do exactly one thing and should be split to become a reviewable 
> change. Shradha split-out the irq_setup() piece, and your review proves
> that splitting helps to reviewability.
> 
> The rest of the change is still a mess. I agree that the functions you
> mention likely duplicate each other. But overall, this patch bomb is
> above my ability to review. Fortunately, I don't have to.
> 
> Thanks,
> Yury

Hi Michael, Yury,

My intentions for keeping all these changes in MANA initialization code
together in a patch were to avoid multiple patches touching same
functions throughout the patchset. I felt it would become error-prone and
hamper reviewability.

About having to combine mana_gd_setup_dyn_irqs() and
mana_gd_setup_irqs(), we initially went ahead with a single function for
this with multiple parameters to prevent code duplication. But it made the
function very hard to read and caused a lot of confusion while reviewing
it.

At the surface of it, it would like like just two conditions to be
dealth with in the function but it actually has to deal with many more
conditions, like -
1. static allocation of all IRQs (IRQs < num_vCPUs)
2. static allocation of all IRQs (IRQs > num_vCPUS)
3. static allocation of 1 HWC IRQ
4. dynamic allocation of remaining IRQs (IRQs < num_vCPUs)
5. dynamic allocation of remaining IRQs (IRQs > num_vCPUs)

Therefore, to keep the code more readable we decided to separate the
functaionalities.

Thanks,
Shradha.

Shradha.

