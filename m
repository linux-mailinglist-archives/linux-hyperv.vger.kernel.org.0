Return-Path: <linux-hyperv+bounces-9631-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F73FPQZvWnG6QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9631-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 10:57:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005732D85A2
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50B230734D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDF29ACC5;
	Fri, 20 Mar 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUbg/8NX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741991B3925;
	Fri, 20 Mar 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000560; cv=none; b=TPMqb5W3QOZ5oVe4Bq/ive9GgzxBSz80vgHGYgmJAO6fC7fXyRgc05Y17y/oHrI5/qdncU6+vBMUPKEsMGmnI0OQ2epFOsk2PalfPpzxTiCcR5moR8AoChBFHbKiwXjliSCPwyYhmmwZqIAT4Fsoy673TOW6aykBwirXZAl4oNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000560; c=relaxed/simple;
	bh=623iNHEo9Lx3CTyFj1XQ3Tb8dZwfqVZ4nDlwLICOGOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNH0ddx1JDIE0ZFW9M83uXSS5PFuT+eHr4tviSE5gEjbPSu+/f9//aBJNbdjY0KgxMzn9gkwJQE+IB2B1zLTMd+y1FjcNoc2yLPDKiZDo42RtCe1KiMK6HgXHWs3qZpqZZ5fMKV2CTB6MeYPuvJ+RmS2pABkAvAAdrPtfi3c5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUbg/8NX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1273C4CEF7;
	Fri, 20 Mar 2026 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774000559;
	bh=623iNHEo9Lx3CTyFj1XQ3Tb8dZwfqVZ4nDlwLICOGOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUbg/8NXG3OZ3aqDbbu0ZF7Xlgg/mMa1uVvBe0VVF9qJu14G6q5weqLBn/KJ0hXZl
	 fyhOqLwQvgE4h2q2K8SO9VdZCUZ2X6BOHS19VnEPmMPPJH8AgnOiN/qVJPwXODDOeA
	 J5n8etfF55U+uF7YWjon2CNadkoKWL/EGsGhL3swqeUyDXWwpvPiD+55O7EKsOFrAj
	 bxlOJlgB/wt6E6ICwceWIE/DykLmAhywBNAlxqePAA4F64y0VoJFvYqTZM4kaLrHva
	 H63o6SYyJdAELw7SVHMcAa1EVm8hVeMw0DNDTBHtnyjtQqwkpv4hC/owWgJcT2wsG/
	 L66DckitYpcKw==
Date: Fri, 20 Mar 2026 09:55:53 +0000
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	dipayanroy@linux.microsoft.com, yury.norov@gmail.com,
	kees@kernel.org, ssengar@linux.microsoft.com,
	gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <20260320095553.GD1753385@horms.kernel.org>
References: <20260319070926.1459515-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319070926.1459515-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9631-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 005732D85A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 12:09:13AM -0700, Erni Sri Satya Vennela wrote:
> Add debugfs entries to expose hardware configuration and diagnostic
> information that aids in debugging driver initialization and runtime
> operations without adding noise to dmesg.
> 
> The debugfs directory creation and removal for each PCI device is
> integrated into mana_gd_setup() and mana_gd_cleanup_device()
> respectively, so that all callers (probe, remove, suspend, resume,
> shutdown) share a single code path.
> 
> Device-level entries (under /sys/kernel/debug/mana/<slot>/):
>   - num_msix_usable, max_num_queues: Max resources from hardware
>   - gdma_protocol_ver, pf_cap_flags1: VF version negotiation results
>   - num_vports, bm_hostmode: Device configuration
> 
> Per-vPort entries (under /sys/kernel/debug/mana/<slot>/vportN/):
>   - port_handle: Hardware vPort handle
>   - max_sq, max_rq: Max queues from vPort config
>   - indir_table_sz: Indirection table size
>   - steer_rx, steer_rss, steer_update_tab, steer_cqe_coalescing:
>     Last applied steering configuration parameters
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v4:
> * Rebase and fix conflicts.
> Changes in v3:
> * Rename mana_gd_cleanup to mana_gd_cleanup_device.
> * Add creation of debugfs entries in mana_gd_setup.
> * Add removal of debugfs entries in mana_gd_cleanup_device.
> * Remove bm_hostmode and num_vports from debugfs in mana_remove itself,
>   because "ac" gets freed before debugfs_remove_recursive, to avoid
>   Use-After-Free error.
> * Add "goto out:" in mana_cfg_vport_steering to avoid populating apc
>   values when resp.hdr.status is not NULL.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


