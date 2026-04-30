Return-Path: <linux-hyperv+bounces-10511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rUWhFQu88mlbtwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10511-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 04:18:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDBF49C416
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 04:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ADA83017048
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 02:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B742367D3;
	Thu, 30 Apr 2026 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q2N1Ojr8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390A61FCE;
	Thu, 30 Apr 2026 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515527; cv=none; b=sRSkbVK+qviFx9vJfy4bKr0/mM27jjvNAFJCbNA2vAhzsMhA5VGNwksyY5TSrxkZybG04RZLOjsUv8JpTm20VQMafsrY/8ZxSM6z0lXFmUopjyB/Az4MeVEnk7Mi6iRYyVPTgn3Y142yJD+78/p1rO6C63I/J3IkcDART2QLvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515527; c=relaxed/simple;
	bh=nAMZwVbif3h/7h5hV18M1L1+jChh3dtxQFd6oKzy1lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGG3SjkkxN3RJHGJrJuU54qRgR7ODyxpht2/ESWAF/dqy2riq6TT7Favh2NI38nwRqR6HiT0A+4hschhmfiGxV/BG1zz82Cv9yUikBjjwMCYBA8s6rXysFGBcNS9usL4xZ0R7OwDn3OJ02cdvGfn9o2rPJO1Nb3BUYRXOSV2JYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q2N1Ojr8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id D609A20B716C;
	Wed, 29 Apr 2026 19:18:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D609A20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777515526;
	bh=SKVLTMM1mY5cQsC2H1+CAVNUsmUbom6WytRbvQGa3zw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q2N1Ojr8O5DGDA2mNu11kxoKOBTzVdUzBo0EUlk/p5TPU3+rUGdU6VwyvpXzQ33sq
	 C9Hl2joJoEMCAloL2HNCn/W9gsikVdNftqhXSRggTXU87uYydOz+sUYXnZjIbn+Ifw
	 ea/XBPLdQJ5TOQeeFMaUe6mYZXHgocgsCgFfVQxQ=
Message-ID: <daacfbcc-e725-65f2-4b20-b4501e45e651@linux.microsoft.com>
Date: Wed, 29 Apr 2026 19:18:44 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/10] mshv: Bug fixes across the mshv_root module
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BFDBF49C416
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10511-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]

On 4/29/26 11:17, Stanislav Kinsburskii wrote:
>   This series addresses bugs found during a review of the mshv_root module
>   introduced by commit 621191d709b14 ("Drivers: hv: Introduce mshv_root
>   module to expose /dev/mshv to VMMs").
> 
>   The fixes range from data corruption and use-after-free to silent
>   functional failures:
> 
>    - IRQ state leak and type truncation in hypercall helpers
>      (hv_call_modify_spa_host_access)
>    - Integer overflow on userspace-controlled allocation size
>      (mshv_region_create)
>    - Missing locking, broken seqcount read protection, and a check on
>      uninitialized data in the irqfd path ? the latter makes
>      level-triggered interrupt resampling completely non-functional
>    - Duplicate GSI 0 detection using the wrong predicate
>    - Use-after-RCU in port ID lookup
>    - Missing VP index bounds check in intercept ISR (OOB in interrupt
>      context)
>    - Missing error code on VP allocation failure (silent success to
>      userspace)

Lot of changes here, curious, how were all these discovered
suddenly? Stress testing, internal/external?  Or reported by
copilot/sashiko/etc..

How were the fixes tested?

Thanks,
-Mukesh


> ---
> 
> Stanislav Kinsburskii (10):
>        mshv: Fix IRQ leak and type hazards in hv_call_modify_spa_host_access
>        mshv: Fix potential integer overflow in mshv_region_create
>        mshv: Fix missing lock in mshv_irqfd_deassign
>        mshv: Fix broken seqcount read protection
>        mshv: Fix level-triggered check on uninitialized data
>        mshv: Fix duplicate GSI detection for GSI 0
>        mshv: Fix use-after-RCU in mshv_portid_lookup
>        mshv: Use kfree_rcu in mshv_portid_free
>        mshv: Add missing vp_index bounds check in intercept ISR
>        mshv: Fix missing error code on VP allocation failure
> 
> 
>   drivers/hv/mshv_eventfd.c      |   75 ++++++++++++++++++++++------------------
>   drivers/hv/mshv_irq.c          |    2 +
>   drivers/hv/mshv_portid_table.c |    6 +--
>   drivers/hv/mshv_regions.c      |    2 +
>   drivers/hv/mshv_root_hv_call.c |   18 +++-------
>   drivers/hv/mshv_root_main.c    |    4 ++
>   drivers/hv/mshv_synic.c        |    4 ++
>   7 files changed, 59 insertions(+), 52 deletions(-)
> 


