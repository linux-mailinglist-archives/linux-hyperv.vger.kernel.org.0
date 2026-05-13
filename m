Return-Path: <linux-hyperv+bounces-10844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEdhFnW6BGplNQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10844-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 19:52:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E055385D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 19:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 930F93132AFA
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 17:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF34C9577;
	Wed, 13 May 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mcwq48sZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D93ECBF9;
	Wed, 13 May 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693975; cv=none; b=mGMPYTxk4HDfF5lq51gwb917RuVAHAGYReN9FGu3sB8dt1WhVSSZDIccwV2KW8NyeiZH+dRslgDIWcQi2Xgp3C5ldGid4t6GgbZAgFAXul02zc8wB98Yvp4X6i4CGfyx9Phx39qhEwcxO94dlwJgVRQ/v/aXPn0EOhLszaG07nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693975; c=relaxed/simple;
	bh=E5HP1V8X93zqp/T9eb/9EJafxYcIFTPj6Hu+xQ5C2Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE1dx58sLpiLYG/yxTejDBeSqCz6ElAvPu7A8VOX/GZOZLHB30+wvW9i7xXIj5oW6bRFdEtg0b9D0DqTQ4fGDHTtYLKCBWGokm/FPKPa5Tt1jb/z9ynDR9XeQPKcl2mjBkV0hlYO38rqgWfPHUDyicKBHkQsarmRVS/tpBHkjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mcwq48sZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B4D420B7166;
	Wed, 13 May 2026 10:39:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B4D420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778693971;
	bh=WOcqPJrXbkUK43r4iB04iqWdH3h0VgJdoD8cjBwEUcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcwq48sZ766UPTT7Fd9dVkxSg3yB7MuQM8EOVYjcs5IwuDm5Fsr5G2EooVHQRH/dw
	 OvNOakT8q46og38UYfkvf4vh5SEhE3Oqhphww8G9OAJOKpfl77XUgU37JqV+yrcIKp
	 egEknMjsoNVKWf7X63kWjgLVPI6y5El9+rPAEf0c=
Date: Wed, 13 May 2026 10:39:31 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/18] mshv: Validate scheduler message bounds from
 hypervisor
Message-ID: <agS3U8CRnqfYaDuI@skinsburskii.localdomain>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260513-grinning-firefly-of-refinement-ed06cd@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-grinning-firefly-of-refinement-ed06cd@anirudhrb>
X-Rspamd-Queue-Id: A9E055385D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10844-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:12:05AM +0000, Anirudh Rayabharam wrote:
> On Thu, May 07, 2026 at 03:44:26PM +0000, Stanislav Kinsburskii wrote:
> > handle_pair_message() iterates up to msg->vp_count without verifying it
> > against HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT. Since vp_count is read
> > from untrusted hypervisor data, a malformed message with a large value
> > would cause out-of-bounds reads from the partition_ids and vp_indexes
> > arrays.
> > 
> > handle_bitset_message() iterates over set bits in valid_bank_mask (up to
> > 64) and advances bank_contents for each one. However, the payload buffer
> > only has space for 16 bank entries. A valid_bank_mask with more than 16
> > bits set causes bank_contents to read beyond the message buffer.
> > 
> > Fix both by adding bounds validation:
> > - Clamp vp_count to HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT
> > - Track banks consumed and stop before exceeding buffer capacity
> > 
> > Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_synic.c |   20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > index 89207aad7cf1f..5d509299f14d7 100644
> > --- a/drivers/hv/mshv_synic.c
> > +++ b/drivers/hv/mshv_synic.c
> > @@ -190,7 +190,9 @@ static void kick_vp(struct mshv_vp *vp)
> >  static void
> >  handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
> >  {
> > -	int bank_idx, vps_signaled = 0, bank_mask_size;
> > +	int bank_idx, vps_signaled = 0, bank_mask_size, banks_used = 0;
> > +	const int max_banks = sizeof(msg->vp_bitset.bitset_buffer) /
> > +			      sizeof(u64) - 2; /* subtract format + mask */
> 
> Could this be a constant in the header?
> 

Yes, it could. But it the only place it's used and it's pretty
self-explanatory, so I don't think it needs to be.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 

