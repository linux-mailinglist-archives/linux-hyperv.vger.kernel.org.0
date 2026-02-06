Return-Path: <linux-hyperv+bounces-8755-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNPQMFKGhWl8DAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8755-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 07:12:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D80FA938
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 07:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA2230097E4
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Feb 2026 06:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151F2EC0A2;
	Fri,  6 Feb 2026 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="PRlOomuk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2033EBF05;
	Fri,  6 Feb 2026 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358350; cv=pass; b=I2deMDeRhuQcWsJvBWvmqAWOi+67jBKYMDg2m9Yh3TyAGqttaNB9Pk+y1nLNdgDmmLtFwHP7JGxY9jOD0Jx/VF3Ds5qVkDjZcuoUb0liY0mQUPUG4nwmW/yh9K9J0NxO+mvkMjFWKS4NEO5chp9s+TRNYxoQv4uv8ESTwcQZ9sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358350; c=relaxed/simple;
	bh=Nsi3goq/+AWSEAEJzkfVEJfWM9qPP9s5XwHsM59s0sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVWy/hS4hF3CkWLk/YMJ4drcKIeT/weVWKq5CN1bbaREFnQ5RtugLY1ZG+f3WAX+lna8PJ7Oa44ASlC9Fobi4+FKFvJ2Om1OU0nQ54dHWQqD/KD0K4tpRKJ8stKxUkLlnhyUOMJ2UIXNKahCR3lfBQIZ7efAsp781OmCr/xg0Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=PRlOomuk; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770358338; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QRY/QmTBwvj+I09YsAi0KxgBUBWabEL4D/O2+Nv7gY9S3dcgupu15+pzcCzAqlqFfIX5O6gnv0Y4HlR8eYdpNlL+BlsEH6NTbgtuWKfa6frcMxmfNgwifevYUs+dsgGglspHfQKKEVP1bGxONRFDbW2YtUVxazsZSHfjhbPA1yw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770358338; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tMIpJpqsyF15BSLsPMFRu5kddMyhH6BXXrYvBD8abZM=; 
	b=O0bSncGG+LFJerGoYIjmWui7p5pVpFFZimsWs+S0dbO95oodU2WSo1GaAPDYqUKeHqHfr9tgW02Vv2SRlis/5nuZUh3PuBHa73I6lm73bJSebeXKS84lgkFnScLR7tba5l0Ow+KpEatyw5CKmodVOzf0wd0/r7M8wx0ZbtWUo5I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770358338;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tMIpJpqsyF15BSLsPMFRu5kddMyhH6BXXrYvBD8abZM=;
	b=PRlOomuk8hIHVdUUQtPzXWx7UOf7uyJaJZlG2+dfL1amqVn0/s36f2qvlCYt3ZWP
	1p2s0wTHGAYPHyjqeKXC1KqEboxwumXd9sS5QUHk70zgjDyt0Nn2c2O+jw7a4tpxHHd
	eHZ58Q46UlR+S1stbYHy1I5gZkQEAHgUO1xxHEag=
Received: by mx.zohomail.com with SMTPS id 177035833432879.17569134689495;
	Thu, 5 Feb 2026 22:12:14 -0800 (PST)
Date: Fri, 6 Feb 2026 06:12:08 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Message-ID: <aYWGOPrHZTU56Zrb@anirudh-surface.localdomain>
References: <20260202165101.1750-1-mhklinux@outlook.com>
 <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
 <SN6PR02MB41570BBE17C50675E94789FDD49AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aYDzU5ujoBlzWaa6@skinsburskii.localdomain>
 <SN6PR02MB41575CA65B0A07C935F85665D49BA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575CA65B0A07C935F85665D49BA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-8755-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,gmail.com,microsoft.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudh-surface.localdomain:mid,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: 10D80FA938
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 06:35:40PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, February 2, 2026 10:56 AM
> > 
> > On Mon, Feb 02, 2026 at 06:26:42PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, February 2, 2026 9:18 AM
> > > >
> > > > On Mon, Feb 02, 2026 at 08:51:01AM -0800, mhkelley58@gmail.com wrote:
> > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > >
> > > > > Huge page mappings in the guest physical address space depend on having
> > > > > matching alignment of the userspace address in the parent partition and
> > > > > of the guest physical address. Add a comment that captures this
> > > > > information. See the link to the mailing list thread.
> > > > >
> > > > > No code or functional change.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@skinsburskii.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
> > > > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > > > ---
> > > > >  drivers/hv/mshv_root_main.c | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > >
> > > > > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > > > > index 681b58154d5e..bc738ff4508e 100644
> > > > > --- a/drivers/hv/mshv_root_main.c
> > > > > +++ b/drivers/hv/mshv_root_main.c
> > > > > @@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
> > > > >  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
> > > > >  		return mshv_unmap_user_memory(partition, mem);
> > > > >
> > > > > +	/*
> > > > > +	 * If the userspace_addr and the guest physical address (as derived
> > > > > +	 * from the guest_pfn) have the same alignment modulo PMD huge page
> > > > > +	 * size, the MSHV driver can map any PMD huge pages to the guest
> > > > > +	 * physical address space as PMD huge pages. If the alignments do
> > > > > +	 * not match, PMD huge pages must be mapped as single pages in the
> > > > > +	 * guest physical address space. The MSHV driver does not enforce
> > > > > +	 * that the alignments match, and it invokes the hypervisor to set
> > > > > +	 * up correct functional mappings either way. See mshv_chunk_stride().
> > > > > +	 * The caller of the ioctl is responsible for providing userspace_addr
> > > > > +	 * and guest_pfn values with matching alignments if it wants the guest
> > > > > +	 * to get the performance benefits of PMD huge page mappings of its
> > > > > +	 * physical address space to real system memory.
> > > > > +	 */
> > > >
> > > > Thanks. However, I'd suggest to reduce this commet a lot and put the
> > > > details into the commit message instead. Also, why this place? Why not a
> > > > part of the function description instead, for example?
> > >
> > > In general, I'm very much an advocate of putting a bit more detail into code
> > > comments, so that someone new reading the code has a chance of figuring
> > > out what's going on without having to search through the commit history
> > > and read commit messages. The commit history is certainly useful for the
> > > historical record, and especially how things have changed over time. But for
> > > "how non-obvious things work now", I like to see that in the code comments.
> > >
> > 
> > This approach is not well aligned with the existing kernel coding style.
> > It is common to answer the "why" question in the commit message.
> > Code comments should focus on "what" the code does.
> > 
> > https://www.kernel.org/doc/html/latest/process/coding-style.html
> > 
> 
> Which says "Instead, put the comments at the head of the function,
> telling people what it does, and possibly WHY it does it." I'm good with
> that approach.
> 
> > For more details, it is common to use `git blame` to learn the context
> > of a change when needed.
> 
> Yep, I use that all the time for the historical record.
> 
> > 
> > > As for where to put the comment, I'm flexible. I thought about placing it
> > > outside the function as a "header" (which is what I think you mean by the
> > > "function description"), but the function handles both "map" and "unmap"
> > > operations, and this comment applies only to "map".  Hence I put it after
> > > the test for whether we're doing "map" vs. "unmap".  But I wouldn't object
> > > to it being placed as a function description, though the text would need to be
> > > enhanced to more broadly be a function description instead of just a comment
> > > about a specific aspect of "map" behavior.
> > >
> > 
> > As for the location, since this documents the userspace API, I would
> > rather place it above the function as part of the function description.
> > Even though the function handles both map and unmap, unmap also deals
> > with huge pages.
> 
> I'll do a version written as the function description. But the full function
> description will be more extensive to cover all the "what" that this function
> implements:
> * input parameters, and their valid values
> * map and unmap
> * when pinned vs. movable vs. mmio regions are created
> * what is done with huge pages in the above cases (i.e., a massaged version
>    of what I've already written)
> * populating and pinning of pages for pinned regions

I'm happy to approve such a version of this patch.

Also, if you want to limit yourself to the map behavior and not unmap,
you could also place this in the description of mshv_map_user_memory().
I would happily approve such a patch as well.

Overall, I think your comment is very useful and points out things that
are easy to miss while reading, modifying or reviewing this code in the
future. I also believe that this information is better as a comment here
than a commit message as has been suggested elsewhere in this thread.

Thanks,
Anirudh.


