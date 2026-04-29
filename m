Return-Path: <linux-hyperv+bounces-10467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK21OjvX8Wm3kgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10467-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:02:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EA492867
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 12:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6323F3080C9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780C39B962;
	Wed, 29 Apr 2026 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="FFJ9vHnj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F793B5304;
	Wed, 29 Apr 2026 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456749; cv=pass; b=A24k//BVk7MkBOI96xrNUXM7UxAn9Ag6SSFjP/915XJU5ACHmM5pWWkPTn8Zf+Xvj8k0u6/OyIZv0UG6Q1c6wj/3zezzJCZ39EPEW7XGdgWyCQfc3BJidww15GIFw/FDGxPrzCBxCiN7kc8Je1+cDwPYPbUwZQkSERDaUvnSyok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456749; c=relaxed/simple;
	bh=lXLV5RuuztwQv/9vqhAXh6mReJtqqSvMU9NvBQzL0GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSJPSHLkm0k8DpTvmxTCsCTVDERetfLeTzLcQ7Xbj2gju7mPSUPFiWToUmyu2RmkY3srtYKvjg5LTkFkf0iDDaacboLcyBxnCBlSd2nCWbRLIbDI+LshNmmF4oJVF22JZeO69vM96QGI0Cl7EpuJre66ji4PSJNRALyN09c80H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=FFJ9vHnj; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777456727; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cIWt9xAWrdzMNTWwRVXgoerdmeoZ6Sr/lFB2AQ3BMxuiuBRTeo3JLkrSBXLwKJh+wesn99cjBj6Mz3fK26GfPbcBhv8vECqIqsuR4tlMtToC/rIcCevK3jBYb97iYUYUgE1QZBFka/nBMcYUdmDevZYLJc8QKZbvhN6ntpHAZMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777456727; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iX7P9wk0N+hjbsv3e1etMxA/H/6GGHLzR7d21GExkjo=; 
	b=FwZ/PVvAo4gQtPR4hurim+a0a+6EDy+hmxk0xPHUnnBOeQNtsaoqqWd0nkizHmmpYcqe/nsvxfMXfTKFjjYgiC8R78UyWwPNfFPHFXcMJIaGQjy+rU5SQIymJwXdtt9Vtv8FHMHGYh8bq5pJXHkEq7tCWV2gM+QQnVpndVv8ocU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777456727;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=iX7P9wk0N+hjbsv3e1etMxA/H/6GGHLzR7d21GExkjo=;
	b=FFJ9vHnjS/NYmpO7eHyYut8zB3EZKq2fhkWVPd0EvPV5+jG2vxg48sM2LeI7YIGZ
	WvgQua0Mc3KPd4lpl2E4CkImG5tAKYLPfVZ9Ibwu5+TB4F7d7InCppT5gClYxayEpWr
	+CWuewxR0lhM5LCXLbQLbYq4jVZXZprFqmL6ylTU=
Received: by mx.zohomail.com with SMTPS id 177745672421517.47327517723204;
	Wed, 29 Apr 2026 02:58:44 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:58:38 +0000
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
Subject: Re: [PATCH v4 2/3] mshv: clean up SynIC state on kexec for L1VH
Message-ID: <20260429-whispering-vegan-emu-caff87@anirudhrb>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
 <20260427213855.1675044-3-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213855.1675044-3-jloeser@linux.microsoft.com>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 906EA492867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10467-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 02:38:53PM -0700, Jork Loeser wrote:
> The reboot notifier that tears down the SynIC cpuhp state guards the
> cleanup with hv_root_partition(), so on L1VH (where
> hv_root_partition() is false) SINT0, SINT5, and SIRBP are never
> cleaned up before kexec. The kexec'd kernel then inherits stale
> unmasked SINTs and an enabled SIRBP pointing to freed memory.
> 
> Remove the hv_root_partition() guard so the cleanup runs for all
> parent partitions.
> 
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  drivers/hv/mshv_synic.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index 2db3b0192eac..978a1cace341 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -723,9 +723,6 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
>  static int mshv_synic_reboot_notify(struct notifier_block *nb,
>  			      unsigned long code, void *unused)
>  {
> -	if (!hv_root_partition())
> -		return 0;
> -
>  	cpuhp_remove_state(synic_cpuhp_online);
>  	return 0;
>  }
> -- 
> 2.43.0
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


