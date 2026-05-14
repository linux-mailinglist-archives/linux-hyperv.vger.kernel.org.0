Return-Path: <linux-hyperv+bounces-10884-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM3+NGJiBWrsVgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10884-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 07:49:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF053E1A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 07:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D7733012565
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599C433F361;
	Thu, 14 May 2026 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ERsHYNiO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F253264D9;
	Thu, 14 May 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737758; cv=pass; b=R3UVuUIWAZ8UzEQ4ncrz7PDakzWoDgsocoLxOMDXTBjmrJEZenjqsVW3rLwpAtmGHOkd+r1AO9CRwyLvVVtUBCqoVogEjMFYnWICi3Kgc/l3PMDldrPtJ7iUZHQSdKbiIiRR0z1K4SFBIrgx5h44QMPnH5UU99R73To2iqCD5qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737758; c=relaxed/simple;
	bh=h2BARqbKG83wZP5Hq9WelWBOsglK9DzdXP4GNBBf8io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIr+dKmiDLZVCO3F7oM3sm6t6WiN+/VZN7ZJIQyaS7Aeow0c+vquVaIycrjM/kNb6/6jqGvcaO3Yr4BBNxWoXNTtpk9tRupregyMGQAnGU7I27euJMc70bP3d3IpCBZe15a/Bs09JYO8BgZC8DJmhItPN3EUYwEp5jxWzt+EoB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ERsHYNiO; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778737749; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iaew9X24/dEUqYHZESmWvFpuQfakmKvELRz7b43iWAXLMYhp2tFXdIKaV58bWe7mEcx7AIvbv1RgVXpX6p5KTlcztKTY8rXzBcoC8PKCxRRP/YJqir85bsl4WgXltVvd/0/b/MIgzxucKzlGnAi5zHjbrMIPhiAcTtuwilq7LB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778737749; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qo0N13irtQ1o/rloqp3aahk4ZykigfwlhJaufasbZbo=; 
	b=eer6PuJdUIvQNNyZpEWkBQs4+A+iylWW39YWhkq/dudy8wvXsKLkjTPyx48WrjR7BsTh59a+wc1XcDXyfFxApRbqxtb2JN5yL+jKdZ2wMk5nAEa3o4LykTGuIiQ27M/dfN1B+PKKauRYtXMWRozXEXiJ+DhmQ48SmgZURnL9dcM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778737748;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Qo0N13irtQ1o/rloqp3aahk4ZykigfwlhJaufasbZbo=;
	b=ERsHYNiOqCM4Ygm9Rlef7/5LYpDoKDsWwz6XkUobJtflmi4WhCGYbuT53PLH9oK2
	/g2OItaKyW2jGnv1q5SsoartdU8jbcXd5G8S/jgaDXHTOyLlxnVsxRWJRd2fP+EjO28
	4I8mk30meKdeuemtcsztYBj3gxzLU4rc3xIoPduQ=
Received: by mx.zohomail.com with SMTPS id 1778737746351851.5099280986504;
	Wed, 13 May 2026 22:49:06 -0700 (PDT)
Date: Thu, 14 May 2026 05:49:01 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/18] mshv: Validate scheduler message bounds from
 hypervisor
Message-ID: <20260514-efficient-frisky-mastiff-ccdaf7@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816866691.21765.15605640837157423543.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260513-grinning-firefly-of-refinement-ed06cd@anirudhrb>
 <agS3U8CRnqfYaDuI@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agS3U8CRnqfYaDuI@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 80BF053E1A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10884-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:39:31AM -0700, Stanislav Kinsburskii wrote:
> On Wed, May 13, 2026 at 11:12:05AM +0000, Anirudh Rayabharam wrote:
> > On Thu, May 07, 2026 at 03:44:26PM +0000, Stanislav Kinsburskii wrote:
> > > handle_pair_message() iterates up to msg->vp_count without verifying it
> > > against HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT. Since vp_count is read
> > > from untrusted hypervisor data, a malformed message with a large value
> > > would cause out-of-bounds reads from the partition_ids and vp_indexes
> > > arrays.
> > > 
> > > handle_bitset_message() iterates over set bits in valid_bank_mask (up to
> > > 64) and advances bank_contents for each one. However, the payload buffer
> > > only has space for 16 bank entries. A valid_bank_mask with more than 16
> > > bits set causes bank_contents to read beyond the message buffer.
> > > 
> > > Fix both by adding bounds validation:
> > > - Clamp vp_count to HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT
> > > - Track banks consumed and stop before exceeding buffer capacity
> > > 
> > > Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > ---
> > >  drivers/hv/mshv_synic.c |   20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > > index 89207aad7cf1f..5d509299f14d7 100644
> > > --- a/drivers/hv/mshv_synic.c
> > > +++ b/drivers/hv/mshv_synic.c
> > > @@ -190,7 +190,9 @@ static void kick_vp(struct mshv_vp *vp)
> > >  static void
> > >  handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
> > >  {
> > > -	int bank_idx, vps_signaled = 0, bank_mask_size;
> > > +	int bank_idx, vps_signaled = 0, bank_mask_size, banks_used = 0;
> > > +	const int max_banks = sizeof(msg->vp_bitset.bitset_buffer) /
> > > +			      sizeof(u64) - 2; /* subtract format + mask */
> > 
> > Could this be a constant in the header?
> > 
> 
> Yes, it could. But it the only place it's used and it's pretty
> self-explanatory, so I don't think it needs to be.

The "subtract format+mask" part is a bit concerning. We might forget to update
this code if the struct layout ever changes. Whereas if the constant is
right next to the definition in the header, it is unlikely to be missed.

Thanks,
Anirudh.


