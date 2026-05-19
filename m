Return-Path: <linux-hyperv+bounces-11024-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKmKDBhIDGoMdAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11024-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:23:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9344957D801
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A77430F19ED
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C53F4DF3;
	Tue, 19 May 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPCCbWLH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A472023393C;
	Tue, 19 May 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188994; cv=none; b=Wj54wLkOTNiTHVeuTRuNgv4XNYgx3Rc1QlE22GwAdKyY3mCVIWAxxAg0eWupY74cmbednzmcZZ4ts5/rhpvl5PS0GBUkT4dnDDXDs0a+hurcrbMni7wGxvFKuwdfyIJwc4Z1KmvBf1QiYjaY6yJZNgYSARbadEcWsfIMRAemQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188994; c=relaxed/simple;
	bh=OD4UZsjHtEN1aiUjjQcRNSdiA3DyaW3cm9nozizTUr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MnmSWySDgri2D+XWRxp6bDTapiWSoDgB3a2admodeE1nCranaxdhODPci6fTi3GgLDipix0xHf90Wh/OHt7i6zX476MSzCyuM/fA1tgrVKjU5tPgqNDQe7p9+CspieOOvMmoe+xS5CNceot5YTiSS0m5b6l5q5o6Vh4PCu05tgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPCCbWLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F26C2BCB3;
	Tue, 19 May 2026 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779188994;
	bh=OD4UZsjHtEN1aiUjjQcRNSdiA3DyaW3cm9nozizTUr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cPCCbWLHY16T6wJYGhhuOobXTkWhFHnk8O36Z63tAXoS3VyC5NDtOLG0GJIcmJr8S
	 LEWu9avRP4cZ4UUZFUWHwUcmvaOm9zXMn0nAq/diI6p3MYkL1d6u2tZjX/ZbAwmlX+
	 Tbx2Fn2W7Z9hEeyD+2x07S7PLw8quxza9Kj4wQPZishxBgBAtuWehcRdnmYJyG/+NS
	 lyS3nyw5MNcZz5uXCQ9hWMGOERUPQ5CvOKtjX1E7R/k7aYmOOvPnq6Aelg9+iFD8QK
	 7Z+VdwreYFKzjNv6sI7LGg6LYO/U9r/7+4Z7wm3TxH3V7U94m3laGVNrqVqK0jKFrz
	 dTzcaaYPPrLyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D693930E03;
	Tue, 19 May 2026 11:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: Fix TOCTOU double-fetch of hwc_msg_id from
 DMA
 buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177918900539.2248334.5810940924546864636.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 11:10:05 +0000
References: <20260514194156.466823-1-ernis@linux.microsoft.com>
In-Reply-To: <20260514194156.466823-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dipayanroy@linux.microsoft.com, horms@kernel.org, kees@kernel.org,
 shacharr@microsoft.com, stephen@networkplumber.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11024-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9344957D801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 May 2026 12:41:51 -0700 you wrote:
> In mana_hwc_rx_event_handler(), resp->response.hwc_msg_id is read from
> DMA-coherent memory and bounds-checked, then mana_hwc_handle_resp()
> re-reads the same field from the same DMA buffer for test_bit() and
> pointer arithmetic.
> 
> DMA-coherent memory is mapped uncacheable on x86 and is shared,
> unencrypted, in Confidential VMs (SEV-SNP/TDX), so each load goes
> directly to host-visible memory. A H/W can modify the value
> between the check and the use, bypassing the bounds validation.
> 
> [...]

Here is the summary with links:
  - [net] net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer
    https://git.kernel.org/netdev/net/c/35f0f0a2536a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



