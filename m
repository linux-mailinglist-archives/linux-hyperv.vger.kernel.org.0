Return-Path: <linux-hyperv+bounces-10315-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM9lFif56GkgSQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10315-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 18:36:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE1448BFD
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E00CE3074050
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF533803E9;
	Wed, 22 Apr 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SYmly0FW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146E37C90B;
	Wed, 22 Apr 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875483; cv=none; b=klBNe+xUB557CodiXH9N/xM8hz+NX1dbZX76ABF64saV+qK5RI0mKVVIBNaupUD5KCCnVhKSaofhadsoT0Tit+/P7OvuLV2v3vqp16Nj4gBIXkNySvjtNmeye6W0+9XaIsH/8c+WufAQRApUW4M5uvN2JRxKi9Nmakyrzgkg+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875483; c=relaxed/simple;
	bh=peUBD5m08sTT67ZtgWka59qlYKJAljWCivBd1RqFQ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsSU4jQbfGWlGBNEUmvIck2nXp22ob6XbYnhRAZmKxE3GnmYa2xL9kCY+SgCNepuYPHAP50ojsDCrW+8PR0byoJgzemUBcSljFKuWfySI8P/3I0MxR8QgIz/8AEimp+j5yzchIuGE7QS4wdSPAmmPsHLcyFyjYHeJm5MPTckJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SYmly0FW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D20B120B6F01; Wed, 22 Apr 2026 09:31:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D20B120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776875481;
	bh=yYcs3ciRPXLdYtHD830pxRSz6Am6DIQ9YVpyqqk8OZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYmly0FWM/3NduJBTSSY6wMj3HXYtWSraZqnyM//IW8Tm60Y09h9ExihlqQuVJVdt
	 dwq+x6QjkchLy8GAyrRJ0bC7EovDXbx55/PqE4ktSNGBaKlrnO54skxB60PnqLqVfC
	 r7scKS4+iYdLIzpGfwI+ADg1o29ifhg+A5tMbAQo=
Date: Wed, 22 Apr 2026 09:31:21 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-6.18] net: mana: hardening: Validate
 adapter_mtu from MANA_QUERY_DEV_CONFIG
Message-ID: <aej32XgkE1gzSa4D@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260420132314.1023554-1-sashal@kernel.org>
 <20260420132314.1023554-44-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420132314.1023554-44-sashal@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10315-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CEE1448BFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 09:17:18AM -0400, Sasha Levin wrote:
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> 
> [ Upstream commit d7709812e13d06132ddae3d21540472ea5cb11c5 ]
> 
> As a part of MANA hardening for CVM, validate the adapter_mtu value
> returned from the MANA_QUERY_DEV_CONFIG HWC command.
> 
> The adapter_mtu value is used to compute ndev->max_mtu via:
> gc->adapter_mtu - ETH_HLEN. If hardware returns a bogus adapter_mtu
> smaller than ETH_HLEN (e.g. 0), the unsigned subtraction wraps to a
> huge value, silently allowing oversized MTU settings.
> 
> Add a validation check to reject adapter_mtu values below
> ETH_MIN_MTU + ETH_HLEN, returning -EPROTO to fail the device
> configuration early with a clear error message.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Link: https://patch.msgid.link/20260326173101.2010514-1-ernis@linux.microsoft.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> 
> FOR backporting:
> - Fixes a concrete integer underflow bug (adapter_mtu - ETH_HLEN wraps
>   to ~4GB)
> - Small, surgical fix (6 lines of logic)
> - Obviously correct bounds check
> - No regression risk
> - Accepted by netdev maintainer
> - Author is regular driver contributor
> - Affects widely-used Azure MANA driver
> - Security-relevant in CVM environments
> 
> 2.53.0

Thanks Sasha, this is good for stable.

This should also carry a Fixes tag:

Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")

The code was introduced in v6.4-rc1, so the backport applies
to 6.6.y and later stable trees.

Acked-by: Erni Sri Satya Vennela ernis@linux.microsoft.com

