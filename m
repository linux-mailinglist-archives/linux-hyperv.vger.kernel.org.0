Return-Path: <linux-hyperv+bounces-8657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELMuLFjzgGkgDQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8657-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:56:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE188D05A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF94301389D
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E6826D4E5;
	Mon,  2 Feb 2026 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dXYSgksU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8F21C9F9;
	Mon,  2 Feb 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058581; cv=none; b=CnsAAUC9N33goFfK+kdDx0iWhMv2uBLbGS3Vn6POrtIgOtpQvgjv2ZhLQefE3wtxVUS1lldzFTYgmNyQvY2WPmiyW6issENFP/aIgWi/jEQDZcSW2vgPAuTGDqgjOKi3t+pQa1IlZeDMSgcTp818MKgnYc7SdKt+Ir2Qoe5k6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058581; c=relaxed/simple;
	bh=s8fVuDMmEeT+gdO9s+1IyI+jIHr0ndWNLfG6zv+mnGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiWF2Ezav7Y3MPqjC/bLWlLTuX0E5aleBBIkFbaJAD0YAzE7YrYXngdo5MzJ6EJ3v8L5WUn/tyAm1STwssYPwwC9OSrzNr0IwFrTxsiC1kWObh2ISc5qLSCMzrjqFLznrfZXqwGrk2rx7uqAmF/6TX992XbXX8pB/Y7B4wQ5oZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dXYSgksU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30D5B20B7168;
	Mon,  2 Feb 2026 10:56:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30D5B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770058579;
	bh=kT8OHwpDJ7QbFcQG0Z8UFavdpvpWWLNXseYFuXRJeK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXYSgksUdj2Ow5C9BjwWK3bRZLDJ004C/TcceY79mtF96qP6OTxa5pCdmix3q9YsD
	 7ADEcRjRgFLr2EpM3OXSiPic+G3y2N9YCVame+YCss6L14DGgGKufPMCQOy+X4qi2D
	 TeAwoiMubwkqHaZfkCCJMzLcMKuQLybK0KYdsDq4=
Date: Mon, 2 Feb 2026 10:56:19 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "mhkelley58@gmail.com" <mhkelley58@gmail.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Message-ID: <aYDzU5ujoBlzWaa6@skinsburskii.localdomain>
References: <20260202165101.1750-1-mhklinux@outlook.com>
 <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
 <SN6PR02MB41570BBE17C50675E94789FDD49AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB41570BBE17C50675E94789FDD49AA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8657-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[gmail.com,microsoft.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE188D05A3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:26:42PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, February 2, 2026 9:18 AM
> > 
> > On Mon, Feb 02, 2026 at 08:51:01AM -0800, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > Huge page mappings in the guest physical address space depend on having
> > > matching alignment of the userspace address in the parent partition and
> > > of the guest physical address. Add a comment that captures this
> > > information. See the link to the mailing list thread.
> > >
> > > No code or functional change.
> > >
> > > Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@skinsburskii.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > ---
> > >  drivers/hv/mshv_root_main.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > > index 681b58154d5e..bc738ff4508e 100644
> > > --- a/drivers/hv/mshv_root_main.c
> > > +++ b/drivers/hv/mshv_root_main.c
> > > @@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
> > >  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
> > >  		return mshv_unmap_user_memory(partition, mem);
> > >
> > > +	/*
> > > +	 * If the userspace_addr and the guest physical address (as derived
> > > +	 * from the guest_pfn) have the same alignment modulo PMD huge page
> > > +	 * size, the MSHV driver can map any PMD huge pages to the guest
> > > +	 * physical address space as PMD huge pages. If the alignments do
> > > +	 * not match, PMD huge pages must be mapped as single pages in the
> > > +	 * guest physical address space. The MSHV driver does not enforce
> > > +	 * that the alignments match, and it invokes the hypervisor to set
> > > +	 * up correct functional mappings either way. See mshv_chunk_stride().
> > > +	 * The caller of the ioctl is responsible for providing userspace_addr
> > > +	 * and guest_pfn values with matching alignments if it wants the guest
> > > +	 * to get the performance benefits of PMD huge page mappings of its
> > > +	 * physical address space to real system memory.
> > > +	 */
> > 
> > Thanks. However, I'd suggest to reduce this commet a lot and put the
> > details into the commit message instead. Also, why this place? Why not a
> > part of the function description instead, for example?
> 
> In general, I'm very much an advocate of putting a bit more detail into code
> comments, so that someone new reading the code has a chance of figuring
> out what's going on without having to search through the commit history
> and read commit messages. The commit history is certainly useful for the
> historical record, and especially how things have changed over time. But for
> "how non-obvious things work now", I like to see that in the code comments.
> 

This approach is not well aligned with the existing kernel coding style.
It is common to answer the “why” question in the commit message.
Code comments should focus on “what” the code does.

https://www.kernel.org/doc/html/latest/process/coding-style.html

For more details, it is common to use `git blame` to learn the context
of a change when needed.

> As for where to put the comment, I'm flexible. I thought about placing it
> outside the function as a "header" (which is what I think you mean by the
> "function description"), but the function handles both "map" and "unmap"
> operations, and this comment applies only to "map".  Hence I put it after
> the test for whether we're doing "map" vs. "unmap".  But I wouldn't object
> to it being placed as a function description, though the text would need to be
> enhanced to more broadly be a function description instead of just a comment
> about a specific aspect of "map" behavior.
> 

As for the location, since this documents the userspace API, I would
rather place it above the function as part of the function description.
Even though the function handles both map and unmap, unmap also deals
with huge pages.

Thanks,
Stanislav

> Michael
> 
> > 
> > Thanks,
> > Stanislav
> > 
> > >  	return mshv_map_user_memory(partition, mem);
> > >  }
> > >
> > > --
> > > 2.25.1

