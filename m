Return-Path: <linux-hyperv+bounces-8914-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MfLM+qxlmmRjwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8914-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 07:47:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1E15C750
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 07:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64A8E301371C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60AF3161A0;
	Thu, 19 Feb 2026 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0qhI6Iw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DD31619A;
	Thu, 19 Feb 2026 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483623; cv=none; b=ExdBPIG7LH4s+qqx2ku/2pebHvSIp2ur9ejtRixve+9WRFIm4iG1uiwlhWM877lzwTHQBQoGHo3ih0VK1BgEVbgSeYAmGE83ul2c/GREwnp0unK5LOh+QUL0+ZcKzZazhslX4mqiJ+pRY1vC1y2tf+kNQ6324s1A8CKEA8nTVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483623; c=relaxed/simple;
	bh=QgqRoIORz5Xbc8FLK3mws1pGcMn83NsHMWOEpMYUSKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3+Wk3RaoZuotNEuE68sYp89xCez92fX3PqkxpLWWk949i7UpmkW8Tku7EGKGZBsziRIMkerpPWWKCmEIeQiM0SIg8YoVgYuW0tbM+jpoAIDP5bcOTGoWVR8p8UnfUpAPvisSR5Q7Vl77/OC9Kl1KGno30k4esCayOYhm/WWvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0qhI6Iw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026DCC4CEF7;
	Thu, 19 Feb 2026 06:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771483623;
	bh=QgqRoIORz5Xbc8FLK3mws1pGcMn83NsHMWOEpMYUSKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0qhI6Iw11SFRFUQdwD2+TkT9cvQE8kjGo6DuPS5hTVPU90TSIt2X/nkulC/SSi4i
	 /6vKvIdWJTbuVZVhTkiCL0drLUUjmM567qjrVxE97KupdSXxyS0MVyuts7jdIm6e3/
	 rH00m5ohJdoUgbbXltstOv5zPlMScx5vafRRsJwlDXtNfkRWr2kpHVzhae9Df69+u8
	 dnsCNQqO4ZzZAOJprtrc+3hd8EF13BPvc5dOyU9JSXuS3hZK1fRLaFNU+ckospHG4U
	 +Cy7yZeGoWuyFNorR2nZ4fUhHuU5EzAPJOIy+rasOKIUAnsK56eqnjo+ktgf9z06xl
	 dWehZTl6vVo9g==
Date: Thu, 19 Feb 2026 06:47:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Message-ID: <20260219064701.GQ2236050@liuwe-devbox-debian-v2.local>
References: <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB4157F28C4F4CEFB886CF949ED466A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F28C4F4CEFB886CF949ED466A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8914-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 6EB1E15C750
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:54:55PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Thursday, February 5, 2026 10:42 AM
> > To: kys@microsoft.com; haiyangz@microsoft.com; wei.liu@kernel.org;
> > decui@microsoft.com; longli@microsoft.com
> > Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor statuses
> > 
> > When creating guest partition objects, the hypervisor may fail to
> > allocate root partition pages and return an insufficient memory status.
> > In this case, deposit memory using the root partition ID instead.
> > 
> > Note: This error should never occur in a guest of L1VH partition context.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c      |    2 +
> >  drivers/hv/hv_proc.c        |   14 ++++++++++
> >  include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
> >  3 files changed, 46 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index f20596276662..6b67ac616789 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -794,6 +794,8 @@ static const struct hv_status_info hv_status_infos[] = {
> >  	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
> >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
> >  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
> > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
> > +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY, 	-ENOMEM),
> >  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
> >  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
> >  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index 181f6d02bce3..5f4fd9c3231c 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -121,6 +121,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
> >  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> >  		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> >  		break;
> > +
> > +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> > +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> > +		fallthrough;
> > +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> > +		if (!hv_root_partition()) {
> > +			hv_status_err(hv_status, "Unexpected root memory deposit\n");
> > +			return -ENOMEM;
> > +		}
> > +		partition_id = HV_PARTITION_ID_SELF;
> > +		break;
> > +
> 
> Per the discussion in v1 of this patch set, if the number of pages that should be
> deposited in a particular situation is different from what this function provides,
> the fallback is to use hv_call_deposit_pages() directly. From what I see, there's
> only one such fallback case after a hypercall failure -- in hv_do_map_gpa_hcall().
> The other uses of hv_call_deposit_pages() are initial deposits when creating a
> VP or partition.
> 
> But if hv_call_deposit_pages() is used directly, the logic added here to detect
> insufficient root memory and deposit to HV_PARTITION_ID_SELF isn't applied.
> So if the hypercall in hv_do_map_gpa_hcall() fails with insufficient root
> memory, the deposit is done to the wrong partition ID. If that case can
> actually happen, then some additional logic is needed in
> hv_do_map_gpa_hcall() to handle it. Or there needs to be a fallback
> function that contains the logic.

Stanislav, how about this comment? Please submit a follow-up patch if
necessary.

Wei

> 
> Other than that, everything else in this patch set looks good to me.
> 
> Michael
> 
> >  	default:
> >  		hv_status_err(hv_status, "Unexpected!\n");
> >  		return -ENOMEM;

