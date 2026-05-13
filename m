Return-Path: <linux-hyperv+bounces-10832-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHCuEoRrBGprIQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10832-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 14:16:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BF532E93
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1766030068D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30740626D;
	Wed, 13 May 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="gFh9Mutg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304A3FF892;
	Wed, 13 May 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674506; cv=pass; b=mMzOM0rJQ/e2LVa50Wgxi3ZFZDm7q17bN9xH+CcalOiyIFVhNMU6v0NQjR3Reg/xKwjBp9BvpofWVsR+Oa6IFfFBcHlnrUbANEreB2yazcU70LrtOmN6GVNMLBakN+XLgHEghmRyOXsX6JJSnQGZ742qHs0Zw+6/WERi9/3gdYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674506; c=relaxed/simple;
	bh=suKrZx9WF1Eqg/NdqIGSgk1jONz+zU2yuOt46M6v/Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyFNcf/BqmPdCKgT1Rckso+sBy7HqzRrpcJQPeCvma6sDDaxav5WJiFvjJ0QHh0m7ayKovXp/PAfdj8Mnavux1PAxwXckt/SaXdi5x+7y1bh77p6sBdJbKQqEluW6SJZDTTzIodZKYHNYaujHpm6/u+7VUu0n/TslYNOplNoEYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=gFh9Mutg; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778674498; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SwKmkQFRlm+csYrgQktKylPjF6I8SYZoRUYr8Ah/m8Y1lyHcQtrC32pC61/gJpjRkHedD2FGq9Xv4EQuiT9PGZawNzzFdDSV2XVSjmw9Dn+MmI7i9feNQQd9c4aJo4qsVS+J8750cY3DfT994lo9USLdohFNbRyQnXdpsEH0EOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778674498; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=suKrZx9WF1Eqg/NdqIGSgk1jONz+zU2yuOt46M6v/Oo=; 
	b=OuBqvGoDp7XumKlJFXkiIUo74FDbhoyxGfqvWBmFXeipKi8CNWNVoP0XX+bstA1ZmBOolrqMy1QSQiFTj1MLDL9/zSc/tHJNijWXdU0jxvI6hA5e6qYyngy5yH0Xdrm57qV2spLcTQr8+8P4gVGXs+lhZGJafLjMDS6kLy6o4yQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778674498;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=suKrZx9WF1Eqg/NdqIGSgk1jONz+zU2yuOt46M6v/Oo=;
	b=gFh9MutgbeLM0FjJn71jM4Gt4nv2Kx22DB9y3TukHOtmhOuPK1gZd3bSVnX42lN5
	Mld+So2vS2YFUFsIqSPX4lqIdCnVGAHipNq87Gv5iSDfd31AlAPJdkbv3V9j1NzxAs/
	v3Ah/PWXKArddNiCcWTJOZwJyPOXqKkF5V6jbshE=
Received: by mx.zohomail.com with SMTPS id 1778674495350171.1089952125758;
	Wed, 13 May 2026 05:14:55 -0700 (PDT)
Date: Wed, 13 May 2026 12:14:49 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/18] mshv: Fix level-triggered check on
 uninitialized data
Message-ID: <20260513-omniscient-enchanted-otter-dfd602@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816862362.21765.11809618639989414561.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177816862362.21765.11809618639989414561.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: A66BF532E93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10832-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudhrb.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:43:43PM +0000, Stanislav Kinsburskii wrote:
> In mshv_irqfd_assign(), the level-triggered validation for resample
> irqfds checks irqfd_lapic_irq.lapic_control.level_triggered before
> mshv_irqfd_update() has populated the field. Since the irqfd struct is
> zero-allocated, level_triggered is always 0 at that point, causing the
> check to always reject resample irqfds with -EINVAL. This makes
> level-triggered interrupt resampling — used to avoid interrupt storms
> with assigned devices — completely non-functional.

What bugs would this manifest as? Why haven't we seen any such bugs so
far?

Thanks,
Anirudh.

