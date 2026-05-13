Return-Path: <linux-hyperv+bounces-10843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFZtOh+3BGplNQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10843-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 19:38:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7153826F
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2BA430087CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2918C4DBD7E;
	Wed, 13 May 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SE+AZnMP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6C44DBD62;
	Wed, 13 May 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693917; cv=none; b=LOTezmE9JM2UAWB8VEYklTe7KaQrpl031by17uG0DhpRnY1gY+MewEvTP4mNI3eN8yOEDzfdu5nwHmMRikCHYFCjAV4djfgpnZpFrFklexkA15EMCCV/oAywVQIfjWDXhcdAmomnEF5HQNf5IAXiw9bWYbWXuEWFCtWEDYu1Fuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693917; c=relaxed/simple;
	bh=5Gqn8U7uc/hG3U4Hq948ZJlRJtIrObE2Oxi8mHM4shQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYGQ6FJ0H2b8yTJLGCG1m5Onv81ZtZvey6C6NWYlIUYgUdEUALaczeoOq6HcUauNuz86j7Xyto9qMIEzv0X+uCY3E1Uz/QQMEJ6nIKE6oidUOWDUMLyX2oiSFUDyW/xXS/6aPi7RB+hKyMAPKG1DsMWHSkTutzZs+lor7pZZ3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SE+AZnMP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 69D4E20B7166;
	Wed, 13 May 2026 10:38:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69D4E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778693912;
	bh=/YyH/95ZYgu2flRaBKjQ0xklYRH72Ugu0DOyzunRhZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SE+AZnMPEvke7aWB+0Pd5bpu9itybnq2sCwSuom5wrbhV5U9aoNIxu/l3+H4MGAtl
	 nEf2Ll8svNrsaSNl9lZjt8ZpcRVEZvPzMo4Cz0S08WjUR8bZZTOsg+D5VNACkDrFfI
	 It4G9aKMycpU3Vk12+bLBOh/JtF5s0P4CpxVYL2I=
Date: Wed, 13 May 2026 10:38:32 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/18] mshv: Fix level-triggered check on
 uninitialized data
Message-ID: <agS3GOct6mPN6sN9@skinsburskii.localdomain>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816862362.21765.11809618639989414561.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260513-omniscient-enchanted-otter-dfd602@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513-omniscient-enchanted-otter-dfd602@anirudhrb>
X-Rspamd-Queue-Id: 87B7153826F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10843-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 12:14:49PM +0000, Anirudh Rayabharam wrote:
> On Thu, May 07, 2026 at 03:43:43PM +0000, Stanislav Kinsburskii wrote:
> > In mshv_irqfd_assign(), the level-triggered validation for resample
> > irqfds checks irqfd_lapic_irq.lapic_control.level_triggered before
> > mshv_irqfd_update() has populated the field. Since the irqfd struct is
> > zero-allocated, level_triggered is always 0 at that point, causing the
> > check to always reject resample irqfds with -EINVAL. This makes
> > level-triggered interrupt resampling — used to avoid interrupt storms
> > with assigned devices — completely non-functional.
> 
> What bugs would this manifest as? Why haven't we seen any such bugs so
> far?
> 

This patch fixes a logical error.
Whtout the change this hunk always fails:

        if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE) &&
            !irqfd->irqfd_lapic_irq.lapic_control.level_triggered) {

and the reason we never seen it as that we never used
register_irqfd_with_resample() function of the mshv crate.

Thanks,
Stanislav

> Thanks,
> Anirudh.

