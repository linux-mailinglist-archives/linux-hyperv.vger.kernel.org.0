Return-Path: <linux-hyperv+bounces-9403-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM/ACfEatGlLhQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9403-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 15:10:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 221262849D2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 15:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BB4C346E701
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2B3947AC;
	Fri, 13 Mar 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxPFHQEP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8C34751C;
	Fri, 13 Mar 2026 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409210; cv=none; b=TPCfuvOHeQHWTB3gaifIBcT+yqVtBVpqv9nj33/vknw57zGQUCQYTTnZ0sEjS4SPCU0XIcpJzoho1QXpAP4LaqVjQna4jRe+D7kVu8GQPQikF4alB1vYKmA/1wTapukAC0FrBGV1yMCFvvB9k3gAjxkR5yhAG4C8SAmuLO/afMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409210; c=relaxed/simple;
	bh=Rh546VvYfrcIbOqjd34ITNun1Dg0vYA0DVNI+3FWxTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW1wgRf1yb1SA3/1DWRQkvGnlN74XP+39iA2eTH4xXZmE90HrnseAwUqw62z+03n+e4hTKLM6nFt9RMf2l2kbmS6zt4TEd4NbMGN2sWHZrZqylwN02UeBiJG3bmvD3dmRXSwfVlSMl96xc2ljqn9SiJJdKugie3ZCvNBoguJCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxPFHQEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E173C19425;
	Fri, 13 Mar 2026 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773409210;
	bh=Rh546VvYfrcIbOqjd34ITNun1Dg0vYA0DVNI+3FWxTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxPFHQEPq0v3jquF6/OUYchqk2r2CIphDLb85v20OC7+yZQAT4FdqG/pXqWFE2NAD
	 LuTbrRrF4RivfSqkiMnxoPVoqYl3DZwx04iVaVueSDJf6GHUzOZ2VArKqKVwNQ4FmM
	 1cqXwsZ3VJrnShK/v2lkDV69H+/UD81lDUE4wNSBfjO9zW/lbGRCK5PNmSypMtUVFG
	 TzgiJ3WTOAa8jq6i47zCSmwMrDM7AuxvjcCVV4QNFsSNuK20hnreVN8KNEPwsq0D6b
	 UBqDQR3oKF7yAKYOSsYCaSdyD0dVUDT0Hk1hTvP0cudUAx+FQRYTeGVoBwQwJmn5U9
	 EOaOEi7hW6KUQ==
Date: Fri, 13 Mar 2026 13:40:03 +0000
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
	stephen@networkplumber.org, dipayanroy@microsoft.com
Subject: Re: [PATCH net,v2] net: mana: fix use-after-free in
 mana_hwc_destroy_channel() by reordering teardown
Message-ID: <20260313134003.GA461701@kernel.org>
References: <abHA3AjNtqa1nx9k@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abHA3AjNtqa1nx9k@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9403-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 221262849D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:22:04PM -0700, Dipayaan Roy wrote:
> A potential race condition exists in mana_hwc_destroy_channel() where
> hwc->caller_ctx is freed before the HWC's Completion Queue (CQ) and
> Event Queue (EQ) are destroyed. This allows an in-flight CQ interrupt
> handler to dereference freed memory, leading to a use-after-free or
> NULL pointer dereference in mana_hwc_handle_resp().
> 
> mana_smc_teardown_hwc() signals the hardware to stop but does not
> synchronize against IRQ handlers already executing on other CPUs. The
> IRQ synchronization only happens in mana_hwc_destroy_cq() via
> mana_gd_destroy_eq() -> mana_gd_deregister_irq(). Since this runs
> after kfree(hwc->caller_ctx), a concurrent mana_hwc_rx_event_handler()
> can dereference freed caller_ctx (and rxq->msg_buf) in
> mana_hwc_handle_resp().
> 
> Fix this by reordering teardown to reverse-of-creation order: destroy
> the TX/RX work queues and CQ/EQ before freeing hwc->caller_ctx. This
> ensures all in-flight interrupt handlers complete before the memory they
> access is freed.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
> Changes in v2:
>   - Added maintainers missed in v1.

Reviewed-by: Simon Horman <horms@kernel.org>


