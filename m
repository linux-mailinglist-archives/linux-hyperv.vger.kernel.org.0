Return-Path: <linux-hyperv+bounces-10407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJB+EPnu72nYMgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10407-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 01:19:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B03BC47BBFC
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 01:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 975EB300C034
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 23:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C039D6D4;
	Mon, 27 Apr 2026 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5kT8ebW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE637187C;
	Mon, 27 Apr 2026 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331952; cv=none; b=OoBHzevVzrD9CIpjs1JMbqKzcaGhYbAqFgaV+NGv7etfC5FNephm+m0AUdBReOwrdi5bpo1Xq2S+842OONNlgK4bEvZz+pDJf3W+CZojwxA5fpFfTQ7b/BsCWCh+S7Fy9hH+tiP2lfKfBa4DMSbIjbFpQp3MBJ4BB1SWE8Iml3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331952; c=relaxed/simple;
	bh=fl6jiyndXGosxRIeiSSRWVpzK52bfTzdd2/+Tk1yp0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9UNPDB47shc2tbL2PWCUhGRMd2YJpBwoPLHa/1CHkzc15l8IvQBIDWegEANTzRQLBZiqVPp3fG0tLCUbnV/bJOlRc3bwewSWIe6NYUqOVZSb2iVXxtZ9D1uX6i+rLKQKVN/ejMxA4L6qbiFE4s/KZmLnEgRYNN1FKxQYEWyiN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5kT8ebW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAEEC19425;
	Mon, 27 Apr 2026 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777331952;
	bh=fl6jiyndXGosxRIeiSSRWVpzK52bfTzdd2/+Tk1yp0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P5kT8ebWjDPSav/4EQ9IMNKp2IQ1OFIkVE5zpPqH0pTQPLcf2zAdRUwbm0qnyekQg
	 GP1CwPng50NEL0GgCm7KHcojyJE2JM34/SbHYKeKCmBGJY8GioBnEyEqxoxEDCkVrN
	 VIzoJWKlT8dg/NMOGlfw825iHNPqtEZketkChtwJmEe3XbAvwUI8TQUQ1c1SusBj/U
	 gQHhKezM68/O7Xa1+XRY5Pr9QNEiJJWg3rmTafTNQ8yuvP789/CUUoHz0pnxop2VFZ
	 +viqeDgiQBLVfDcyFuijvk9CEWK+MZSk4oBNQw4qb+hl6Qm1/zv2w2ZFhwtbKrDNRx
	 ShfMUWXXcnd1g==
Date: Mon, 27 Apr 2026 16:19:10 -0700
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
Subject: Re: [PATCH net-next v2 0/2] net: mana: Avoid queue struct
 allocation failure under memory fragmentation
Message-ID: <20260427161910.6b3cb5cb@kernel.org>
In-Reply-To: <20260427132807.1642290-1-gargaditya@linux.microsoft.com>
References: <20260427132807.1642290-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B03BC47BBFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10407-lists,linux-hyperv=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 06:23:33 -0700 Aditya Garg wrote:
> The MANA driver can fail to load on systems with high memory
> utilization because several allocations in the queue setup paths
> require large physically contiguous blocks via kmalloc. Under memory
> fragmentation these high-order allocations may fail, preventing the
> driver from creating queues at probe time or when reconfiguring
> channels, ring parameters or MTU at runtime.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.
-- 
pw-bot: defer

