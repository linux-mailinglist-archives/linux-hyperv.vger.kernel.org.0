Return-Path: <linux-hyperv+bounces-10116-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gArFLbbn22laIgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10116-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Apr 2026 20:43:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 153CF3E5777
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Apr 2026 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C953F3002127
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Apr 2026 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2827236AB6B;
	Sun, 12 Apr 2026 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkTiC2Ci"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE3342535;
	Sun, 12 Apr 2026 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019238; cv=none; b=CEAUcaHoHQYE8X6nxdRRLhCSu4hC4R9a3m0h4opGnBSVHFoLR1TJDS+B4MFTpjG0ehXzjnTvAzcvFvF7vR4R7JTobLv8acGDKx921Pa8fDHWVOKLOahMxGThFyUBOfoyUuFb4P+KY+cMqRGgVBB51A0a+G8HnjOSmoCfC5mLRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019238; c=relaxed/simple;
	bh=Obp4Ut+lsvyVAMR3DeI2RVodBWmcrcaekSIW7FD91IU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ogc9bZIm/yLuBxbCkBFL3Yh1SnjQPfeKE/ujb6B9XjnU1H8obFcKh3qd/t8xL7QE/xmxCmWJ3BREXBQ2NEjuVXKHsPVatLLfkBqbGzQRLOKl6tnAKq3Eb9ifnj4C5QeIM7ij8Y7Q37mBgLB2DCw9Ru5rjCxfJIJv3/lrfR2cSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkTiC2Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37C5C19424;
	Sun, 12 Apr 2026 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019237;
	bh=Obp4Ut+lsvyVAMR3DeI2RVodBWmcrcaekSIW7FD91IU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QkTiC2CiAoqQfGAnrpltQQLSIwUMBeylVihxcnrm/JALIGl2mWGXZToxG+Wd2NWcI
	 UwEQvD5euuTzbAjG1I9aAi+Ge/LVMTG2U2k1PeWc9OYnDlElGQpxA1h3nFFLH2NeGB
	 C1Jeb8fFkcANJHNeKVQQXAE4hpWNYYc2G9jC2ehprTaZ36ErqrYG/Jh0vPzdC5vxF+
	 32dIyhOqpgckOZcY38AZli1D9Q0GZngtlFiQDFS0oSsYtrezpnuDRbiQVvlWYdcG24
	 2BeG7JPLGpZEwhqMWdRrYm6khodaszvwvXihhcYlidD2c1XuUFjAbE/vGl0p+wHaoF
	 HiDhZSDN0sv5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFDD3809A8C;
	Sun, 12 Apr 2026 18:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: mana: Fix debugfs directory naming and file
 lifecycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601921029.3370691.6478285274222564107.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:40:10 +0000
References: <20260408081224.302308-1-ernis@linux.microsoft.com>
In-Reply-To: <20260408081224.302308-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 kees@kernel.org, kotaranov@microsoft.com, yury.norov@gmail.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10116-lists,linux-hyperv=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 153CF3E5777
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 01:12:18 -0700 you wrote:
> This series fixes two pre-existing debugfs issues in the MANA driver.
> 
> Patch 1 fixes the per-device debugfs directory naming to use the unique
> PCI BDF address via pci_name(), avoiding a potential NULL pointer
> dereference when pdev->slot is NULL (e.g. VFIO passthrough, nested KVM)
> and preventing name collisions across multiple PFs or VFs.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: mana: Use pci_name() for debugfs directory naming
    https://git.kernel.org/netdev/net/c/c116f07ab9d2
  - [net,2/2] net: mana: Move current_speed debugfs file to mana_init_port()
    https://git.kernel.org/netdev/net/c/3b7c7fc97aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



