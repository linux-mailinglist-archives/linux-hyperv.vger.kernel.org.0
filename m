Return-Path: <linux-hyperv+bounces-8733-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKtECF7ZhGlo5gMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8733-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 18:54:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA81F63A4
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBAD13009002
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4873016FC;
	Thu,  5 Feb 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="t3JYQ6wo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5D2F99BD;
	Thu,  5 Feb 2026 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314056; cv=pass; b=bPj6QiexyQbKXXtskU0PPISF/ynXuw7akWy4g6/4KSvxytvQBkcAM5zmSdBo0Jr+Ugsr50Qp3dGC2YQzecWCf3wC2ZTc8Cfsio/xLdlKiqgs4H5VTrim3Mqf+FuG0EuthLJ6aCL7L23FbUztD+K0XiI5jVEb4xsFEvRiVXiD0y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314056; c=relaxed/simple;
	bh=UuY/TJ9/k+aHwCtbwTT1//QThhg4FmJb7RyHdm7WnLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUyby3aVMJWCliy1Mo/fAboTzhaluPagBknpQvgkmMh1miHG+pN5XNmcPEWS9DsrCYNkI6nTt0Jo5DtGRyaF1XJh3vGirUvCqYl+o0GcMQVKsE2WxhtIhiWCvPgOSkWRsIHCF9+rxN3mM+qeoknlAbYrvz2Knl/2DqO09NeAgr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=t3JYQ6wo; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770314046; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MGjLuptchQ+dc4PnAnckvhfuvirPlgPJUFHvRgnJ1uTTqIdjOZd9rbtDU26s70U3u9/8y+CQvViijjqRDXxUTZKeIiNYFn33CRDkM5DnNbfcH8KdnhMS49uXcQ5cWw+P54Zb27ilR7oBuhjdbSGlj8vnhj8Bp2oeXQ9bGwJ5eF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770314046; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a1cCBSLCxzsDLYHEus9AOY/on8OIUfKi78kSXYkA7pY=; 
	b=YuerCgeH8rIJmUu/vMTCY/Gnqss0nBRh9sYxH/+ibRMnnISm45KURaIhgTz+XXjK6Ufks1mhZaAxEV2D1jGBNaL9pplpS3S2LD9VTIcBCKpzJQVMu4nDm/RotSbEM/XN6Wg645waeb4/3K6zi2QPA7KdNM81DZND2AC+1+hI+pM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770314046;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=a1cCBSLCxzsDLYHEus9AOY/on8OIUfKi78kSXYkA7pY=;
	b=t3JYQ6wo6VCYpx/uiS7X44Y0ejF+oatQ83coyyKadPUcAIott4WX+WL3b5GjhWTf
	tagSHWx/y42OEerNuX8mQPOk9ANd73SiIhMfPpVoFpo6lifQBwozLpEdehSwG47xKmC
	+EjYUDuuJt5u/Psh95EXiD+JW7rQR3oZdz2RlpXI=
Received: by mx.zohomail.com with SMTPS id 1770314041791588.7281258431333;
	Thu, 5 Feb 2026 09:54:01 -0800 (PST)
Date: Thu, 5 Feb 2026 23:23:55 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: lirongqing <lirongqing@baidu.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: fix SRCU protection in irqfd resampler ack handler
Message-ID: <jahsvo33gzqyngvkjnh6vdnb75ljydbyzrifoda5b7wrq5gcig@td5rmmnjyyg3>
References: <20260205094010.4301-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205094010.4301-1-lirongqing@baidu.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8733-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: AFA81F63A4
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:40:10AM -0500, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Replace hlist_for_each_entry_rcu() with hlist_for_each_entry_srcu()
> in mshv_irqfd_resampler_ack() to correctly handle SRCU-protected
> linked list traversal.
> 
> The function uses SRCU (sleepable RCU) synchronization via
> partition->pt_irq_srcu, but was incorrectly using the RCU variant
> for list iteration. This could lead to race conditions when the
> list is modified concurrently.
> 
> Also add srcu_read_lock_held() assertion as required by
> hlist_for_each_entry_srcu() to ensure we're in the proper
> read-side critical section.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

> ---
>  drivers/hv/mshv_eventfd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 0b75ff1..6d176ed 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -87,8 +87,9 @@ static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
>  
>  	idx = srcu_read_lock(&partition->pt_irq_srcu);
>  
> -	hlist_for_each_entry_rcu(irqfd, &resampler->rsmplr_irqfd_list,
> -				 irqfd_resampler_hnode) {
> +	hlist_for_each_entry_srcu(irqfd, &resampler->rsmplr_irqfd_list,
> +				 irqfd_resampler_hnode,
> +				 srcu_read_lock_held(&partition->pt_irq_srcu)) {
>  		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.interrupt_type))
>  			hv_call_clear_virtual_interrupt(partition->pt_id);
>  
> -- 
> 2.9.4
> 

