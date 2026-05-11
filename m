Return-Path: <linux-hyperv+bounces-10735-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPUWNSZOAWr7UQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10735-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 05:33:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B85507A41
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 05:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8660F30010F3
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5F25F7A9;
	Mon, 11 May 2026 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="v4qPiblD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E69239E76;
	Mon, 11 May 2026 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470436; cv=pass; b=lBtiRNEARffKMgabBd4uSB6y9BkwWpGWHKAQ0wgdRQprZsuf9EySqTLLfNiKCLZzbCWb7vA3GqPmji7wsisdaTSQquURGAJe9GfoPwiBxnVIawe/OsVZTKfqYECevVMqJ+TeUEX5nf9PEsdcuAKw5v4hwYKMWHi7PXC8v7bGOFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470436; c=relaxed/simple;
	bh=pOrIIaQIqAEbXzWwUZFwIaR96TCOxGlWl+hYcw5R8e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBf5T056H1FRhNbSnuzdia3zH47DwvWyio644StZZvFT6klflMUL2x0IvmGxyFBNHC/gkm+RPgerX502dTZ2VHLlYNuhobVVkNGqf/C2OoNyLqVzSGcKDWoI3PgxTlcDsdyB1t8J18hrI78hRJ+hij0yn7OX6qJo5iwMSEpF7Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=v4qPiblD; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778470428; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lGUo9G5Zouq0q7232WljHbupBUBMeSWwguy7mmRe2k2COJwikw7r1p1GTPKECKp9GihobTnjFY1fMTDPCRNgD6VmOfcOO/gj6RfitKSRqu+L51d1nyJHpLYI7ilLTkfL0wKCGdaJVQDWb5ufGLqrlXn+h2W7v931AT297/Ww3Lk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778470428; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=foT3qoVjL35tZploGNl31zoHW2T8OWE1fVVTxuQEehs=; 
	b=luj3qfbsWKbvCWthBZ4e76Erx+cMprP9Fdl0cocd48E3wU/viQx67EoKexv+NhEPnlHQh/XsIQv4f1/uJf3q+8pxP79bYu/9EPFgBmh0Tpu3iIi41F6PcwTXMjjZL9fPVgXQ93o0O6qBa/pNWqKZas6y2bU2L12QlX+7z+6BmsA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778470427;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=foT3qoVjL35tZploGNl31zoHW2T8OWE1fVVTxuQEehs=;
	b=v4qPiblDpxkL/VyM6bJfAp9/MudabkM6Y0NFymiEwWDRG12lm2G4lqYq6UyL6gVt
	YvnWP36h/us3/ZO8A313fXF5jU9MIdQ3MClB1hGfz6qwaI3l6BXZyQU7XvNFpTxX7cz
	qbj4qSVZP5nqXru37diUkcsCMP6eEKsqI0CH3Brk=
Received: by mx.zohomail.com with SMTPS id 1778470425002141.54349464031418;
	Sun, 10 May 2026 20:33:45 -0700 (PDT)
Date: Mon, 11 May 2026 03:33:38 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/18] mshv: Fix sleeping under spinlock in
 mshv_portid_alloc
Message-ID: <20260511-giga-chipmunk-of-success-0cfae9@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816863995.21765.3588432375739789368.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816863995.21765.3588432375739789368.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 69B85507A41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10735-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:43:59PM +0000, Stanislav Kinsburskii wrote:
> idr_alloc() is called with GFP_KERNEL inside idr_lock(), which holds a
> spinlock. GFP_KERNEL allows the allocator to sleep, triggering a
> sleeping-while-atomic bug.
> 
> Fix by using idr_preload(GFP_KERNEL) before taking the lock to
> pre-allocate memory in a sleepable context, then idr_alloc() with
> GFP_NOWAIT inside the spinlock-protected section.
> 
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_portid_table.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
> index 4cdf8e9575390..d87a82e399e96 100644
> --- a/drivers/hv/mshv_portid_table.c
> +++ b/drivers/hv/mshv_portid_table.c
> @@ -40,12 +40,14 @@ mshv_port_table_fini(void)
>  int
>  mshv_portid_alloc(struct port_table_info *info)
>  {
> -	int ret = 0;
> +	int ret;
>  
> +	idr_preload(GFP_KERNEL);
>  	idr_lock(&port_table_idr);
>  	ret = idr_alloc(&port_table_idr, info, PORTID_MIN,
> -			PORTID_MAX, GFP_KERNEL);
> +			PORTID_MAX, GFP_NOWAIT);
>  	idr_unlock(&port_table_idr);
> +	idr_preload_end();
>  
>  	return ret;
>  }
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


