Return-Path: <linux-hyperv+bounces-10171-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLtNG94332nAQQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10171-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 09:01:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2740126C
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 09:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 313F8302B954
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7739B4BE;
	Wed, 15 Apr 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nRH1MbTw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF2E396D16;
	Wed, 15 Apr 2026 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236506; cv=none; b=RaUBCUd8jBD/qpYkTL2ngknA78ZVbnGlD8wfut4Th0BZayRwiRC9SL9xXFx146dYDnmKtkGWolZQOOQtrry55/pycQ9mj/TWcL8QM3NjIzx4GLEneTf7ejqXtN+8FUBglVffvY0YpT50fc2KGgLcQbTYZrJV4hNyMawWxi/GBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236506; c=relaxed/simple;
	bh=yixouw+PE3HnvmPt62rovZ2YDMrpsEDDb8Exk4TZfGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj/dOjhoTGBuBZU46fwRycD9clMemG07TzukWK3xvHRceazFqthYGHDyHukkvtvthXCLcxl7tpUH4/g+pPQKLyeJGF8fEaHXOa1fSfFHsDUsktOI+4BL7nDA07R4i0yqn2GOnfDZsMaeU2t0qpw916b5ICG1ZTfcd8KDxk0mNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nRH1MbTw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4812B20B7128; Wed, 15 Apr 2026 00:01:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4812B20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776236503;
	bh=wBnzRJWw2ok2q9mOVdLPwhr8M/J6EvOcNzU89WiZ5RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRH1MbTwxVF3rbjW/qHocNrO3fl6lzbnyYXrkhVtAwsybulf4ZQg3OQwY/ywkQVQG
	 WJ4DRn5gNrzW3JxoRHwuNyKl6nLS+6z3WR6SybNIMBQ+tNrPd9KT9otS72O3K0JW1l
	 JKGehApjdxg5+CU3y6eb0fVx3TQqmO8gnDRYIEPs=
Date: Wed, 15 Apr 2026 00:01:43 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: pabeni@redhat.com, edumazet@google.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	decui@microsoft.com, shacharr@microsoft.com,
	linux-hyperv@vger.kernel.org, kotaranov@microsoft.com,
	kys@microsoft.com, shirazsaleem@microsoft.com, longli@microsoft.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, wei.liu@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	haiyangz@microsoft.com, kees@kernel.org, stephen@networkplumber.org,
	leon@kernel.org, davem@davemloft.net
Subject: Re: [PATCH net v2 4/4] net: mana: Fix EQ leak in mana_remove on NULL
 port
Message-ID: <ad8312IBxNWMk6f2@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260413050843.605789-5-ernis@linux.microsoft.com>
 <20260414154058.771241-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414154058.771241-1-horms@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10171-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: 06B2740126C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 04:40:58PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: mana: Fix EQ leak in mana_remove on NULL port
> 
> In mana_remove(), when a NULL port is encountered in the port iteration
> loop, 'goto out' skips the mana_destroy_eq(ac) call, leaking the event
> queues allocated earlier by mana_create_eq(). This can happen when
> mana_probe_port() fails for port 0, leaving ac->ports[0] as NULL. On
> driver unload or error cleanup, mana_remove() hits the NULL entry and
> jumps past mana_destroy_eq(). Change 'goto out' to 'break' so the
> for-loop exits normally and mana_destroy_eq() is always reached.
> 
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> Does this Fixes tag point to the correct commit? Looking at the commit
> history, the original driver commit ca9c54d2d6a5 did not have
> mana_destroy_eq() in mana_remove() at all, so the 'goto out' pattern could
> not have caused an EQ leak at that point.
> 
> The bug appears to have been introduced by commit 1e2d0824a9c3 ("net: mana:
> Add support for EQ sharing"), which added mana_destroy_eq(ac) to
> mana_remove() and placed it after the 'out:' label, making it skippable by
> the 'goto out' on NULL port.
> 
> Should the Fixes tag be:
>   Fixes: 1e2d0824a9c3 ("net: mana: Add support for EQ sharing")
Thankyou for the correction, Simon. 
I will make this change in the next version of the patchset.

- Vennela

