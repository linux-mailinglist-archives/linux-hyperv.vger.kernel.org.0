Return-Path: <linux-hyperv+bounces-8959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNreM/SZnGmKJgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8959-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 19:18:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8517B694
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F8E300B470
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE233C1BE;
	Mon, 23 Feb 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gr/2oZS7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68433C199;
	Mon, 23 Feb 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870627; cv=none; b=oyaPouT3YuO4s1d0Q9eTKoKciNqfqMI+nPz0JJQgaLKgeKs0IMrO4f8muDVLv5QIjBu2Mg+Du+2t3mkZyWOKPlW7NR6eUgOnMoLOoaYGIcQu5CIxHIQQ+h9HinbcSSFqSrAnyTJb8quvFxs/OO/FEEh1W2zp+PTkN/Q8O4lrOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870627; c=relaxed/simple;
	bh=YEgZvkfGQpH28bvR2WMtO8SyoqfUibnVdER3PgTAjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbsrwDIjBdBY/dMMiophOfsfWlo54uSyAROtn9VrOB+VvT2ZlxJ09LMj4pWW4CbIx7cE7OqfPsxnDzIrSeV26BXGZtfBEObWomeGBuqBBSwzFMuTYI9B9bbTcCCL4QKpsB15ZR2qrtScE8LLd+iMd2Zx0R7xcmT4HV/fOH1tOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gr/2oZS7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A1B420B6F00;
	Mon, 23 Feb 2026 10:17:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A1B420B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771870625;
	bh=63iYgw6Kzes7H1/bRFh6b7uS8exVFVKIh6mGnppYjeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gr/2oZS75BlXMNNeY2J1AZp64FpOuY/9bh2cRfui6grEwh4RsQyfYobukTOoFrWiY
	 aBHnmO9ifjwfeYi/+H9J80SOYhJlpbP4VKswPdbfmHXYLa66i+EtnZOWbbrE88NiOP
	 0274GwDy5AvW6Wx385kL10+QYEkMUYsrGV/5b2Ew=
Date: Mon, 23 Feb 2026 10:17:03 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: Replace fixed memory deposit with status driven
 helper
Message-ID: <aZyZnwMSnmxQf0i8@skinsburskii.localdomain>
References: <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415705AA10C44D52CFFC0D31D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415705AA10C44D52CFFC0D31D468A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8959-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 33E8517B694
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 05:05:09PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, February 19, 2026 2:10 PM
> > 
> > Replace hardcoded HV_MAP_GPA_DEPOSIT_PAGES usage with
> > hv_deposit_memory() which derives the deposit size from
> > the hypercall status, and remove the now-unused constant.
> > 
> > The previous code always deposited a fixed 256 pages on
> > insufficient memory, ignoring the actual demand reported
> > by the hypervisor.
> 
> Does the hypervisor report a specific page count demand? I haven't
> seen that anywhere. It seems like the deposit memory operation is
> always something of a guess.
> 

Correct, it does not, except for the *CONTIGUOUS_MEMORY* status. That
status indicates a need for a large contiguous block (at least 8 pages).

> > hv_deposit_memory() handles different
> > deposit statuses, aligning map-GPA retries with the rest
> > of the codebase.
> > 
> > This approach may require more allocation and deposit
> > hypercall iterations, but avoids over-depositing large
> > fixed chunks when fewer pages would suffice. Until any
> > performance impact is measured, the more frugal and
> > consistent behavior is preferred.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> From a purely functional standpoint, this change addresses the
> concern that I raised. But I don’t have any intuition on the performance
> impact of having to iterate. hv_deposit_memory() adds only a single
> page for some of the statuses, so if there really is a large memory need,
> the new code would iterate 256 times to achieve what the existing code
> does.
> 
> Any idea where the 256 came from the first place?  Was that
> empirically determined like some of the other memory deposit counts?
> 

Unfortunately, the history of this change has been lost. My guess is
that it was a straightforward optimization to reduce the number of
iterations. But without a clear understanding of the real memory needs
or the performance impact, it was only a guess.

> In addition to a potential performance impact, I know the hypervisor tries
> to detect denial-of-service attempts that make "too many" calls to the
> hypervisor in a short period of time. In such a case, the hypervisor
> suspends scheduling the VM for a few seconds before allowing it to resume.
> Just need to make sure the hypervisor doesn't think the iterating is a 
> denial-of-service attack. Or maybe that denial-of-service detection
> doesn't apply to the root partition VM.
> 

This deposit hypercall shouldn’t run into this issue. If it did, it
would mean that starting 256 VMs at the same time would trigger the same
problem, with one deposit per VM.
Since there's no sign of that happening so far, I'd prefer to keep
things simple and revisit it later if needed.

Thanks,
Stanislav

> But from a functional standpoint,
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> > ---
> >  drivers/hv/mshv_root_hv_call.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index 7f91096f95a8..317191462b63 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -16,7 +16,6 @@
> > 
> >  /* Determined empirically */
> >  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> > -#define HV_MAP_GPA_DEPOSIT_PAGES	256
> >  #define HV_UMAP_GPA_PAGES		512
> > 
> >  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> > @@ -239,8 +238,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64
> > page_struct_count,
> >  		completed = hv_repcomp(status);
> > 
> >  		if (hv_result_needs_memory(status)) {
> > -			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> > -						    HV_MAP_GPA_DEPOSIT_PAGES);
> > +			ret = hv_deposit_memory(partition_id, status);
> >  			if (ret)
> >  				break;
> > 
> > 
> > 
> 

