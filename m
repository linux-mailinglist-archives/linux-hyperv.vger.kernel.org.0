Return-Path: <linux-hyperv+bounces-11059-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APPeMrriDWpF4gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11059-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 18:35:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7342F5921A7
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79B0A305A765
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88D3F1656;
	Wed, 20 May 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NDcytCVR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDF374178;
	Wed, 20 May 2026 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294448; cv=none; b=a7TWgOd8LgacwTyv/C+wrqFNdk7/I5hev/iTWCtHYUDDzUN9PagbKHEk3FnqWbdQKz+wPmhQfljUR9tgGz8hOIqaDFB3HejsKsXDOYGwUAYi/z56ZotQxM5yZcx/XW+vofK1yv2Qdr5aEQM+41Bp5OdGkQXXq9lB+woQxYy6zGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294448; c=relaxed/simple;
	bh=kn3O33iWkMRzrr20zxMKLIqtqvAJ2DDO+NvdjtjMqs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvRzUlVTqXQBqqyUtlL6uzXTsGKKBJcp2LyxOvMp+j3CwGev6S08yEZ8HURIIiguoNifcmb77Ys79EaslFoICMnjqbTs3nqSH02Udraq9lFpnYJKFfmHn+0sjWaAOqaZz3qPfL1OLLJZtrDFjKpgkwnzfbPn67FjI8yEpk2u7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NDcytCVR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7751F20B7167;
	Wed, 20 May 2026 09:27:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7751F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779294438;
	bh=eFSEuj5heaGvT5YYlCZtFr/mwoAJcGEgrnYMPiZpO2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDcytCVR00bg66AVB3fasrb4xc5qJ3xzfPI3jmvJswTvEYEkJGazM/h4sOu4YTj0a
	 KdGuCoYtIgqzcxkK8bTuGJrXa056BDTPEgoANUspQMnkeOQ0s5lZMqySnnd5IBY/lG
	 R0KJomZUgXvcte1MldoOOFE5zTM7EJcOguTnGOAM=
Date: Thu, 21 May 2026 00:27:23 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <3rqbtwl57wdaqgp3my5iajhaq5xb7qpbhbrrsuq6lme7rt7rxp@mcxvqww4tjkf>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <7wil6tzqp74gdvhyjvpv47zhfernncs42wnfoueznneluz5zrp@pzr63lhy7s5f>
 <SN6PR02MB4157F7758A127AA1E8096B6CD4042@SN6PR02MB4157.namprd02.prod.outlook.com>
 <BN7PR02MB4148D820AEBBBB9A1268D640D4042@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB4148D820AEBBBB9A1268D640D4042@BN7PR02MB4148.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11059-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,outlook.com:email,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 7342F5921A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 11:33:21PM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, May 15, 2026 11:00 AM
> > 
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 9:24 AM
> > >
> > > On Thu, May 14, 2026 at 06:14:22PM +0000, Michael Kelley wrote:
> > > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:24 AM
> > > > >
> > 
> > [....]
> > 
> > > > > +	unsigned long nr_pages = end_pfn - start_pfn;
> > > > > +	u16 count = 0;
> > > > > +
> > > > > +	while (nr_pages > 0) {
> > > > > +		unsigned long flush_pages;
> > > > > +		int order;
> > > > > +		unsigned long pfn_align;
> > > > > +		unsigned long size_align;
> > > > > +
> > > > > +		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > > > > +			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
> > > > > +			break;
> > > > > +		}
> > > > > +
> > > > > +		if (start_pfn)
> > > > > +			pfn_align = __ffs(start_pfn);
> > > >
> > > > I don't understand why __ffs() is correct here. I would expect
> > > > __fls() so it is consistent with the calculation of size_align. But I
> > > > can only surmise how the hypercall works since there's no
> > > > documentation, so maybe my understanding of the hypercall is
> > > > wrong.   If __ffs really is correct, a comment explaining why
> > > > would help. :-)
> > > >
> > >
> > > The use of __ffs() is intentional. Each flush entry invalidates a
> > > naturally aligned 2^N page block, and the hypervisor requires the
> > > page_number to be aligned to 2^page_mask_shift.
> > >
> > > Here __ffs() and __fls() serve different purposes:
> > > - __ffs(start_pfn) is about the alignment constraint, e.g.,  how
> > > large a block can this address support?
> > > - __fls(nr_pages) is about  the size constraint, e.g., how large
> > > a block can the remaining range hold?
> > >
> > > Taking min() of both ensures each entry is both properly aligned
> > > and within bounds.
> > >
> > > Thanks for raising this - it definitely deserves a comment. I had to
> > > stare at it for a while myself to remember why. :)
> > 
> > Hmmm. Something about this still nags at me. I'll run some
> > experiments to either convince myself that you are right, or to
> > come up with a counterexample.
> 
> I have resolved what was nagging at me. My understanding of how
> _ffs() and __fls() work was wrong. :-(  Your code is correct.
> 
> > 
> > A related thought occurred to me. If each flush entry that is passed
> > to Hyper-V describes a naturally aligned 2^N page block, I don't
> > think the HV_IOMMU_MAX_FLUSH_VA_COUNT can ever
> > be reached. The number of entries is limited by the number of
> > bits in a PFN and the pages count, both of which are 64. And with
> > 52 bit physical addressing and 4KiB pages, the actual size of
> > a PFN and pages count is even smaller than 64.
> > HV_IOMMU_MAX_FLUSH_VA_COUNT is the number of 8 byte
> > union hv_iommu_flush_va entries that fit in a 4KiB page, so
> > it's ~500.
> > 
> > My statement applies to a single flush range. If multiple flush
> > ranges were strung together in a single hypercall, a larger count
> > could be reached, but hv_flush_device_domain_list() only does
> > a single range. So I don't think the overflow case in
> > hv_flush_device_domain_list() can ever happen. But let me
> > do my experiments, and I will also look at this aspect to confirm
> > if it's right.
> 
> My experiments also convince me that the overflow case can't
> happen as long as the hypercall is being populated with entries
> derived from a single range.

Gosh. You're right. I think I've been overthinking this :( 

So we can simplify this to just do the list flush and fall back
to HVCALL_FLUSH_DEVICE_DOMAIN only if the list flush fails.

B.R.
Yu

