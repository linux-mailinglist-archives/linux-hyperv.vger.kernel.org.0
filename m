Return-Path: <linux-hyperv+bounces-9149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCgLMkBpqWlN6wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9149-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 12:30:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E9210966
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 12:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9C843016EE4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2026 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3504386C17;
	Thu,  5 Mar 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6AoRiQX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD438656B;
	Thu,  5 Mar 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710205; cv=none; b=k9khZ5ROpcDjX0ZFODbmOp6ygGYbMw0UBhvLhtwdDXh2imox6n+/8zzctO85tDhd+/z1zT05QbpUJrA5ksu10f5PsOvNRVdPvbxsljRtYg2zfdNcb4wHzhD4zm8TpQ/jJBHf6bhf8nY5xYmsQDaQwJRkSMO5lSk1knTehe+TabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710205; c=relaxed/simple;
	bh=VDZd9/nOYubZ5tkV6Llnck70B4t8D+CSC4x2/AAjA3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=os7zYOXpGVcHV6k3w9MaE9R4QvMonQ46UzVX1ucNrSugiA+uTNYQtnhmWoUHJ6LAKImr7QeS4UVfyz7gil64uI/1WFPWSj2tmcnanMhtzsLAs9wY1B3GJo0dJeAmSbYM3OS3HZNL2Wm34VQT32ZrEayBIPpxEXvaq8K+RwVbfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6AoRiQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C9AC116C6;
	Thu,  5 Mar 2026 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772710205;
	bh=VDZd9/nOYubZ5tkV6Llnck70B4t8D+CSC4x2/AAjA3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D6AoRiQXaudzEpnAD4YUw9nAIRfyUySdNHcRDCwQw/yHOiVRvSxPQ7UZOnLL0fC7K
	 2qBGiYmhDzzK18IJnBnXHkdoPgrRsP4iZprkt2DEaghHvTR4DjJIpxLGRu5PrCGrBr
	 g3tAtyO0oXT19FNBekwyoOjJsCMBGyBi7k7IIVSHfcBAMilr7TofWrK/54KvmlGL59
	 955maexvh7xXEqbWX4rO9q3tJSACCpJ9VUQSSD/+3eM90GkQFe77nvycpi44wkUZhs
	 vSdV/BiLI1H9/0lyaGYmng4EFTUJicii162XRV/icHXjWEouh3sGcuYlMhRgwjwa4D
	 sIvatxKGvgwSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF013808200;
	Thu,  5 Mar 2026 11:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: mana: Add MAC address to vPort logs and
 clarify error messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177271020530.2660688.10448426333343148786.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 11:30:05 +0000
References: <20260302174204.234837-1-ernis@linux.microsoft.com>
In-Reply-To: <20260302174204.234837-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 shradhagupta@linux.microsoft.com, gargaditya@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 754E9210966
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-9149-lists,linux-hyperv=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Mar 2026 09:41:52 -0800 you wrote:
> Add MAC address to vPort configuration success message and update error
> message to be more specific about HWC message errors in
> mana_send_request.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v5:
> * Remove __func__ and __LINE__ from error logs in hw_channel.c
> Changes in v4:
> * Remove logs that do not add value in hw_channel.c.
> Changes in v3:
> * Remove the changes from v2 and Update commit message.
> * Use "Enabled vPort ..." instead of "Configured vPort" in
>   mana_cfg_vport.
> * Update error logs in mana_hwc_send_request.
> Changes in v2:
> * Update commit message.
> * Use "Enabled vPort ..." instead of "Configured vPort" in
>   mana_cfg_vport.
> * Add info log in mana_uncfg_vport, mana_gd_verify_vf_version,
>   mana_gd_query_max_resources, mana_query_device_cfg and
>   mana_query_vport_cfg.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: mana: Add MAC address to vPort logs and clarify error messages
    https://git.kernel.org/netdev/net-next/c/0172f8d80220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



