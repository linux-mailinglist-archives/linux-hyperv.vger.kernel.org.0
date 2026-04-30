Return-Path: <linux-hyperv+bounces-10523-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB49I/Fp82k72gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10523-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 16:40:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402A4A428A
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D49F9302B50E
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C142EEC4;
	Thu, 30 Apr 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y5fkod/4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4114279F8;
	Thu, 30 Apr 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560042; cv=none; b=cHm3QH0880s8dRJ+LVO/va4f4u+HT237rtFv5IeEXKEFK7v1u7Y9/VXVqjsm8RIWKd8I6JHpmH/iYALkuwRsUAeUxN/ByqgIap/PBxT8kpB9v5eGS6w92dO64xl9dqMVsUyf8Sso5vZC3dINHnh9ZcSCSEAITrTVAMBn697cPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560042; c=relaxed/simple;
	bh=5pH3lFk0rTqwVfeooNlsoSRKtOg2p41F6MWVjWoPFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMQtu9ODPmGEQV3q6HiOHac8ZqP+iy8VWFWS+8Z6IS93JB7bgIDAIdjo6RJdU1dnH0lbNpmCVgWpIfaQ2mhw+OfhEflKEUMkT+Wjd3pXFDUrejclQCM3uEtYxeheVcyDWk95hFg+GHTO7H5bYZr/VWl8m2nqqHRvmplfjQi2Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y5fkod/4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0313B20B7175;
	Thu, 30 Apr 2026 07:40:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0313B20B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777560039;
	bh=cJ2VaDCLS+qTSMNAiyM9hFCuwxgUnxovgz/7Eii6Pnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5fkod/4TK1V1ANBx5UHH/BsZQ9iGVOBqKL1NfwynQFcRKYRHXclj8XTO8vStDUfM
	 aq13PDoEp8DKXkhPyeo0FPtW7qaZt+oUpjqtERVrTb0vGSWpJTFjxbeBX3GBeHmpU0
	 EUV2H8Gb7f8KqWmPO7XUe9hwMzmNp6EOukbVl6Ek=
Date: Thu, 30 Apr 2026 07:40:37 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] mshv: Bug fixes across the mshv_root module
Message-ID: <afNp5eO_XlDAxchJ@skinsburskii.localdomain>
References: <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <daacfbcc-e725-65f2-4b20-b4501e45e651@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daacfbcc-e725-65f2-4b20-b4501e45e651@linux.microsoft.com>
X-Rspamd-Queue-Id: 0402A4A428A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10523-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]

On Wed, Apr 29, 2026 at 07:18:44PM -0700, Mukesh R wrote:
> On 4/29/26 11:17, Stanislav Kinsburskii wrote:
> >   This series addresses bugs found during a review of the mshv_root module
> >   introduced by commit 621191d709b14 ("Drivers: hv: Introduce mshv_root
> >   module to expose /dev/mshv to VMMs").
> > 
> >   The fixes range from data corruption and use-after-free to silent
> >   functional failures:
> > 
> >    - IRQ state leak and type truncation in hypercall helpers
> >      (hv_call_modify_spa_host_access)
> >    - Integer overflow on userspace-controlled allocation size
> >      (mshv_region_create)
> >    - Missing locking, broken seqcount read protection, and a check on
> >      uninitialized data in the irqfd path ? the latter makes
> >      level-triggered interrupt resampling completely non-functional
> >    - Duplicate GSI 0 detection using the wrong predicate
> >    - Use-after-RCU in port ID lookup
> >    - Missing VP index bounds check in intercept ISR (OOB in interrupt
> >      context)
> >    - Missing error code on VP allocation failure (silent success to
> >      userspace)
> 
> Lot of changes here, curious, how were all these discovered
> suddenly? Stress testing, internal/external?  Or reported by
> copilot/sashiko/etc..
> 

These are suggested by Claude Opus 4.6.

> How were the fixes tested?
> 

I ran cloud hypervisor intergration tests suite against these changes,
which covers a wide range of scenarios including interrupt handling,
memory management, and VP lifecycle.

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> 
> > ---
> > 
> > Stanislav Kinsburskii (10):
> >        mshv: Fix IRQ leak and type hazards in hv_call_modify_spa_host_access
> >        mshv: Fix potential integer overflow in mshv_region_create
> >        mshv: Fix missing lock in mshv_irqfd_deassign
> >        mshv: Fix broken seqcount read protection
> >        mshv: Fix level-triggered check on uninitialized data
> >        mshv: Fix duplicate GSI detection for GSI 0
> >        mshv: Fix use-after-RCU in mshv_portid_lookup
> >        mshv: Use kfree_rcu in mshv_portid_free
> >        mshv: Add missing vp_index bounds check in intercept ISR
> >        mshv: Fix missing error code on VP allocation failure
> > 
> > 
> >   drivers/hv/mshv_eventfd.c      |   75 ++++++++++++++++++++++------------------
> >   drivers/hv/mshv_irq.c          |    2 +
> >   drivers/hv/mshv_portid_table.c |    6 +--
> >   drivers/hv/mshv_regions.c      |    2 +
> >   drivers/hv/mshv_root_hv_call.c |   18 +++-------
> >   drivers/hv/mshv_root_main.c    |    4 ++
> >   drivers/hv/mshv_synic.c        |    4 ++
> >   7 files changed, 59 insertions(+), 52 deletions(-)
> > 
> 

