Return-Path: <linux-hyperv+bounces-8702-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD7wK7LqgmnqewMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8702-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:44:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AEAE2610
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4377F302DF45
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B33816F8;
	Wed,  4 Feb 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxjoYlIo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C813806D7;
	Wed,  4 Feb 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187439; cv=none; b=SmpGWBQSxs9nJwM8zjXbDukVMZDir8T5vZaHWEXVWUbCzD2gh5PKbBvAGc1pU0OocSelCbmll1nW7i2llGJo1v2Iixte2SKs3tv0xyYUliph+3c+4C5Q52TXopiGTdcTRXGKx4inozulrYNMzzorlR9ui2Djjpu4obowklK5n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187439; c=relaxed/simple;
	bh=4VpQFex8bzq5hKWM9W44OMFdMgrds5btT7Yy0N2cwu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTZTzR/sURr/MYUtvNt3/pyjBbHWpJJHwhDPGoR55sO7ZyH26QAClK2BBtuqb3y8fWe5YtBYyqRZfJhn681WUSEaB92hsXvM3OrNGHnDkZ4lCsxFv1ATNbNVeMr9LOGIRvWD5vmKaN+JmmKmMe9MdHFAzoNayDHW8S+7MpCUTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxjoYlIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF7CC4CEF7;
	Wed,  4 Feb 2026 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770187438;
	bh=4VpQFex8bzq5hKWM9W44OMFdMgrds5btT7Yy0N2cwu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxjoYlIoUNCqcOZDxuxdvf5E7X4UhCKo/RYjyMBR5Rl4egl8bTuM7OBKLygbm8U63
	 05Tye3cI404IxL+Z0D8eRrwjXa4bfwvf7phR07hQrm0RgQBV2xL42503PuuVdxw1So
	 XPLwKZCJtyJeAFXZHP3ZKvAK+DU296B3Jt1o0cqLZl6c9WvcrKALbTgUJ79RuApPCU
	 CaosGhjtNi3LPu4UKaMcdNLoZ4LwpCp4dDBJWBbonjWxzgPU9HazFnarAxxJRfYHMt
	 YMwlabaqLhnennLeKsnhceNmsas33AzG04jBK/hYoUVZagtAjJXjxHqQ6mzQEr3Kgx
	 mqA4z3BtOYDWw==
Date: Wed, 4 Feb 2026 06:43:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	open list <linux-kernel@vger.kernel.org>,
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
	anirudh@anirudhrb.com, schakrabarti@linux.microsoft.com
Subject: Re: [PATCH] mshv: clear eventfd counter on irqfd shutdown
Message-ID: <20260204064357.GK79272@liuwe-devbox-debian-v2.local>
References: <20260122114130.92860-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122114130.92860-2-clopez@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8702-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid,suse.de:email]
X-Rspamd-Queue-Id: 31AEAE2610
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 12:41:31PM +0100, Carlos López wrote:
> While unhooking from the irqfd waitqueue, clear the internal eventfd
> counter by using eventfd_ctx_remove_wait_queue() instead of
> remove_wait_queue(), preventing potential spurious interrupts. This
> removes the need to store a pointer into the workqueue, as the eventfd
> already keeps track of it.
> 
> This mimicks what other similar subsystems do on their equivalent paths
> with their irqfds (KVM, Xen, ACRN support, etc).
> 
> Signed-off-by: Carlos López <clopez@suse.de>

This looks like a good change to me. I've queued it to hyperv-next.
Thanks!

Also CC our kernel folks just in case I missed something.

Wei

> ---
>  drivers/hv/mshv_eventfd.c | 5 ++---
>  drivers/hv/mshv_eventfd.h | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index d93a18f09c76..4432063e963d 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -247,12 +247,13 @@ static void mshv_irqfd_shutdown(struct work_struct *work)
>  {
>  	struct mshv_irqfd *irqfd =
>  			container_of(work, struct mshv_irqfd, irqfd_shutdown);
> +	u64 cnt;
>  
>  	/*
>  	 * Synchronize with the wait-queue and unhook ourselves to prevent
>  	 * further events.
>  	 */
> -	remove_wait_queue(irqfd->irqfd_wqh, &irqfd->irqfd_wait);
> +	eventfd_ctx_remove_wait_queue(irqfd->irqfd_eventfd_ctx, &irqfd->irqfd_wait, &cnt);
>  
>  	if (irqfd->irqfd_resampler) {
>  		mshv_irqfd_resampler_shutdown(irqfd);
> @@ -371,8 +372,6 @@ static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *wqh,
>  	struct mshv_irqfd *irqfd =
>  			container_of(polltbl, struct mshv_irqfd, irqfd_polltbl);
>  
> -	irqfd->irqfd_wqh = wqh;
> -
>  	/*
>  	 * TODO: Ensure there isn't already an exclusive, priority waiter, e.g.
>  	 * that the irqfd isn't already bound to another partition.  Only the
> diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
> index 332e7670a344..464c6b81ab33 100644
> --- a/drivers/hv/mshv_eventfd.h
> +++ b/drivers/hv/mshv_eventfd.h
> @@ -32,7 +32,6 @@ struct mshv_irqfd {
>  	struct mshv_lapic_irq		     irqfd_lapic_irq;
>  	struct hlist_node		     irqfd_hnode;
>  	poll_table			     irqfd_polltbl;
> -	wait_queue_head_t		    *irqfd_wqh;
>  	wait_queue_entry_t		     irqfd_wait;
>  	struct work_struct		     irqfd_shutdown;
>  	struct mshv_irqfd_resampler	    *irqfd_resampler;
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.51.0
> 

