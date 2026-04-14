Return-Path: <linux-hyperv+bounces-10160-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGnqFQNh3mn+CQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10160-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:45:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD053FC146
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF8230A5407
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76553EC2DD;
	Tue, 14 Apr 2026 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeVO+Uo9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843233E928C;
	Tue, 14 Apr 2026 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181326; cv=none; b=ie3PZ9D5j24ORx686VPWphs1EutZ6FuxK96ovDlARM3BKfHkMpvWdiUq9kZ3FGNAeCFNC0eQzibnYXrIadMyUiP1LimrqE23203pmYC1ZR2Dq2Lt+X9lv2YK4kNyve4CmgxaMorCT7zsrO/9A4B85E2MJrA+qv64glQ6KY3yZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181326; c=relaxed/simple;
	bh=WS7w9DxC9IqD41y52PElSOxXCyfAOo12+2sT7qJ69Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2IDY8wxfOomqOzNY4S/uaxJU7alcRbBuHEVTjkXXyc70ahHVoilICdX3duz6GvIBMnxXsIWKD/l25oaGi4h8UCimdKcWybTC7Q3osSxSCDCF6ygw4U9/uCSVC+G7qlNrPOKYYtwS3g9bu1D5vG14cTG5HdrY0BCeQpSWbkggnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeVO+Uo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF7C2BCB3;
	Tue, 14 Apr 2026 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181326;
	bh=WS7w9DxC9IqD41y52PElSOxXCyfAOo12+2sT7qJ69Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XeVO+Uo9vsnLK3iHKHebIUyhgya23y3xC+SwXVF95lgggNND4bnA2O//sFIaN4MZ4
	 WMJR5Qh5/O6plCHLoaYvN5reUC2/oe5Blp04KVDDl0dzRpPIchcD5JlXRE8tZBnL2g
	 07S+07Jf+t55d5xCN0yhRUW9GR2GKwlvY+DdYT8LN/hp6YnOH5ZpKcDNy6yLyo+sl6
	 nKH9n/KL5mavsnbgB0cfHYE5BV3qyHz+IkJQATpeHYUQvTVfATLoELAQe1/uy3GOXm
	 tR0CW0jG3sTpcIHbrKE9BEkPK++IA44uV2woz8RdJIUpgCKw2X3m9hAqWucbRpTrlb
	 X8xPMS5AuJkDg==
Date: Tue, 14 Apr 2026 16:41:59 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] net: mana: Init gf_stats_work before
 potential error paths in probe
Message-ID: <20260414154159.GI469338@kernel.org>
References: <20260413050843.605789-1-ernis@linux.microsoft.com>
 <20260413050843.605789-3-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413050843.605789-3-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10160-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACD053FC146
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 10:08:38PM -0700, Erni Sri Satya Vennela wrote:
> Move INIT_DELAYED_WORK(gf_stats_work) to before mana_create_eq(),
> while keeping schedule_delayed_work() at its original location.
> 
> Previously, if any function between mana_create_eq() and the
> INIT_DELAYED_WORK call failed, mana_probe() would call mana_remove()
> which unconditionally calls cancel_delayed_work_sync(gf_stats_work)
> in __flush_work() or debug object warnings with
> CONFIG_DEBUG_OBJECTS_WORK enabled.
> 
> Fixes: be4f1d67ec56 ("net: mana: Add standard counter rx_missed_errors")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


