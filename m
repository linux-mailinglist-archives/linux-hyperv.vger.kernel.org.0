Return-Path: <linux-hyperv+bounces-9531-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN/+GtvYumkycgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9531-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 17:54:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D14242BFB45
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D00B434F14D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA213FF884;
	Wed, 18 Mar 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Os/sie"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91D3FD14E;
	Wed, 18 Mar 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850805; cv=none; b=ub1JeJDV+FtWvYQtptTj+yZNyW1Cx2ayKW3gNm0qvl7kyRQGE9moteF3JKixyDcT1rhBnGZEIBSmUUNipQmBbWEwcaOiGrF5y4lA/72NPNGaPV6H9FWd7sgDs6mbJpdpiQWJWoBG42BltMlHWR9zKp4M8qvhKS+ZfxEG7roPKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850805; c=relaxed/simple;
	bh=lkocgiy6RQPr4M88f7zfZp3Q72SQZIa9w6MUnl6qiiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs+hqZhC7wyMedgR6fouPGmKNd/yNRK8e/nvNqzmMSubVhhHDcBmBdwHXWsnuQIO8oeQMhhtTy3Qx8HempB9LuU2V9YU1S8RKOomFwO9DMHYjrxATcnS1LscqDOIrjjmMkGegaYTIx1QV6kUBRle3qPm8kbsj/GfQP72Q6yzCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Os/sie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0652BC2BC87;
	Wed, 18 Mar 2026 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773850805;
	bh=lkocgiy6RQPr4M88f7zfZp3Q72SQZIa9w6MUnl6qiiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9Os/sieKonDWhLerwRR2bAwGXkzuyFzf5AVppp6e0ynTZecYDjD0k8m2a2G85Hm6
	 zRF/oMCfKh1y+XNXL5Tb6ywnNa4tLjwyBCGYuEXlwMhcrol06DY9c7NJVBG/HVzsSP
	 co1BgUuiszE4i4oMY/11/rmhJn0DyzXYsM/yGsuUWTgKlin00x79J+YoEOPq4PAx0D
	 GD0r/L3huX/NwOEgtOfnQ0zVZkCxFkaPmMVtcVudLyCPDWOuqs3vOSKW9PFWTLjhJE
	 7/8WdK7gHqzbjNG0B+dWugNFZnu65JGf+d6Ez/ZsmpBM0klYfg9TGkIRhaKlkPY3uS
	 FTETwNcaW4i7g==
Date: Wed, 18 Mar 2026 16:20:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: Fix error handling in mshv_region_populate_pages
Message-ID: <20260318162003.GB262287@liuwe-devbox-debian-v2.local>
References: <177375989324.25621.6532741522672582851.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157D2316EC9E5B0BAE656C0D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318062001.GA262287@liuwe-devbox-debian-v2.local>
 <SN6PR02MB4157A6D37C19379C74C88ACCD44EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157A6D37C19379C74C88ACCD44EA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9531-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,sashiko.dev:url,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: D14242BFB45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 02:38:49PM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, March 17, 2026 11:20 PM
> > 
> > On Tue, Mar 17, 2026 at 09:56:07PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesday, March 17, 2026 8:05 AM
> > > >
> > > > The current error handling has two issues:
> > > >
> > > > First, pin_user_pages_fast() can return a short pin count (less than
> > > > requested but greater than zero) when it cannot pin all requested pages.
> > > > This is treated as success, leading to partially pinned regions being
> > > > used, which causes memory corruption.
> > > >
> > > > Second, when an error occurs mid-loop, already pinned pages from the
> > > > current batch are not released before calling mshv_region_evict_pages(),
> > > > causing a page reference leak.
> > >
> > > There's now an online LLM-based tool that is automatically reviewing
> > > kernel patches.  For this patch, the results are here:
> > >
> > >
> > https://sashiko.dev/#/patchset/177375989324.25621.6532741522672582851.stgit
> > %40skinsburskii-cloud-desktop.internal.cloudapp.net
> > >
> > > It has flagged the commit message as incorrectly referencing the
> > > function mshv_region_evict_pages(), which doesn't exist.
> > >
> > > FWIW, the announcement about sashiko.dev is here:
> > >
> > > https://lore.kernel.org/lkml/7ia4o6kmpj5s.fsf@castle.c.googlers.com/
> > >
> > > Other than the commit message reference, this looks good to me.
> > >
> > > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > 
> > The second point is written as if the code here should release the
> > already pinned pages before calling mshv_region_invalidate_pages(), but
> > the code actually relies on mshv_mem_region_invalidate_pages() to
> > release the pages. The change here fixes the accounting.
> > 
> >  Second, when an error occurs mid-loop, already pinned pages from the
> >  current batch are not accounted for before calling
> >  mshv_region_invalidate_pages(), causing a page reference leak.
> > 
> > And queued up the patch to hyperv-fixes.
> 
> One other thing I noticed:  The "Subject" of the patch is wrong. It
> mentions mshv_region_populate_pages(), but the function being
> modified is actually mshv_region_pin().

Good catch. I have updated the subject line and pushed to hyperv-fixes.

Wei

> 
> Michael
> 
> > 
> > Wei
> > 
> > >
> > > >
> > > > Fix by treating short pins as errors and explicitly unpinning the
> > > > partial batch before cleanup.
> > > >
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >  drivers/hv/mshv_regions.c |    6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > > > index c28aac0726de..fdffd4f002f6 100644
> > > > --- a/drivers/hv/mshv_regions.c
> > > > +++ b/drivers/hv/mshv_regions.c
> > > > @@ -314,15 +314,17 @@ int mshv_region_pin(struct mshv_mem_region *region)
> > > >  		ret = pin_user_pages_fast(userspace_addr, nr_pages,
> > > >  					  FOLL_WRITE | FOLL_LONGTERM,
> > > >  					  pages);
> > > > -		if (ret < 0)
> > > > +		if (ret != nr_pages)
> > > >  			goto release_pages;
> > > >  	}
> > > >
> > > >  	return 0;
> > > >
> > > >  release_pages:
> > > > +	if (ret > 0)
> > > > +		done_count += ret;
> > > >  	mshv_region_invalidate_pages(region, 0, done_count);
> > > > -	return ret;
> > > > +	return ret < 0 ? ret : -ENOMEM;
> > > >  }
> > > >
> > > >  static int mshv_region_chunk_unmap(struct mshv_mem_region *region,
> > > >
> > > >
> > >
> 

