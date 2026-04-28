Return-Path: <linux-hyperv+bounces-10450-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPdHIzw88Wn/ewEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10450-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:01:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0448CE15
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E7B3024C9F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827942701C4;
	Tue, 28 Apr 2026 23:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L+SkPt+e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61EE277C9D;
	Tue, 28 Apr 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417245; cv=none; b=GNnr8pBPtVyBwWfCh4bR8E4fpr21ot/Bfg0ruVgjoe45xR4TvS5EFiaSUxc+TGNMcQhcEWx+rmlCUoejxUJsKcTZQOIeiECiCLj1HQnn5JPmGvPQsX8R4jOU8ks7pGJtoJ4J0EmgR/zIROqv85Ov4Bc6Yz5tDFE6Q9f/Cm9Qtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417245; c=relaxed/simple;
	bh=+qPotZrVmieK9fINHPN4p7gG0UURmWg0eK1ydRumQuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3FfRehnQgD9V+ziyu3zcko0Umuj7T/8wLKbIUwmOccnUwHI81CWJzAJkfUk1DAktm755ZNdsYhq9LV0EihaPdyty5Kn8TVc56oTthptu9lx8rAyGqLfxFQ0F/kdhqntrWXvbaKpu1cyBu4Fk8biubFTOqeyHYVC5vC3XvyT5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L+SkPt+e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 702B720B716C;
	Tue, 28 Apr 2026 16:00:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 702B720B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777417242;
	bh=40WJ/69pm/f4cjBM8m0NlD31zgRcqfwxnoWppyYXRxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+SkPt+eYR4+IN/PEQmQKfYaniN6r6dUdri3jfE6DZni42eeK8h3RorQLmrjTi9oZ
	 aA+PQhj57bmth72CqThmcBGS/zihWDTJGY/ux+xDcf0Qdm4ND0FzSLisELukxLieFX
	 L/ypKqa/SiM0tFCy7r14ZNlYi9llmVcol1DDuO8U=
Date: Tue, 28 Apr 2026 16:00:40 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mshv: Fix interrupt state corruption in
 hv_do_map_pfns error path
Message-ID: <afE8GJr8hkB7QTyn@skinsburskii.localdomain>
References: <177730104962.21733.4130809041576931551.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41578863BCE23D41B6A521B8D4372@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578863BCE23D41B6A521B8D4372@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: D9F0448CE15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-10450-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]

On Tue, Apr 28, 2026 at 12:20:35AM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, April 27, 2026 7:44 AM
> > 
> > Restore interrupt state before breaking out of the loop on error.
> > 
> > The irq_flags are saved before entering the loop, but the early exit
> > path on error fails to restore them. This leaves interrupts in an
> > inconsistent state and can lead to lockdep warnings or other
> > interrupt-related issues.
> > 
> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_hv_call.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> > index ab210a7fcb8c3..61291ec6f3468 100644
> > --- a/drivers/hv/mshv_root_hv_call.c
> > +++ b/drivers/hv/mshv_root_hv_call.c
> > @@ -229,8 +229,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
> >  			} else {
> >  				pfnlist[i] = mmio_spa + done + i;
> >  			}
> > -		if (ret)
> > +		if (ret) {
> > +			local_irq_restore(irq_flags);
> >  			break;
> > +		}
> > 
> 
> This looks good for fixing the immediate bug.
> 
> But I'd note that this error path occurs solely based on the
> if (index >= page_struct_count) test in the preceding 'for' loop. That test is a
> "can't happen" sanity test that never triggers if hv_do_map_gpa_hcall()
> is coded correctly. At the beginning of the function there are validations of
> the input arguments, which is reasonable. But this sanity test isn't based
> on the input arguments, and it adds non-trivial complexity to the code
> because of the nested loops and the need to figure out where the two
> "break" statements go. I'd argue for dropping the sanity test entirely,
> along with this test of 'ret' and the need to restore the interrupt state.
> 

Fair enough. Let me rework this function (and it's unmap peer).

Thanks,
Stanislav

> Michael

