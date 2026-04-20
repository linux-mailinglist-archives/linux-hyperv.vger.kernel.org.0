Return-Path: <linux-hyperv+bounces-10208-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MYyBigg5mkMsAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10208-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:46:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E542AE84
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BA0B301DA78
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6A3016FB;
	Mon, 20 Apr 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jsDaoCTM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D817A2FB;
	Mon, 20 Apr 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689160; cv=none; b=bVAKwnt0lPQXK7BZSzFsfxbNdkthrLS+2LMUT/jdL/kfMF0Eq7MTdEGnfjogMgisA0aHbYbQaXSQBZkN8Z4/A4x4aCXRLx1lnBnhi4QEEnQJMYvd8D3H3RVFyyDWsSe4uiYGlz0GYhkLqO/1hYhQpffJFAF0OKk4YGdfoS2XAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689160; c=relaxed/simple;
	bh=ywHV4rlRaf7U22QwGcL0cv9WCEeu8hfRgjLetPcwOdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVI5oftEKwftIRxI9S9RDG6YDCZed4xBrKpA1W5rBT5WsrpQHK/X4urN2igTBBppUYHXvrf1rU41Y9iHJZkjG9fJRrhcpucGhBtDaa2HKiIibUjSatJ8ggfwsg3a0Euwe5tQZFq5PFqcY/s8JzqLYFfgzF6A65m5jSo4B4NjR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jsDaoCTM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1F67620B7128; Mon, 20 Apr 2026 05:45:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F67620B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689159;
	bh=AVIapsQ3c6XvHpmFS/7qSeroIV9NWzTdm3s+C72vh38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsDaoCTMDll3UiCGmzAPjBOUQGLx9fLklBhL0M6rrHlDE+cd4G1q1IvFCHyGa/eJG
	 D0BwB8klVfuuEqaun+qzZvQ38NxI+Smu5XZmWX/I9r8TikRwXICxdB1pv1MumGu5WT
	 neFOBsAxxS5cpSNvJP3264XMUu8UZMzxq4CXwaTA=
Date: Mon, 20 Apr 2026 05:45:59 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: haiyangz@microsoft.com, davem@davemloft.net, longli@microsoft.com,
	ssengar@linux.microsoft.com, linux-kernel@vger.kernel.org,
	kuba@kernel.org, kotaranov@microsoft.com,
	stephen@networkplumber.org, andrew+netdev@lunn.ch,
	kys@microsoft.com, wei.liu@kernel.org, shirazsaleem@microsoft.com,
	kees@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
	edumazet@google.com, decui@microsoft.com, leon@kernel.org,
	gargaditya@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	netdev@vger.kernel.org, shacharr@microsoft.com
Subject: Re: [PATCH net v3 3/5] net: mana: Guard mana_remove against double
 invocation
Message-ID: <aeYgBzvX1O1rvIMn@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260415080944.732901-4-ernis@linux.microsoft.com>
 <20260417140953.218832-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417140953.218832-1-horms@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10208-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A78E542AE84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 03:09:53PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: mana: Guard mana_remove against double invocation
> 
> If PM resume fails (e.g., mana_attach() returns an error), mana_probe()
> calls mana_remove(), which tears down the device and sets
> gd->gdma_context = NULL and gd->driver_data = NULL. However, a failed
> resume callback does not automatically unbind the driver. When the device
> is eventually unbound, mana_remove() is invoked a second time. Without a
> NULL check, it dereferences gc->dev with gc == NULL, causing a kernel
> panic. Add an early return if gdma_context or driver_data is NULL so the
> second invocation is harmless.
> 
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> The Fixes: tag points to ca9c54d2d6a5, which introduced mana_remove()
> without NULL checks. However, the exploitable double invocation scenario
> was actually introduced by commit 635096a86edb ("net: mana: Support
> hibernation and kexec"), which added suspend/resume support and made
> mana_probe() call mana_remove() on error.
> 
> Should the Fixes: tag be:
> 
> Fixes: 635096a86edb ("net: mana: Support hibernation and kexec")
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 9d095a6fb56c..2ab7c89e2fed 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -3685,11 +3685,16 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
> >  	struct gdma_context *gc = gd->gdma_context;
> >  	struct mana_context *ac = gd->driver_data;
> >  	struct mana_port_context *apc;
> > -	struct device *dev = gc->dev;
> > +	struct device *dev;
> >  	struct net_device *ndev;
> >  	int err;
> >  	int i;
> >
> > +	if (!gc || !ac)
> > +		return;
> > +
> > +	dev = gc->dev;
> > +
> >  	disable_work_sync(&ac->link_change_work);
> >  	cancel_delayed_work_sync(&ac->gf_stats_work);
Thankyou for the correction, Simon.
I'll make this change in the next version.

- Vennela

