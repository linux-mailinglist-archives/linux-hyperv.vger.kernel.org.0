Return-Path: <linux-hyperv+bounces-10197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DX6MEG6W4WnIvAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10197-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 04:09:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A99416229
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 04:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21CD4300EF6F
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 02:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9E23ABBF;
	Fri, 17 Apr 2026 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTJAkF33"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43C1C695;
	Fri, 17 Apr 2026 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391719; cv=none; b=GaLKRAbXNa/wOXOa0SNgFgJZVKugjochq+DK3/7Ya2H0yikIIt7VHVuxvzq2IbLNU4ZSYgmxe/T2CcaeFfqnFW4sWpIeVGGWtO6Kk2x4u4dG8Ee0MN/X/sWYIZ2esaMQHAyilfg3+25/yS5M5CWMxAnrnHlveT1YNMRaeSLoESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391719; c=relaxed/simple;
	bh=AcRid5prjAQXvUSeIkmfK4VJfuY3OU39hoa0Ru3vYj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCKIl9ZNyWhDk8dTfUvqLS+HF7voPZTEaVr9S4I32ljXcfyhLMTw+4Q1tITLA/nHcMubK+4HPSQypHxJCO/GYlpvqC0uZTl1KHdikQZCm0blH2hU1XGPmr6zxMfiw0hYckdWoZ8TeRurzbjlEMnJjrkUeXuw5FTJFy1gPVxia0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTJAkF33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E96C2BCAF;
	Fri, 17 Apr 2026 02:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776391719;
	bh=AcRid5prjAQXvUSeIkmfK4VJfuY3OU39hoa0Ru3vYj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTJAkF33ZkfgARlXaqE5jH3i1puexRKtjGK5S4H7MjqjzLk4DOmXlpBgL8EWhJdOR
	 6+CJxbIczNH6Qr47jp1q29tC/tVUX26LHffwaCvso7WWxvsmZNl+dFhI1Zrgmga5be
	 VUK07xIBRbUReIw1dZg05JBBjIaW3PZrXxMCSpU4IxB8rWUTZrsObS6/4swfkeT9Ey
	 pAOGrI/iVwUfzpych8P/teOFi4hTXZk+H05Ym9Cy1h1m199voGIzcxia+kxOAFWL49
	 xpxAPNu+1shCq8YRzzwSjV8fW+tMRoWExOJeJrVWr2VoydrE/73+ZAknD5gxbvAWyd
	 J5egRT7HHe2Yw==
Date: Thu, 16 Apr 2026 19:08:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, ssengar@linux.microsoft.com,
 jacob.e.keller@intel.com, dipayanroy@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 sbhatta@marvell.com, leitao@debian.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, gargaditya@microsoft.com
Subject: Re: [PATCH net-next 0/2] net: mana: Avoid queue struct allocation
 failure under memory fragmentation
Message-ID: <20260416190837.6b060bbe@kernel.org>
In-Reply-To: <20260414151456.687506-1-gargaditya@linux.microsoft.com>
References: <20260414151456.687506-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10197-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 90A99416229
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 08:13:28 -0700 Aditya Garg wrote:
> The MANA driver can fail to load on systems with high memory
> utilization because several allocations in the queue setup paths
> require large physically contiguous blocks via kmalloc. Under memory
> fragmentation these high-order allocations may fail, preventing the
> driver from creating queues at probe time or when reconfiguring
> channels, ring parameters or MTU at runtime.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.1,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

