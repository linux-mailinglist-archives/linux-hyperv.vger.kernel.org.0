Return-Path: <linux-hyperv+bounces-10466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBu1AEnX8Wm3kgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10466-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:02:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FAC49286F
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F52330B187C
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8F3C3BF7;
	Wed, 29 Apr 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="JHxJCO1Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52233B97A;
	Wed, 29 Apr 2026 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456720; cv=pass; b=tE45KAtOouU5jV6zg71L5ALzewoa4iuKTMxnoq3JgAXsMg4cWSoUStrNymMMOcG7J9D40KQtVl5hl7aQE83YszGiqXo6jGPeSeme7c4arokzG2xHH7QBOPCXmt+2FN3xpaWYTkB0VjXfKvcnQbX+Q5hwPLu8/q43YcJhkLI0k5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456720; c=relaxed/simple;
	bh=6QU1C61dVfFVlOPKFdiGl4t3RT9nxVFUC3MlV3nJTps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKcqg+gdU/nkHJPkIkdfz5ydcGKJwtaeIVvx69ooQt0p47OUQHEqeF2sjIFeGy6jbsi/KstbdVEhqTuK7hkya5ZjSe770VM2gZWsaddp6KFYHj8fNspSWQiPGvTGOVPS322IcowBhrzMLQpfIOkp2GmLKksUo6GsqEV8oBUxn3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=JHxJCO1Q; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777456693; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k8eYySm5rte5dOpghLzWz7U2Cl0+B/3NNCvUDDg8surn6nlwomre0RJ8HZI8qmpuCds8a4KEx8dW/YSIdm4Ovn9XAIAmAzGYYN34FWV3piTYrMfgkGK3/9wNKn+h+UFPliin6Ho88HtiusprHSB0dM3XRiRH/lqIv6KqoXv+gjo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777456693; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ob/2PX7t4Nbz9UfHxyrsNw7aDi/Gmqo70zNjo5z65VY=; 
	b=eNV+oqoNGUJMlm/71QrXgXyin31sJoJb8eJoFlWQhRhKIRc7ZJkFCcK8D89lLtkyY+x/318H0z/fLroK8/jITlXfj5eQeZv2SQx0ZKSMz9AYVqTYji3ZX4Ipm0nbO9a+micyq5A533RGdAwHrwIBnmJtO0H56sA4yjDkRKxIqSE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777456693;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ob/2PX7t4Nbz9UfHxyrsNw7aDi/Gmqo70zNjo5z65VY=;
	b=JHxJCO1QCxxNQfBAipXdLv5mP6i+ZhXRswJLf+D/AOidiw18DLlgrOzpJLVnRDsL
	/2/Bg/Te69enWe42APU9+9mx0MyPmPfc0XMrkK6BOOYtqht7W89kdeQJvq9XxIrPOA5
	sDigO1ZRAtnDOwoMart1PPlEKc8d9ZaNEZp60woA=
Received: by mx.zohomail.com with SMTPS id 1777456690248423.87477393075324;
	Wed, 29 Apr 2026 02:58:10 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:58:04 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mshv: limit SynIC management to MSHV-owned
 resources
Message-ID: <20260429-dancing-augmented-chicken-8711a6@anirudhrb>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
 <20260427213855.1675044-2-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213855.1675044-2-jloeser@linux.microsoft.com>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 66FAC49286F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10466-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:dkim,anirudhrb.com:email]

On Mon, Apr 27, 2026 at 02:38:52PM -0700, Jork Loeser wrote:
> The SynIC is shared between VMBus and MSHV. VMBus owns the message
> page (SIMP), event flags page (SIEFP), global enable (SCONTROL),
> and SINT2. MSHV adds SINT0, SINT5, and the event ring page (SIRBP).
> 
> Currently mshv_synic_cpu_init() redundantly enables SIMP, SIEFP, and
> SCONTROL that VMBus already configured, and mshv_synic_cpu_exit()
> disables all of them. This is wrong because MSHV can be torn down
> while VMBus is still active. In particular, a kexec reboot notifier
> tears down MSHV first. Disabling SCONTROL, SIMP, and SIEFP out
> from under VMBus causes its later cleanup to write SynIC MSRs while
> SynIC is disabled, which the hypervisor does not tolerate.
> 
> Restrict MSHV to managing only the resources it owns:
> - SINT0, SINT5: mask on cleanup, unmask on init
> - SIRBP: enable/disable as before
> - SIMP, SIEFP, SCONTROL: leave to VMBus when it is active (L1VH
>   and nested root partition); on a non-nested root partition VMBus
>   does not run, so MSHV must enable/disable them
> 
> While here, fix the SIEFP and SIRBP memremap() and virt_to_phys()
> calls to use HV_HYP_PAGE_SHIFT/HV_HYP_PAGE_SIZE instead of
> PAGE_SHIFT/PAGE_SIZE. The hypervisor always uses 4K pages for SynIC
> register GPAs regardless of the kernel page size, so using PAGE_SHIFT
> produces wrong addresses on ARM64 with 64K pages.
> 
> Note that initialization order matters - VMBUS first, MSHV second,
> and the reverse on de-init. Ideally, we would want a dedicated SYNIC
> driver that replaces the cross-dependencies with a clear API and
> dynamic tracking. Such refactor should go into its own dedicated
> series, outside of this kexec fix series.
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/hv.c         |   3 +
>  drivers/hv/mshv_synic.c | 150 ++++++++++++++++++++++++++--------------
>  2 files changed, 103 insertions(+), 50 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


