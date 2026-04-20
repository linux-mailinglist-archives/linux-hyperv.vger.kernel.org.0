Return-Path: <linux-hyperv+bounces-10230-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pn6HHui5mkrzAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10230-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 00:02:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E14346F7
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 00:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135B3303982C
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 22:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0FF388E6D;
	Mon, 20 Apr 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms/qCc2R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624421E091;
	Mon, 20 Apr 2026 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722423; cv=none; b=fYQSprKpAN2is5EjJKYzVNmFlXC/Vipr8CjTdTczSaWIFFgZ0Bq13miISkP4M+NHmzhLdpExpC3ZhHnegn10UsQ9Vbym4NhIlcY3A0yoGsTuvs7hRLA2Ck6kwghYKLUpV0sWaS0iaBXcthUeE3MHbrZFxLzjI7+25IsPCV2n3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722423; c=relaxed/simple;
	bh=Z7I1XCZV4GXOlQXyoOCyHcUya2+3HNpV4yUL9YrhXEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PXtwitKFHI97PTA1T322x4AXST7PuyifnX2vU+CleMfHVEY4zwWQEreQ+/yOoGIoygw8eulSuws84KArZHie54XmmJjmTOq9QrdfDbRRWfLF11QZktLMkJAUQgucZW+9OYMLC/CHoA8nwS19b72ow2rgYLuUIQV3xS0aJ0FT1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms/qCc2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2731C19425;
	Mon, 20 Apr 2026 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722421;
	bh=Z7I1XCZV4GXOlQXyoOCyHcUya2+3HNpV4yUL9YrhXEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ms/qCc2RG7aJ8gJesEiFg/9AUKS4zPcLrZHJY5LWnTXVifgu92kxGaBPZN7xOshbq
	 YAeEpk0i0nnmyAnzHmo7y6qOsj3ukMMJXjg9ogmRYNU67TGfBETIgHJS9jm48e/zq9
	 wOKLu7FVfDj2ymvMzQ1FnDVzf1FPH+jrNFwtEZYZgpsoPrs+v/QzxWU7PalNwSN3Fr
	 VmWJKS6QgNwc1ZHuxGol18PfJwO3vr77xissGuQhQ5XUVVRVWvVbL+cygHtmMplE/r
	 Fq0jOFsVPo7dnb2XMIt0U0c6TQraT1HMP1LuSB3l7DLIZPhvpeZ/8XN3Zw+P9C+I7P
	 Ws7ftcLRBie+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE2C3930022;
	Mon, 20 Apr 2026 21:59:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO for FIN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:45 +0000
References: <20260416191433.840637-1-decui@microsoft.com>
In-Reply-To: <20260416191433.840637-1-decui@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 longli@microsoft.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 niuxuewei.nxw@antgroup.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ben.Hillis@microsoft.com, levymitchell0@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-10230-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F0E14346F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 12:14:33 -0700 you wrote:
> Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
> and the final read syscall gets an error rather than 0.
> 
> Ideally, we would want to fix hvs_channel_readable_payload() so that it
> could return 0 in the FIN scenario, but it's not good for the hv_sock
> driver to use the VMBus ringbuffer's cached priv_read_index, which is
> internal data in the VMBus driver.
> 
> [...]

Here is the summary with links:
  - [net,v2] hv_sock: Report EOF instead of -EIO for FIN
    https://git.kernel.org/netdev/net/c/f63152958994

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



