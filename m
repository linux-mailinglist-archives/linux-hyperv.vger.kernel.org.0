Return-Path: <linux-hyperv+bounces-11130-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNlQC0coD2rGHAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11130-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 17:44:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 292405A8901
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB3E630D7B5E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BE3EE1FA;
	Thu, 21 May 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="a9y/bJGK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8E3D3D0B;
	Thu, 21 May 2026 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374066; cv=none; b=ThcEA0+25whmcR3ZLqk4xl2rFyxKPdR00GYI+Lfu2HesD/XD99MjgkyuZFhsxHuwPruKCSy3sY1Xa4V6kMP6EM1lcJZqbYwUKmTuiTiFA9r0YmAMsQTX154I0XfcrEHkQV1Fn35X79qOzg4wY4BV1XiQpMXt4HPaKrevbKeJpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374066; c=relaxed/simple;
	bh=oVRExsDbqI3W1ESzcran04U9sA2pzYajuKWQjY1qFwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiuIwOvOivZELnpaAYzKsehLh/hjh0+SNQWAJTQlHmrnnbWblraUqSVn/oeCbCBE2pjPP51c8jNU1hrgPwZRO2e0CXVsYZEauckIsCh3oAa5m/71WqaEWq76frf2f2s3uPCKuxwzRPzGNxsoFt4db5ksb2vBY5WNul1JrBh0Fuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=a9y/bJGK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 178A520B7167;
	Thu, 21 May 2026 07:34:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 178A520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779374057;
	bh=yuY7/VKIfWBH4Ab+m5RYvn2+pEgbBdbEqQP/VdZLuxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9y/bJGKwY3aQlb5YklgTtrtaqVP6gnQpATZWuAOiOMgeei+p4MnBPg3n2m7DZbhn
	 3QOibAa0hCmftbsO/SAfMxtJr0nEyCVuWXUOHEF5R5H3i5EX3l95MTrQTzgZJaPX4k
	 2nLCXrel9IW7Q7CBWTlnasMUO1FFcg2JFZiUTbg0=
Date: Thu, 21 May 2026 22:34:22 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, 
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <pxod76qh3jtpvnxdlflvntc5svqgibaeu6tywn2ejrlnea65w3@djehcr3vidnk>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
 <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
 <SN6PR02MB4157C1EC7F5F69C5ABDA9C7FD4012@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157C1EC7F5F69C5ABDA9C7FD4012@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-11130-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 292405A8901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 07:26:24PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Wednesday, May 20, 2026 10:15 AM
> > 
> > On Fri, May 15, 2026 at 07:35:45PM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> > > > +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
> > > > +					  unsigned long start,
> > > > +					  unsigned long end)
> > > > +{
> > > > +	unsigned long start_pfn = start >> PAGE_SHIFT;
> > > > +	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
> > > > +	unsigned long nr_pages = end_pfn - start_pfn;
> > > > +	u16 count = 0;
> > > > +
> > > > +	while (nr_pages > 0) {
> > > > +		unsigned long flush_pages;
> > > > +		int order;
> > > > +		unsigned long pfn_align;
> > > > +		unsigned long size_align;
> > > > +
> > > > +		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > > > +			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		if (start_pfn)
> > > > +			pfn_align = __ffs(start_pfn);
> > > > +		else
> > > > +			pfn_align = BITS_PER_LONG - 1;
> > > > +
> > > > +		size_align = __fls(nr_pages);
> > > > +		order = min(pfn_align, size_align);
> > > > +		iova_list[count].page_mask_shift = order;
> > > > +		iova_list[count].page_number = start_pfn;
> > > > +
> > > > +		flush_pages = 1UL << order;
> > > > +		start_pfn += flush_pages;
> > > > +		nr_pages -= flush_pages;
> > > > +		count++;
> > > > +	}
> > >
> > > This seems like a really silly hypervisor interface. Why doesn't it
> > > just accept a normal range? Splitting it into power of two aligned
> > > ranges is very inefficient.
> > 
> > Fair point. I'm not sure how much flexibility we have to change
> > this hypercall interface at the moment - it predates the pvIOMMU
> > work and may have other consumers beyond Linux guest. On the other
> > hand, having the guest specify 2^N-aligned blocks does save the
> > hypervisor from having to decompose ranges itself before issuing
> > hardware invalidation commands - the guest-provided entries can be
> > fed to the HW more or less directly.
> > 
> > That said, the way I'm currently using this interface may be
> > more precise than necessary. Maybe we have 2 options:
> > 
> > 1) Current approach: decompose the range into multiple exact
> >    2^N-aligned blocks with no over-flush, but at the cost of
> >    more complex calculations and more entries.
> > 
> > 2) Follow what Intel/AMD drivers do: find a single minimal
> >    2^N-aligned block that covers the entire range, but may
> >    over-flush.
> > 
> > Any preference?
> > 
> > @Michael, since you've also been reviewing this patch, I'd
> > appreciate your thoughts on the above as well. :)
> > 
> 
> I'm just guessing, but perhaps flushing an aligned power-of-2
> range can be processed by the hypervisor at a relatively fixed
> cost, regardless of the size. Having the guest do the decomposing
> of an arbitrary range allows the hypervisor to make use of the
> existing "rep" hypercall mechanism if the hypercall is taking
> "too long". The hypervisor can pause its processing, return to
> the guest temporarily, and then continue the hypercall. If the
> arbitrary range were passed into the hypercall for the hypervisor
> to do the decomposing, that pause-and-restart mechanism
> wouldn't be available.
> 
> Of course, Linux doesn't really take advantage of the pause to
> reduce guest interrupt latency because the Hyper-V code in
> Linux typically disable interrupts around a hypercall due to the
> way the hypercall input page is allocated. But other guest
> operating systems might benefit from such a pause. And we could
> probably fix the Hyper-V code in Linux to allow interrupts during a
> hypercall pause/restart if long-running hypercalls turn out to be
> a problem.
> 
> Regarding proposal (1) vs. (2), perhaps you could confirm with
> the Hyper-V team that flushing an aligned power-of-2 range
> has relatively fixed cost, regardless of the size. And what do the
> flush requests coming from the generic IOMMU subsystem look
> like? Do they match dma_unmap() ranges, which are probably
> dominated by relatively small ranges of a few pages at most,
> with a few outliers for disk I/O requests of 1 MiB or some such?
> If the dominant flush request is for a few pages at most, then
> doing (2) seems reasonable.

Thanks for the thoughtful suggestions, Michael!

I believe the time might be dominated by the number of descriptors,
instead of the size of each range, especially when device TLB
invalidations are involved.

Here's my understanding of what hypervisor does in its handler:

Hyper-V constructs one IOTLB invalidation descriptor (and possibly
a Device TLB invalidation descriptor as well) per iova_list entry
and submits them to the HW invalidation queue, then synchronously
waits for completion. So multiple 2^N-aligned entries should be less
efficient than a single larger 2^N aligned one.

Since both options submit 2^N-aligned entries to the hypervisor,
either one single coarser-grained entry or a precise decomposition,
I'm now also leaning towards option 2, which is also what Intel/AMD
drivers do for page-selective IOTLB flush. Simpler guest code, faster
flush, and the hypervisor can feed the single entry almost directly
to HW.

Yu

