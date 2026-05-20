Return-Path: <linux-hyperv+bounces-11062-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AE8IuEVDmpT6AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11062-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:13:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B285994BA
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A08F33237AD4
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46C3F1AA4;
	Wed, 20 May 2026 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s2WvwTHM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC7372B58;
	Wed, 20 May 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297328; cv=none; b=WzyMYGpEvgWtKwUnnXMXFJalU3h4eqnP1joi0Nd69dK8KC3ZKHSCSVb6+UMw4BBh/yWlud4WnJz6fq1VSWCjrhCzl4vZSzIJ9XEKFDHuhverXozoL8C3w+krVLlcIY06SHXlcHFdbb0WcoeGQ9PQQNGYOISYAAYfNatS9p9RxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297328; c=relaxed/simple;
	bh=AN03m8Nb3GUj5nPHISwTrdR9EGmveB2qO0RFcT2taLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhEtYQpcuZUq3ZGFkvJ8yNxx5jiYwsje6/WMJhmOmwvEBcOVDE3iisU6bsX83x9mGaZ3GNHgwStb9D8QZu+kcjaFdN/BD4lRI3fKGOn3liX/GOaRxD5sbVIGodHbOMrHFleafH9ctA+MID5N3e4yKthj35gjH6/Mjnk1Jm+K6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s2WvwTHM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16A1620B7167;
	Wed, 20 May 2026 10:15:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16A1620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779297320;
	bh=hnmFeJDl4TBKVIsJUUCbBB+UTJEByCBlUvjrRaqcaEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2WvwTHMixOOPcCNq+vUZeU47P7Pk/66nkAb9jvNUZScmaAF0nFT6x1etrZIl2Khn
	 kZcG3sUAcxdBFzfKDaYV7SSatZSOnO2Bu3fduUj7uXLPicd7ALhdbSw+7fj81brS/V
	 Vhy5M0SktDcuZgkIKjrr7AueKDCvEgtSd99iTgi8=
Date: Thu, 21 May 2026 01:15:24 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, jacob.pan@linux.microsoft.com, 
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515223545.GL7702@ziepe.ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[ziepe.ca,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11062-lists,linux-hyperv=lfdr.de];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 28B285994BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 07:35:45PM -0300, Jason Gunthorpe wrote:
> On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> > +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
> > +					  unsigned long start,
> > +					  unsigned long end)
> > +{
> > +	unsigned long start_pfn = start >> PAGE_SHIFT;
> > +	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
> > +	unsigned long nr_pages = end_pfn - start_pfn;
> > +	u16 count = 0;
> > +
> > +	while (nr_pages > 0) {
> > +		unsigned long flush_pages;
> > +		int order;
> > +		unsigned long pfn_align;
> > +		unsigned long size_align;
> > +
> > +		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > +			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
> > +			break;
> > +		}
> > +
> > +		if (start_pfn)
> > +			pfn_align = __ffs(start_pfn);
> > +		else
> > +			pfn_align = BITS_PER_LONG - 1;
> > +
> > +		size_align = __fls(nr_pages);
> > +		order = min(pfn_align, size_align);
> > +		iova_list[count].page_mask_shift = order;
> > +		iova_list[count].page_number = start_pfn;
> > +
> > +		flush_pages = 1UL << order;
> > +		start_pfn += flush_pages;
> > +		nr_pages -= flush_pages;
> > +		count++;
> > +	}
> 
> This seems like a really silly hypervisor interface. Why doesn't it
> just accept a normal range? Splitting it into power of two aligned
> ranges is very inefficient.

Fair point. I'm not sure how much flexibility we have to change
this hypercall interface at the moment - it predates the pvIOMMU
work and may have other consumers beyond Linux guest. On the other
hand, having the guest specify 2^N-aligned blocks does save the
hypervisor from having to decompose ranges itself before issuing
hardware invalidation commands - the guest-provided entries can be
fed to the HW more or less directly.

That said, the way I'm currently using this interface may be
more precise than necessary. Maybe we have 2 options:

1) Current approach: decompose the range into multiple exact
   2^N-aligned blocks with no over-flush, but at the cost of
   more complex calculations and more entries.

2) Follow what Intel/AMD drivers do: find a single minimal
   2^N-aligned block that covers the entire range, but may
   over-flush.

Any preference?

@Michael, since you've also been reviewing this patch, I'd
appreciate your thoughts on the above as well. :)

Yu

