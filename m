Return-Path: <linux-hyperv+bounces-10917-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBQGLDtQB2rBxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10917-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 18:56:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1E5543A4
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD4833A957A
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34783E0097;
	Fri, 15 May 2026 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p5FCS4Gq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C493E0087;
	Fri, 15 May 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862241; cv=none; b=TEK8DYccGtjzkudeMipV6EnJ0ldU39a/DbxxhypqzgNK+SRqmN3C7Unbo/MHa3VJEsb2gq7+vDtkPvXB+6vK7ySGacJk9c7pG9xEjBWy0VGTxctgzSTohlBJwl8OYUo5L8PgZX1cQ6SOlsEhIHhbZAT5PjEIKlOPjMB4doyplVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862241; c=relaxed/simple;
	bh=QveEBeLpjrLNgHT7F+qpWZOlMT12xJIadfIFah9fJas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Awau9RA/YVxIyh0NCu/gY8xQR6WkEL748K0fuWHkeQcYtT8Xi2wdsMSjS6kLxuAUSkVdfPpvBo2gVysoRkKji3ZFI3+VkrNaQAnG/KzFGqpt/3VMsUF8f+198xJui83HRaXEtXNLjr53GrOfysAB5n8KHNgEZjje0eM2T8SBxWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p5FCS4Gq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id AFDEC20B7167;
	Fri, 15 May 2026 09:23:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFDEC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778862235;
	bh=IHBwl9bdflcGK5oyvrZUlWqz2dvjzQNIWK/qxmG2wCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5FCS4Gqm699ckCDIPJqsbF1kx8AIfLpFGiS2gqafxcq38YKricBOQabQRgiUQZn2
	 WpVvt7+WO9yCNWhwrMWOjBidhqWpwcujdFNnTDVBehAfqKBZv1hGqeuhXJdWSImTQu
	 EUplScJbh4koEEK6hvvKLeF1hBA0IJ5q7slJ9Sog=
Date: Sat, 16 May 2026 00:23:56 +0800
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
Message-ID: <7wil6tzqp74gdvhyjvpv47zhfernncs42wnfoueznneluz5zrp@pzr63lhy7s5f>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 2CF1E5543A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-10917-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 06:14:22PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:24 AM
> > 
> > Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> > This hypercall accepts a list of (page_number, page_mask_shift) entries,
> > enabling finer-grained IOTLB invalidation compared to the domain-wide
> > HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
> > 
> > hv_iommu_fill_iova_list() decomposes a contiguous IOVA range into a
> > minimal set of aligned power-of-two regions that fit in a single
> > hypercall input page. When the range exceeds the page capacity, the
> > code falls back to a full domain flush automatically.
> > 
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > ---
> >  drivers/iommu/hyperv/iommu.c | 91 +++++++++++++++++++++++++++++++++++-
> >  include/hyperv/hvgdk_mini.h  |  1 +
> >  include/hyperv/hvhdk_mini.h  | 17 +++++++
> >  3 files changed, 108 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> > index e5fc625314b5..3bca362b7815 100644
> > --- a/drivers/iommu/hyperv/iommu.c
> > +++ b/drivers/iommu/hyperv/iommu.c
> > @@ -486,10 +486,98 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> >  	hv_flush_device_domain(to_hv_iommu_domain(domain));
> >  }
> > 
> > +/* Max number of iova_list entries in a single hypercall input page. */
> > +#define HV_IOMMU_MAX_FLUSH_VA_COUNT \
> > +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_flush_device_domain_list)) / \
> > +	 sizeof(union hv_iommu_flush_va))
> > +
> > +/* Returned by hv_iommu_fill_iova_list() when the range exceeds the capacity */
> > +#define HV_IOMMU_FLUSH_VA_OVERFLOW	U16_MAX
> > +
> > +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
> > +					  unsigned long start,
> > +					  unsigned long end)
> > +{
> > +	unsigned long start_pfn = start >> PAGE_SHIFT;
> > +	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
> 
> "end" is an inclusive end address per comment in struct iommu_iotlb_gather.
> So a page aligned value would typically have 0xFFF as the low order 12 bits,
> and PAGE_ALIGN() will do the right thing. But I don't think the value is
> *required* to be page aligned.  If the value of "end" had 0x000 as the
> low order 12 bits, the above calculation would fail to include the page
> that has the address ending in 0x000.  I think it needs to be
> PAGE_ALIGN(end + 1) in order to work correctly for this corner case. 
> 

Good catch! Will use HVPFN_DOWN(start) and HVPFN_UP(end + 1) as you
suggested in your follow-up mail.

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
> 
> I don't understand why __ffs() is correct here. I would expect
> __fls() so it is consistent with the calculation of size_align. But I
> can only surmise how the hypercall works since there's no
> documentation, so maybe my understanding of the hypercall is
> wrong.   If __ffs really is correct, a comment explaining why
> would help. :-)
> 

The use of __ffs() is intentional. Each flush entry invalidates a
naturally aligned 2^N page block, and the hypervisor requires the
page_number to be aligned to 2^page_mask_shift.

Here __ffs() and __fls() serve different purposes:
- __ffs(start_pfn) is about the alignment constraint, e.g.,  how
large a block can this address support?
- __fls(nr_pages) is about  the size constraint, e.g., how large
a block can the remaining range hold?

Taking min() of both ensures each entry is both properly aligned
and within bounds.

Thanks for raising this — it definitely deserves a comment. I had to
stare at it for a while myself to remember why. :)

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
> > +
> > +	return count;
> > +}
> > +
> > +static void hv_flush_device_domain_list(struct hv_iommu_domain *hv_domain,
> > +					struct iommu_iotlb_gather *iotlb_gather)
> > +{
> > +	u64 status;
> > +	u16 count;
> > +	unsigned long flags;
> > +	struct hv_input_flush_device_domain_list *input;
> > +
> > +	local_irq_save(flags);
> > +
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +
> > +	input->device_domain = hv_domain->device_domain;
> > +	input->flags |= HV_FLUSH_DEVICE_DOMAIN_LIST_IOMMU_FORMAT;
> 
> I would suggest moving the memset() and setting the input fields down
> under the "else" below so that they are parallel with the flush all case.
> 

I agree the structure should be more symmetric. Yet I guess the memset and
hv_iommu_fill_iova_list() need to stay before the branch since the fill
writes directly into input->iova_list[]. :)

> > +	count = hv_iommu_fill_iova_list(input->iova_list,
> > +					iotlb_gather->start,
> > +					iotlb_gather->end);
> > +	if (count == HV_IOMMU_FLUSH_VA_OVERFLOW) {
> > +		/*
> > +		 * Range exceeds hypercall page capacity. Fall back to a full
> > +		 * domain flush.
> > +		 */
> > +		struct hv_input_flush_device_domain *flush_all = (void *)input;
> > +
> > +		memset(flush_all, 0, sizeof(*flush_all));
> > +		flush_all->device_domain = hv_domain->device_domain;
> > +		status = hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN,
> > +					flush_all, NULL);
> > +	} else {
> > +		status = hv_do_rep_hypercall(
> > +				HVCALL_FLUSH_DEVICE_DOMAIN_LIST,
> > +				count, 0, input, NULL);
> > +	}
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN_LIST failed, status %lld\n", status);
> 
> As Sashiko pointed out, a failure here can lead to all kinds of trouble because
> of leaving unflushed entries. Maybe a WARN() is more appropriate? Also, maybe
> a failure in the list flush should try a flush all as a fallback, with the WARN()
> only if the flush all fails.
> 

Good idea. How about we restructure this routine to sth. like this:


	memset(input, 0, sizeof(*input));
	count = hv_iommu_fill_iova_list(...);
	
	if (count != HV_IOMMU_FLUSH_VA_OVERFLOW) {
		input->device_domain = ...;
		...
		status = hv_do_rep_hypercall(FLUSH_DEVICE_DOMAIN_LIST, ...);
		if (hv_result_success(status))
			goto out;
	}
	
	/* overflow or list flush failed: fallback to full domain flush */
	flush_all = (void *)input;
	memset(flush_all, 0, sizeof(*flush_all));
	flush_all->device_domain = ...;
	status = hv_do_hypercall(FLUSH_DEVICE_DOMAIN, ...);
	WARN(!hv_result_success(status), "IOTLB flush failed, status %lld\n", status);

	out:
		local_irq_restore(flags);

B.R.
Yu

