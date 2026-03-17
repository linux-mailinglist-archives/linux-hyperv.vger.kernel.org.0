Return-Path: <linux-hyperv+bounces-9478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jEkbOMzLuGksjgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9478-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:34:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1832A33D4
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9013012255
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 03:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF72DB790;
	Tue, 17 Mar 2026 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ov74Wu4/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AF2C178D;
	Tue, 17 Mar 2026 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718474; cv=none; b=iCGomPg+DpkU0k13Pq42cioSUHMTMSdRuZu8EsWub6HdwOLtMGSefOCjKSWS2g52fWQWW4q9SMREYy/fLzCJp1s99maYqxhO1DV5/5ePJ2O9pdlVlM48Qx9jNeo2WwhsQobnBnI6Ao+Cx0aHThJTxVjurLvAzUWcViRxEbhF2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718474; c=relaxed/simple;
	bh=1cVrf0cVdvSC9kSjToaHiAHCCNH9jRcfwzG8dHsgb0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uGzrCF5RD61bZG11SNUP/LR7EfDgW9jXHoCnUdMe2hPME5jV93KDmZOFZYcNM/BvzfAEq3JdPWHNtp/bvQ/8DJhCK7kTgCm4UidoHiwe20HVh83/PQhUunTdJxBNVivKCCrylVy/5paBDe/fl2RejcMu1eL+6KKIxZ8zb51xNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ov74Wu4/; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fZcyQ4BJtz9tnK;
	Tue, 17 Mar 2026 04:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1773718462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvk8oVjzmRANMbF/sHn+D9/IRAR8TIyr9Hly+56noQ8=;
	b=Ov74Wu4/8R4LezoE7zlwKi8qjigSeDb2mUjjW4IzGDcOg3igVrO94EY8x+xJVHaNbiUL+K
	vdiznsbLL/wYRpgQN+VZXeR1kliYPzxeSnN516L5NQMH88N/3Zka0JMyXZdsM6h7+3CfD2
	wbMsmsF0tETBwabnEbDBLD6zjb/oG03MDrYsBHMWuFCTYRvQwJOYOJtUV9R2DMEEmffDUZ
	6dHUBC8gCHoZyVihM6gFGdtHbZWlj8arWi9gbRQybzthKLg+onwUSYqwEYqsdiU1pgIlcv
	DVw+5+eTOj8dM9yJ6Z1/LGK8XBkTWti7peiN+PskUQczMIc/EyqRuvDX/Zx96g==
Date: Mon, 16 Mar 2026 19:34:17 -0800 (PST)
From: vdso@mailbox.org
To: Naman Jain <namjain@linux.microsoft.com>, ssengar@linux.microsoft.com
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <1755043210.33472.1773718457301@app.mailbox.org>
In-Reply-To: <20260316121241.910764-1-namjain@linux.microsoft.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
Subject: Re: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 6dc41640b0ac1e9fe30
X-MBO-RS-META: wrn3tzu87eqwbcxxwe6mtaf6tg1g6t31
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9478-lists,linux-hyperv=lfdr.de];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,outlook.com,vger.kernel.org,lists.infradead.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdso@mailbox.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.mailbox.org:mid,mailbox.org:dkim,mailbox.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D1832A33D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> On 03/16/2026 5:12 AM  Naman Jain <namjain@linux.microsoft.com> wrote:
> 
>  
> The series intends to add support for ARM64 to mshv_vtl driver.
> For this, common Hyper-V code is refactored, necessary support is added,
> mshv_vtl_main.c is refactored and then finally support is added in
> Kconfig.

Hi Naman, Saurabh,

So awesome to see the ARM64 support for the VSM being upstreamed!!

Few of the patches carry my old Microsoft "Signed-off-by" tag,
and I really appreciate you folks very much kindly adding it
although the code appears to be a far more evolved and crisper
version of what it was back then!

Do feel free to drop my SOB from these few patches so the below SRB
doesn't look weird or as a conflict of interest - that is if you see
adding my below SRB to these few patches as a good option. It's been
2 years, and after 2 years who can really remember their code :D

For the series,
Reviewed-by: Roman Kisel <vdso@mailbox.org>

> 
> Based on commit 1f318b96cc84 ("Linux 7.0-rc3")
> 
> Naman Jain (11):
>   arch: arm64: Export arch_smp_send_reschedule for mshv_vtl module
>   Drivers: hv: Move hv_vp_assist_page to common files
>   Drivers: hv: Add support to setup percpu vmbus handler
>   Drivers: hv: Refactor mshv_vtl for ARM64 support to be added
>   drivers: hv: Export vmbus_interrupt for mshv_vtl module
>   Drivers: hv: Make sint vector architecture neutral in MSHV_VTL
>   arch: arm64: Add support for mshv_vtl_return_call
>   Drivers: hv: mshv_vtl: Move register page config to arch-specific
>     files
>   Drivers: hv: mshv_vtl: Let userspace do VSM configuration
>   Drivers: hv: Add support for arm64 in MSHV_VTL
>   Drivers: hv: Kconfig: Add ARM64 support for MSHV_VTL
> 
>  arch/arm64/hyperv/Makefile        |   1 +
>  arch/arm64/hyperv/hv_vtl.c        | 152 ++++++++++++++++++++++
>  arch/arm64/hyperv/mshyperv.c      |  13 ++
>  arch/arm64/include/asm/mshyperv.h |  28 ++++
>  arch/arm64/kernel/smp.c           |   1 +
>  arch/x86/hyperv/hv_init.c         |  88 +------------
>  arch/x86/hyperv/hv_vtl.c          | 130 +++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   8 +-
>  drivers/hv/Kconfig                |   2 +-
>  drivers/hv/hv_common.c            |  99 +++++++++++++++
>  drivers/hv/mshv.h                 |   8 --
>  drivers/hv/mshv_vtl_main.c        | 205 ++++--------------------------
>  drivers/hv/vmbus_drv.c            |   8 +-
>  include/asm-generic/mshyperv.h    |  49 +++++++
>  include/hyperv/hvgdk_mini.h       |   2 +
>  15 files changed, 505 insertions(+), 289 deletions(-)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
> 
> 
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> prerequisite-patch-id: 24022ec1fb63bc20de8114eedf03c81bb1086e0e
> prerequisite-patch-id: 801f2588d5c6db4ceb9a6705a09e4649fab411b1
> prerequisite-patch-id: 581c834aa268f0c54120c6efbc1393fbd9893f49
> prerequisite-patch-id: b0b153807bab40860502c52e4a59297258ade0db
> prerequisite-patch-id: 2bff6accea80e7976c58d80d847cd33f260a3cb9
> prerequisite-patch-id: 296ffbc4f119a5b249bc9c840f84129f5c151139
> prerequisite-patch-id: 3b54d121145e743ac5184518df33a1812280ec96
> prerequisite-patch-id: 06fc5b37b23ee3f91a2c8c9b9c126fde290834f2
> prerequisite-patch-id: 6e8afed988309b03485f5538815ea29c8fa5b0a9
> prerequisite-patch-id: 4f1fb1b7e9cfa8a3b1c02fafecdbb432b74ee367
> prerequisite-patch-id: 49944347e0b2d93e72911a153979c567ebb7e66b
> prerequisite-patch-id: 6dec75498eeae6365d15ac12b5d0a3bd32e9f91c
> -- 
> 2.43.0

