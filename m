Return-Path: <linux-hyperv+bounces-5301-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FCAA6A88
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 08:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794D2168C50
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E41F30DD;
	Fri,  2 May 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AiVEFlUu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C31E51E3;
	Fri,  2 May 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166092; cv=none; b=Mu7S7ernV6ip37iU5KZ5t9o1kEg/0bGLMOydjeVZLqEjtXKdVQ0V7medHtGYEzV1hxuXvX2nOdXlNKTCZLLklXK2JQdZ/bJcNCyn2w4kooG5JwnGEEwMaBIdl80VLN6dR9kDpdy/u54CJD1eTZqxIpECYCO7dtCZMFjDbPd8gVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166092; c=relaxed/simple;
	bh=Vx2THve1rmsHzjpjDKRkcdp0KoxQt1d23ap0dGDJAX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5V2fI9jIUoDSI1cSx/LCAaFDbH26DF5lmja4l7HfM9WrfRX+aEx8VaiEEMFghxqzvkglnCiH+lXPeNvbLSQY9JUDe3cYlHvlmL2nayTBMY7GvNhkBPm6UxtRitexvTddlt83kuljimMueOhjVz0szZwTMECGIulaTjkWPsOsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AiVEFlUu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 789102020964; Thu,  1 May 2025 23:08:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 789102020964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746166089;
	bh=9+r69ZddY1UZkHR3/FwhIdCjqmNBZaadDjUSZVoYSAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiVEFlUu8IfyCCGNVGXAeB65x7LTHiBsP3cyaB05BdyktmMQdrW7BvdxLv00u1I+K
	 r1g0rPMQqAsJ3B7qyaA52zhAQgAZXeGda+rIgFQ4eUeNd7kZJ40alPQW5JDCrpituU
	 tCG1qe5CmLcW70KOfqLSp6O8Dh//y+Ae1fadP70w=
Date: Thu, 1 May 2025 23:08:09 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy?ski <kw@linux.com>,
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
	Peter Zijlstra <peterz@infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 3/3] net: mana: Allocate MSI-X vectors dynamically as
 required
Message-ID: <20250502060809.GA10704@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578478-15195-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB4157FF2CA8E37298FC634491D4822@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250501142354.GA6208@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157EAC71A53E152EE684A4DD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157EAC71A53E152EE684A4DD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 01, 2025 at 03:56:48PM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Thursday, May 1, 2025 7:24 AM
> > 
> > On Thu, May 01, 2025 at 05:27:49AM +0000, Michael Kelley wrote:
> > > From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, April 25,
> > 2025 3:55 AM
> > > >
> > > > Currently, the MANA driver allocates MSI-X vectors statically based on
> > > > MANA_MAX_NUM_QUEUES and num_online_cpus() values and in some cases ends
> > > > up allocating more vectors than it needs. This is because, by this time
> > > > we do not have a HW channel and do not know how many IRQs should be
> > > > allocated.
> > > >
> > > > To avoid this, we allocate 1 MSI-X vector during the creation of HWC and
> > > > after getting the value supported by hardware, dynamically add the
> > > > remaining MSI-X vectors.
> > >
> > > I have a top-level thought about the data structures used to manage a
> > > dynamic number of MSI-X vectors. The current code allocates a fixed size
> > > array of struct gdma_irq_context, with one entry in the array for each
> > > MSI-X vector. To find the entry for a particular msi_index, the code can
> > > just index into the array, which is nice and simple.
> > >
> > > The new code uses a linked list of struct gdma_irq_context entries, with
> > > one entry in the list for each MSI-X vector.  In the dynamic case, you can
> > > start with one entry in the list, and then add to the list however many
> > > additional entries the hardware will support.
> > >
> > > But this additional linked list adds significant complexity to the code
> > > because it must be linearly searched to find the entry for a particular
> > > msi_index, and there's the messiness of putting entries onto the list
> > > and taking them off.  A spin lock is required.  Etc., etc.
> > >
> > > Here's an intermediate approach that would be simpler. Allocate a fixed
> > > size array of pointers to struct gdma_irq_context. The fixed size is the
> > > maximum number of possible MSI-X vectors for the device, which I
> > > think is MANA_MAX_NUM_QUEUES, or 64 (correct me if I'm wrong
> > > about that). Allocate a new struct gdma_irq_context when needed,
> > > but store the address in the array rather than adding it onto a list.
> > > Code can then directly index into the array to access the entry.
> > >
> > > Some entries in the array will be unused (and "wasted") if the device
> > > uses fewer MSI-X vector, but each unused entry is only 8 bytes. The
> > > max space unused is fewer than 512 bytes (assuming 64 entries in
> > > the array), which is neglible in the grand scheme of things. With the
> > > simpler code, and not having the additional list entry embedded in
> > > each struct gmda_irq_context, you'll get some of that space back
> > > anyway.
> > >
> > > Maybe there's a reason for the list that I missed in my initial
> > > review of the code. But if not, it sure seems like the code could
> > > be simpler, and having some unused 8 bytes entries in the array
> > > is worth the tradeoff for the simplicity.
> > >
> > > Michael
> > 
> > Hey  Michael,
> > 
> > Thanks for your inputs. We did think of this approach and in fact that
> > was how this patch was implemented(fixed size array) in the v1 of our
> > internal reviews.
> > 
> > However, it came up in those reviews that we want to move away
> > from the 64(MANA_MAX_NUM_QUEUES) as a hard limit for some new
> > requirements, atleast for the dynamic IRQ allocation path. And now the
> > new limit for all hardening purposes would be num_online_cpus().
> > 
> > Using this limit and the fixed array size approach creates problems,
> > especially in machines with high number of vCPUs. It would lead to
> > quite a bit of memory/resource wastage.
> > 
> > Hence, we decided to go ahead with this design.
> > 
> > Regards,
> > Shradha.
> 
> One other thought:  Did you look at using an xarray? See
> https://www.kernel.org/doc/html/latest/core-api/xarray.html.
> It has most of or all the properties you need to deal with
> a variable number of entries, while handling all the locking
> automatically. Entries can be accessed with just a simple
> index value.
> 
> I don't have first-hand experience writing code using xarrays,
> so I can't be sure that it would simplify things for MANA IRQ
> allocation, but it seems to be a very appropriate abstraction
> for this use case.
> 
> Michael
>
Thanks Michael,

This does look promising for our usecase. I will try it with this patch,
update the thread and then send out the next version as required.

Regards,
Shradha.

