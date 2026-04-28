Return-Path: <linux-hyperv+bounces-10453-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC3NJ2dE8WmxfQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10453-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:36:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71248D433
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 343103001D78
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CA639DBE8;
	Tue, 28 Apr 2026 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="itfDduy+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0114A4F0;
	Tue, 28 Apr 2026 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418909; cv=none; b=ZUHUW2AmO0CnB15CWO47TQIuapHqxAZfYFds9e+L5Ed76DhbF77o/QKwFu143YNn8hkKhlCouelbkTyP6PwQ8fJLjEQqHZcGLzYZdrPtD1Kav29YNYW3bfCMzX1AzrI7u6BZK/9HvdulQMK2nbQnv6JCju4hEp6XuFVnogAd7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418909; c=relaxed/simple;
	bh=7PLMpsYyH2G9ayi4bZrO8oMZmYgVLiuqewZ9TXY0H84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeDSMthHtqtLJWRMeoP02JCNIYxERAnWctVkMrVLEVaqDFeIhqzqA8H0F2AIx3/q+hyVZgfqneZHuK90LpcR8NOZrJX/vxMQKfgNZzY1Wo4j+j4Wh5ms+zkKG6N86QO6kPizuq1ZTLJBLs9SpS0er9a91BzUUYbjJbDihrekBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=itfDduy+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 135C320B716F;
	Tue, 28 Apr 2026 16:28:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 135C320B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777418908;
	bh=8Li2V8V7QxN30Y7Y7+L1qUmWTDNPZ5YHsj5L+dhyldg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itfDduy+hYQbMgttqIqztMVkyn3ncrBUWLFrH7+Q/yuHQ/oaJKK29o1wH+92PyXvd
	 1A56GVxcMVuDFwK8OH90BajUk5CWD50LgQiM6U9W7HsR0UCwRhJaweioaKtoDvR8Ku
	 Mwt2eMCiVUDroLtPXYQveyK4UYHajeFR4Me1GN0A=
Date: Tue, 28 Apr 2026 16:28:25 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mshv: clean up SynIC state on kexec for L1VH
Message-ID: <afFCmRoAIi5ZdlcI@skinsburskii.localdomain>
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
X-Rspamd-Queue-Id: 3A71248D433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10453-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,anirudhrb.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii.localdomain:mid]

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


Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

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

