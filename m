Return-Path: <linux-hyperv+bounces-9086-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAUKBmp1pWkNBgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9086-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:32:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C531D78A4
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A8F3062962
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B81363083;
	Mon,  2 Mar 2026 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVdvvYDR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2F3603ED;
	Mon,  2 Mar 2026 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450853; cv=none; b=Hy3radr/dHkaZPHKVhYpfeYwLcXvqVzAPDztztEK5tPDF5cZdrQLyOpXRJL2HDZKMAZqQkZDWU98y2rn58HNs40tQqt+KR2N2/fq/cYFO/cP59Bw0uFlrUlTFrhttdzQpDGU0IE4Ek7oi0mAgSCvKXk5BYVDFrkJo33lSKJKmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450853; c=relaxed/simple;
	bh=PcZrUmBxaOJWLfbNq25KRwrbFeSf8ocdRGC8n8mWYnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C08kKQ2axiJw1wA/HQxNvKN/HbeSnZQ8TR0NHULzmipVB5PO+QUVG0mBR2zOpxV+yt5F13tyoEKVt72OEC6URrjNeDq78f90UtoGNkv4XelJpKOf8avw+9R8WxEqf2P1ZZH2XW/Ah5Pa9KMukvQ2PxP97qOcRWlvcZ9yVTq63jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVdvvYDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0032C2BC86;
	Mon,  2 Mar 2026 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772450853;
	bh=PcZrUmBxaOJWLfbNq25KRwrbFeSf8ocdRGC8n8mWYnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVdvvYDR/dVFCkkP2v1Tvr78ZDyVd8cyfzcjKMbzVvZ3XI4OFwZ5heRq+XHhFaebM
	 j/TZxUvU5TDsIU2cIpobXK1JX85Mhfylzvww3S05Sd3DKZ4Qwfox2JFk0UjAli5I0i
	 gv2aZm02ASB300NBchxaE/fNx6ESkWc6GL56TmyIcRlkdK5D4IBvJtGVxwy/izIYU/
	 0PqYoPyI7kLmGTd8SYT+FabANtrAkw4VhLD88gw88065YqqqyRpxORIG9TS7bMsVSN
	 4NM8fLVYGGUdHLxjuJzs9h8GyNe2R/fPluwcRvY8JPpxo/e7lAMXZBo+kvSduyVSeb
	 1c/0vvbw52DUg==
Date: Mon, 2 Mar 2026 11:27:26 +0000
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
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v2] net: mana: Trigger VF reset/recovery on
 health check failure due to HWC timeout
Message-ID: <aaV0HvxQneKM8p-c@horms.kernel.org>
References: <aaFShvKnwR5FY8dH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaFShvKnwR5FY8dH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9086-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88C531D78A4
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:15:02AM -0800, Dipayaan Roy wrote:
> The GF stats periodic query is used as mechanism to monitor HWC health
> check. If this HWC command times out, it is a strong indication that
> the device/SoC is in a faulty state and requires recovery.
> 
> Today, when a timeout is detected, the driver marks
> hwc_timeout_occurred, clears cached stats, and stops rescheduling the
> periodic work. However, the device itself is left in the same failing
> state.
> 
> Extend the timeout handling path to trigger the existing MANA VF
> recovery service by queueing a GDMA_EQE_HWC_RESET_REQUEST work item.
> This is expected to initiate the appropriate recovery flow by suspende
> resume first and if it fails then trigger a bus rescan.
> 
> This change is intentionally limited to HWC command timeouts and does
> not trigger recovery for errors reported by the SoC as a normal command
> response.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
> Changes in v2:
>   - Added common helper, proper clearing of gc flags.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

...

