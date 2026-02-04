Return-Path: <linux-hyperv+bounces-8699-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBmLBefmgmlTegMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8699-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:27:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C486E250E
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98CA030558E0
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B78137FF6B;
	Wed,  4 Feb 2026 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL/F1wmo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED737F728;
	Wed,  4 Feb 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186438; cv=none; b=H2PSuesPWGCCvVeZk86wNw89DUyiM+U+RsD/cYQ5kIGBFCLeVfEn0lKdR1lo9tIvD7hbSK+pPt3EPjGwLr5Jbza0gr+KLfgOgOZVekvcUrilbXHEP4l3lRkJJ9HI3wP/CzyrLeeN+KviAEEHtQuJCxJW+NenlMYlgC9kKVYRP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186438; c=relaxed/simple;
	bh=xCkS4j0GXL9c2hQP9ewY0YJM8DPO+HX2PTYYeJfILsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLDzMiYDLp10u8OOrvCYBPZS7eu5KmjE8uOkAQ0PqBDkrOBKTNVq/nr/IUpl79G1h9T2iqUFGIP+ny0KQgRUjpgWRy4snPAGlxCIxc0wmWTqoWyMBBSuLGfaP2xr97gQevZmV0pziCxlcqB+s6GcDE1Dbtz9rL2D3LGUrWt2ATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL/F1wmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB20C4CEF7;
	Wed,  4 Feb 2026 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770186437;
	bh=xCkS4j0GXL9c2hQP9ewY0YJM8DPO+HX2PTYYeJfILsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL/F1wmoJdf3xZ02ZS7scrDX3/Hj2UtIL0YEd14encH+RTDbTMnKzzFuOnPFvfevL
	 ZyHsH3CM9DRZDFCAhAWqP1ywMx75xw/kL3Vqn4iw3y5wRGJyvr/W7MQvmQp6hxPQtb
	 zu2QTMd4OOV9C1O+U87UUfggr6/unV57g/wr8Il3In1NfIoMiELInOwmbfkkSK47WC
	 KFZ9ly9AnNS9RYBjmqallyIsNlFPzXGo2ga0B5wqPSM1D8NOhxt/qEFoBeidvvyiFK
	 BYjDYUWoYV739iicpzTHBuSs2RjhIVxi4Kak7+Ub1oBVdZd4pNlUZH3jNjY2mrWUY6
	 tOlfz7/pDizgA==
Date: Wed, 4 Feb 2026 06:27:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org
Subject: Re: [PATCH v1] x86/hyperv: Move hv crash init after hypercall pg
 setup
Message-ID: <20260204062716.GH79272@liuwe-devbox-debian-v2.local>
References: <20260204015800.40843-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204015800.40843-1-mrathor@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8699-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 9C486E250E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 05:58:00PM -0800, Mukesh R wrote:
> hv_root_crash_init() is not setting up the hypervisor crash collection
> for baremetal cases because when it's called, hypervisor page is not
> setup.

> This got missed due to internal mirror falling behind.

This doesn't provide useful information for our future selves.

> 
> Fix is simple, just move the crash init call after the hypercall
> page setup.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

Applied.

Wei

> ---
>  arch/x86/hyperv/hv_init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 14de43f4bc6c..7f3301bd081e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -558,7 +558,6 @@ void __init hyperv_init(void)
>  		memunmap(src);
>  
>  		hv_remap_tsc_clocksource();
> -		hv_root_crash_init();
>  		hv_sleep_notifiers_register();
>  	} else {
>  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> @@ -567,6 +566,9 @@ void __init hyperv_init(void)
>  
>  	hv_set_hypercall_pg(hv_hypercall_pg);
>  
> +	if (hv_root_partition())        /* after set hypercall pg */
> +		hv_root_crash_init();
> +
>  skip_hypercall_pg_init:
>  	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
> -- 
> 2.51.2.vfs.0.1
> 

