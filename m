Return-Path: <linux-hyperv+bounces-10207-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK2dJ8Ig5mkMsAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10207-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:49:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F0A42AEE6
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FD493012BC4
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37841399019;
	Mon, 20 Apr 2026 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uod/RAxq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFE12F585;
	Mon, 20 Apr 2026 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689120; cv=none; b=JuZmncB9PfXDan+O+4YVLescz1yk/YQcI8ncvj2vyUA7OHbuap65KkyAPHu97K/1jl4S9ZZh9nmirajZ75WbgPWmCMXOjJ/Hlj8+hKRtXLMWDUhMKsKJNB0UXxfPlvgLUSjo05nwQhisjdzNtNqqdOMho3vedH6K3rTCX6krkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689120; c=relaxed/simple;
	bh=8UXIXdh53adTO00GBOTE6XeRJRUI/UNXzkaHNp+9EAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOXKgtqaK3VR1s2pZFAon1c6DGBEqPAcrSQa7jxtuLFbk2mI2BIY8kVmN0exPsjPtTgVYsS/YUU9HCvkkJbPhHuR2gGEUb05ai2ro5O2iIB7hJoa866eI3ZEMi1JWEWqOnTHFHrK99rFLHEWgIiqOOluElBKjWVni3jGV/aMKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uod/RAxq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0705A20B7128; Mon, 20 Apr 2026 05:45:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0705A20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689119;
	bh=yZ8gk9CH6j9JDtSoAjnvLHTLhA5RjWScx9Eyq5zdLi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uod/RAxqjy90m6cY5YNIHovekEKelzGunJ/OkJWFn8MoC6LADwLZSp96k7fKdWoQE
	 jNP5rbXe2a2b7NKBaszWols7Ro7ZEMez4fdFt8HgvXDggTLcpGZlPOQ3Wz2fGtARCZ
	 REKrl/pPV2nGrjr+fCTVmRdtST7fmqhkyTKDGDGQ=
Date: Mon, 20 Apr 2026 05:45:18 -0700
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
Subject: Re: [PATCH net v3 4/5] net: mana: Don't overwrite port probe error
 with add_adev result
Message-ID: <aeYf3tL8YCRfDJ/Z@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260415080944.732901-5-ernis@linux.microsoft.com>
 <20260417141014.218936-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417141014.218936-1-horms@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10207-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 21F0A42AEE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 03:10:14PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: mana: Don't overwrite port probe error with add_adev result
> 
> In mana_probe(), if mana_probe_port() fails for any port, the error
> is stored in 'err' and the loop breaks. However, the subsequent
> unconditional 'err = add_adev(gd, "eth")' overwrites this error.
> If add_adev() succeeds, mana_probe() returns success despite ports
> being left in a partially initialized state (ac->ports[i] == NULL).
> Only call add_adev() when there is no prior error, so the probe
> correctly fails and triggers mana_remove() cleanup.
> 
> > In mana_probe(), if mana_probe_port() fails for any port, the error
> > is stored in 'err' and the loop breaks. However, the subsequent
> > unconditional 'err = add_adev(gd, "eth")' overwrites this error.
> > If add_adev() succeeds, mana_probe() returns success despite ports
> > being left in a partially initialized state (ac->ports[i] == NULL).
> >
> > Only call add_adev() when there is no prior error, so the probe
> > correctly fails and triggers mana_remove() cleanup.
> >
> > Fixes: ced82fce77e9 ("net: mana: Probe rdma device in mana driver")
> 
> The existing Fixes: tag points to commit ced82fce77e9 ("net: mana: Probe
> rdma device in mana driver"), but was the bug actually introduced there?
> 
> Looking at the commit history, commit a69839d4327d ("net: mana: Add support
> for auxiliary device") added the unconditional 'err = add_adev(gd);' call
> that overwrites the error from mana_probe_port(). Commit ced82fce77e9 only
> modified the add_adev signature from add_adev(gd) to add_adev(gd, "eth")
> but did not introduce the buggy pattern.
> 
> Should the Fixes: tag be:
>     Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")

Thankyou for the correction, Simon.
I'll make this change in the next version.

- Vennela

