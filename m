Return-Path: <linux-hyperv+bounces-10887-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJk/HCTqBWr5dQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10887-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 17:28:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7229544090
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CEF130ED405
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262B30B51D;
	Thu, 14 May 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XieUoy1N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504622CBD9;
	Thu, 14 May 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771848; cv=none; b=UZB00OjQD5nGON1DNBSg/DKsIEb+Fe0CBpAcvYURh0JvH1aDkWbNhzI6eEeuyuFJLSDExGIoibTrLWXnKO7AIUldGEBuZ8oWqTUxDFUrL/ebVM9UKwILq0x+yBhdW1tI74Pj/IqqdVCFeK0L6TwueWHm6Gjl6d6DrQbtRN2uH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771848; c=relaxed/simple;
	bh=Tzd+HMgQNnTF931EbZvv4+0Pgdx517VnszvaLRepDeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlwZxVknmRkZVpMg4pRs6UWghMokOtDAKhIq2AGAQRWI8JCi6SGzwYEroNlvMwD8e/SIl3ohCcqWrDfj7YFI/4M+bCErxOsMaBfQP9FLjzVs4jDtX4nHzKMhTd1XPjSFlrOq9hIJJdoD9ZGRrY9bUWxMmiyXu8JXWWUERUISI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XieUoy1N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16DA420B7166;
	Thu, 14 May 2026 08:17:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16DA420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778771842;
	bh=Yirn10u9jhGU67Rq//B88RikUo5ZJWlMf+jtlIG7F7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XieUoy1NjGCTk3sZUUVbPcRIbPoBtfztaVbTK/Glm/qK8sZSs5hYfdYaNmpOvEQGV
	 USXBjow9pufH0Z9M78WWF1VRqFtsvydvfxs/cpEn8LkGNt3ARUT0FqUgyXwT8z7d83
	 bCHjLlTWy7DKDCHUIgZOmyQBYrRFvxkHqZ4epTGg=
Date: Thu, 14 May 2026 08:17:23 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/18] mshv: Validate scheduler message bounds from
 hypervisor
Message-ID: <agXng9ZZcg2-rCn-@skinsburskii.localdomain>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260513-grinning-firefly-of-refinement-ed06cd@anirudhrb>
 <agS3U8CRnqfYaDuI@skinsburskii.localdomain>
 <20260514-efficient-frisky-mastiff-ccdaf7@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-efficient-frisky-mastiff-ccdaf7@anirudhrb>
X-Rspamd-Queue-Id: C7229544090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10887-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Thu, May 14, 2026 at 05:49:01AM +0000, Anirudh Rayabharam wrote:
> On Wed, May 13, 2026 at 10:39:31AM -0700, Stanislav Kinsburskii wrote:
> > On Wed, May 13, 2026 at 11:12:05AM +0000, Anirudh Rayabharam wrote:
> > > On Thu, May 07, 2026 at 03:44:26PM +0000, Stanislav Kinsburskii wrote:
> > > > handle_pair_message() iterates up to msg->vp_count without verifying it
> > > > against HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT. Since vp_count is read
> > > > from untrusted hypervisor data, a malformed message with a large value
> > > > would cause out-of-bounds reads from the partition_ids and vp_indexes
> > > > arrays.
> > > > 
> > > > handle_bitset_message() iterates over set bits in valid_bank_mask (up to
> > > > 64) and advances bank_contents for each one. However, the payload buffer
> > > > only has space for 16 bank entries. A valid_bank_mask with more than 16
> > > > bits set causes bank_contents to read beyond the message buffer.
> > > > 
> > > > Fix both by adding bounds validation:
> > > > - Clamp vp_count to HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT
> > > > - Track banks consumed and stop before exceeding buffer capacity
> > > > 
> > > > Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >  drivers/hv/mshv_synic.c |   20 ++++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > > > index 89207aad7cf1f..5d509299f14d7 100644
> > > > --- a/drivers/hv/mshv_synic.c
> > > > +++ b/drivers/hv/mshv_synic.c
> > > > @@ -190,7 +190,9 @@ static void kick_vp(struct mshv_vp *vp)
> > > >  static void
> > > >  handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
> > > >  {
> > > > -	int bank_idx, vps_signaled = 0, bank_mask_size;
> > > > +	int bank_idx, vps_signaled = 0, bank_mask_size, banks_used = 0;
> > > > +	const int max_banks = sizeof(msg->vp_bitset.bitset_buffer) /
> > > > +			      sizeof(u64) - 2; /* subtract format + mask */
> > > 
> > > Could this be a constant in the header?
> > > 
> > 
> > Yes, it could. But it the only place it's used and it's pretty
> > self-explanatory, so I don't think it needs to be.
> 
> The "subtract format+mask" part is a bit concerning. We might forget to update
> this code if the struct layout ever changes. Whereas if the constant is
> right next to the definition in the header, it is unlikely to be missed.
> 

Fair enough. But I'd suggest sending this a a follow up for the series.
What do you think?

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 

