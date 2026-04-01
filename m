Return-Path: <linux-hyperv+bounces-9864-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Fy0FkSQzGk7UAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9864-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 05:25:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3437454E
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 05:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 168A430623C9
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3832D37CD57;
	Wed,  1 Apr 2026 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCYGwi9B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D037C0E5;
	Wed,  1 Apr 2026 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013630; cv=none; b=apd8AqsEcwVtVCDnhv9x3bABEsJ+YkQvZOgzm6BdK9VO4KTWNlBFhrEbXEw3YmRWcVOlffYy+Fr2FYPUDg+STjr24NGRBLDxGxb2d3O3Ob+WyEFpbaLtEM7xZrHVCtPgHNyNODpJTlKY3jCrlV66XWHEqlovktexL9pma4FFOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013630; c=relaxed/simple;
	bh=NI2tLcbfg21bErumX5uDC7oQRXMzn2dSGxNzwKAaGyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RXr9hw2IUfQMMUiPV97gQtv5PWjkzzK6FJvxRSMZdc+e/F6i1H8stx1r/nM3ftnQL2cW5yZCE2xTcbZLSLbtC3oq3dr1Eyw3prE19Twvo2vfBeuM1oWops7PK+S5LcQzpAYTTOUKdMCjLt714lTeWfpooThNXqOJ4EQ1b0N0PVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCYGwi9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ED5C19423;
	Wed,  1 Apr 2026 03:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775013629;
	bh=NI2tLcbfg21bErumX5uDC7oQRXMzn2dSGxNzwKAaGyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jCYGwi9BV4hG9kruU9xG7c+a6CrXCRJYaWg0EnMPYfRNIN+76ZqHlobTmh/AIdjeP
	 jZoqE+UETu2pkuo++bmiKg8uadgGgJp1fEI+XuqT/X7Nj8I1QH1S1XIVjp2dAYfnEl
	 IWJ+vU0txhvCE7W66EK7+TOlp6icZwk15YmzAKAwuOgKczs5Yp44qJhlwaDzYC2WR8
	 ssqPHDOHxLUnzsuGFwTve4JgufQoJElpndHwVrjYyu0ecoNFxFwctYOFt9yVVnEUFU
	 JHfFypvO1/Nbyer2B2pOZNIB+cRTETnb4og2fi46CphpRYKbsrAG8qFL0Zj1yIGIW9
	 uxSd3qxhWVaOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1E3808203;
	Wed,  1 Apr 2026 03:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: hardening: Validate adapter_mtu from
 MANA_QUERY_DEV_CONFIG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501361303.3053582.13515488108524195809.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 03:20:13 +0000
References: <20260326173101.2010514-1-ernis@linux.microsoft.com>
In-Reply-To: <20260326173101.2010514-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9864-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CC3437454E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 10:30:56 -0700 you wrote:
> As a part of MANA hardening for CVM, validate the adapter_mtu value
> returned from the MANA_QUERY_DEV_CONFIG HWC command.
> 
> The adapter_mtu value is used to compute ndev->max_mtu via:
> gc->adapter_mtu - ETH_HLEN. If hardware returns a bogus adapter_mtu
> smaller than ETH_HLEN (e.g. 0), the unsigned subtraction wraps to a
> huge value, silently allowing oversized MTU settings.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mana: hardening: Validate adapter_mtu from MANA_QUERY_DEV_CONFIG
    https://git.kernel.org/netdev/net-next/c/d7709812e13d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



