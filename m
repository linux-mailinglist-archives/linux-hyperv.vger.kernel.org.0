Return-Path: <linux-hyperv+bounces-10512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOIQLEvP8mnOuQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10512-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 05:40:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A749D0BE
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 05:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63AC93078A3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB556393DDD;
	Thu, 30 Apr 2026 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ5fUnGV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DAC3939C9;
	Thu, 30 Apr 2026 03:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519598; cv=none; b=sAq3dsw2ONxWvsR/vsb+Fq16CVhmrcbRlaJJTht4oevy/91xXQP+jSq7HOPOY/NAglTfe37VYOAifC3Q3H279XeCpHVUJR2GXFrXLX0xALuDghLzKKLvEjZDrgZtL3pWVHzz+AfWkgXKLfrgvQbD2fRUOjfg9iCln9lNkCQWHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519598; c=relaxed/simple;
	bh=l9exXaykMZZr58ApvA3wgjdBqbjJXmcg2LD51E1L2d8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fHRh6fOO7W95GgKPTjcVjtirDJIml6iMBeUMVNOGZj5zvcj07ltbJpuXMmQrHHUYOpU5+oVHS1EdvrrCDrrhR9I4tPgRVo48z3oYhJj+9TrZEVJ5NVXJGYeljLkjw4YqrdRquQsSOc9Z7wixpouDQGRwmJO2gbnrMqLtI1PlIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ5fUnGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3B0C2BCC6;
	Thu, 30 Apr 2026 03:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519598;
	bh=l9exXaykMZZr58ApvA3wgjdBqbjJXmcg2LD51E1L2d8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VQ5fUnGVnOy9olGba/PpFhmIOWwrvE63bg7wf8QD1oVMBU1BxMtz5Q5sq/JwQ9xtx
	 FBCndWX7NJpcwHQS2uh8ZRD+UwKJS8Nf/xOjB7kKUPQy858zCbkge2oAV6lxAQf625
	 gG1qodBE+N3L2UtwgzEs5J0HoMAeFALuJQm6hAGuvkiAJgkXb28kjlalsRs3n3a2TF
	 29IamRcKDsnYhlWjglq3Ko8zPoEuXsWpPSgFQW5Uw0WEZ3PhmG1Et2p+yJY2KivWmR
	 Vv+BDgeCmlfDBpvBGUWuK6vk0BLhwJE3vHWgs2Tf1Bq4zcCUvorNfflKfJA4kV/UO2
	 SQxIDV5JK1LdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3C3809A07;
	Thu, 30 Apr 2026 03:25:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/8] firmware: sysfb: Consolidate config/code wrt.
 sysfb_primary_screen
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751955329.2274119.12779807302343885295.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:53 +0000
References: <20260402092305.208728-1-tzimmermann@suse.de>
In-Reply-To: <20260402092305.208728-1-tzimmermann@suse.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-riscv@lists.infradead.org, javierm@redhat.com, arnd@arndb.de,
 ardb@kernel.org, ilias.apalodimas@linaro.org, chenhuacai@kernel.org,
 kernel@xen0n.name, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, deller@gmx.de, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org
X-Rspamd-Queue-Id: B35A749D0BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-10512-lists,linux-hyperv=lfdr.de,linux-riscv];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This series was applied to riscv/linux.git (fixes)
by Ard Biesheuvel <ardb@kernel.org>:

On Thu,  2 Apr 2026 11:09:14 +0200 you wrote:
> The global state sysfb_primary_screen holds information about the
> framebuffer provided by EFI/BIOS systems. It is part of the sysfb
> module, but used in several places without direct connection to
> sysfb. Fix this by making users of sysfb_primary_screen depend on
> CONFIG_SYSFB. Fix a few issues in the process.
> 
> Patches 1 and 2 fix general errors in the Kconfig rules. In any case,
> these patches should be considered even without the rest of the series.
> 
> [...]

Here is the summary with links:
  - [1/8] hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS
    https://git.kernel.org/riscv/c/d33db956c961
  - [2/8] firmware: efi: Never declare sysfb_primary_display on x86
    https://git.kernel.org/riscv/c/5241c2ca33bb
  - [3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable option
    (no matching commit)
  - [4/8] firmware: sysfb: Split sysfb.c into sysfb_primary.c and sysfb_pci.c
    (no matching commit)
  - [5/8] firmware: sysfb: Implement screen_info relocation for primary display
    (no matching commit)
  - [6/8] firmware: sysfb: Avoid forward-declaring sysfb_parent_dev()
    (no matching commit)
  - [7/8] firmware: efi: Make CONFIG_EFI_EARLYCON depend on CONFIG_SYSFB; clean up
    (no matching commit)
  - [8/8] firmware: sysfb: Move CONFIG_FIRMWARE_EDID to firmware options
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



