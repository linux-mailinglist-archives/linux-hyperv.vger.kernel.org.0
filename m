Return-Path: <linux-hyperv+bounces-10582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGtgHPYr9mlNSwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10582-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 18:53:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E74B2E92
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EFC53005784
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C713859F4;
	Sat,  2 May 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7ONpL4/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEECC1A6808;
	Sat,  2 May 2026 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740787; cv=none; b=eM117kfo+KqM7CknbkCJyohBM1LKSK9WbkIf5eiR5clb2iLgG1euJhKRbHIUZKZXZCYE+gWfOwPzuOjq6ZlLvtoLfvGeZxndoLzcnypU28S2jQ+ckPPltviKCnnGQ2uND9Tx7NbndfDz6E+GHPARWG2JzFgwDTTZkbx6V7PscRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740787; c=relaxed/simple;
	bh=63je9fQk8rbq2FWAeTdpdXqpGJDjhaBfm7Vkh48f+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sztee4XeCF2m/q8jxWRxeHaR6DUYT/rCea+779idKj8AFUjss7Mke3GA86aQ2MmowsaVP4QOy0DqcwvA9y3xo5bOdVx9uLdUJlD+gH46eyi6OXjROweujeP3i1+4xV/YYxP5SwIodQ5mdBLF5doH8Q0a0wpththqSLkl9tjVJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7ONpL4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79B8C19425;
	Sat,  2 May 2026 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777740786;
	bh=63je9fQk8rbq2FWAeTdpdXqpGJDjhaBfm7Vkh48f+Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7ONpL4/AN7uJhb9ZXPsM8kwagVU4kLEko7Mr30q3l37I+nFleUIC9bJUewS+COES
	 vAq9Xoeh1KBfFEER9HbAzXuSfm+PLr5ZcrgC9bbeRIFgA+5td5E7ouSF5cxo5enZae
	 IjzzO6c9eApZiajedDnwHroPsHCUOYqXyopE2Srlb4mqt6tbKf2JwLWlCBy/NtXbwd
	 dAA5vXmkR9PauyaFsPWFmzHfS4ET5EpfpFO/yN7m2JV+5uIbc2IuYREw+LDTAlORn6
	 V8VRnhf7gMUhAzPQjy1jWLltibcj7n0yKtGE8r7LeYzUbNKFCkS+kojVMhOSg/82E8
	 fmT51UAmd4Ffw==
Date: Sat, 2 May 2026 17:52:58 +0100
From: Simon Horman <horms@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	yury.norov@gmail.com
Subject: Re: [PATCH 0/3] net: mana: Fix mana_destroy_rxq() cleanup for
 partial RXQ init
Message-ID: <20260502165258.GM15617@horms.kernel.org>
References: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
X-Rspamd-Queue-Id: C84E74B2E92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10582-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]

On Wed, Apr 29, 2026 at 08:57:51PM -0700, Dipayaan Roy wrote:
> When mana_create_rxq() fails partway through initialization (e.g. the
> hardware rejects the WQ object creation), the error path calls
> mana_destroy_rxq() to tear down a partially-initialized RXQ.
> This exposed multiple issues in mana_destroy_rxq() path, as it assumed
> the RXQ was always fully initialized, leading to multiple issues:
> 
> 1. xdp_rxq_info_unreg() was called on an unregistered xdp_rxq,
>    triggering a WARN_ON ("Driver BUG") in net/core/xdp.c.
> 
> 2. mana_destroy_wq_obj() was called with INVALID_MANA_HANDLE,
>    sending a bogus destroy command to the hardware.
> 
> 3. mana_deinit_cq() was called twice — once inside mana_destroy_rxq()
>    and again in mana_create_rxq()'s error path — causing a
>    use-after-free since mana_destroy_rxq() frees the rxq first.
> 
> This was observed during ethtool ring parameter changes when the
> hardware returned an error creating the RXQ. This series makes
> mana_destroy_rxq() safe to call at any stage of RXQ initialization
> by guarding each teardown step, and removes the redundant cleanup
> in mana_create_rxq().

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

I don't think that you need to repost for this. But please keep in mind for
future submissions that fixes for code present in the net tree should be
targeted at that tree, like this:

Subject: [PATCH net vN/M] ...

Also, FTR, there is an AI generated review of this patch-set available
on sashiko.dev. It seems to me that the issues flagged there pre-date
this patch-set and should not block progress of it. But you may wish
to use that review as the basis of some follow-up.

