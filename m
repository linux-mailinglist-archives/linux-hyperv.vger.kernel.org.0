Return-Path: <linux-hyperv+bounces-6510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7CB1EFE6
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Aug 2025 22:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718EC1C25949
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Aug 2025 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9893F2512F1;
	Fri,  8 Aug 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkpOygPB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1AF24DCF7;
	Fri,  8 Aug 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686198; cv=none; b=iL/c584p/AXyHdyUt1+x1Bo5CzXBiCsyOZD+L0tT7AhsXXXD3eYnTcTFxwfU9GmEyvzLNGvHV6PzDpszGE4VBzYJHsY2wDNEviJyiuVLB1i10XLdkXZaD8gSRlZ5c/Frco/Brij51z5OAdop1vQY9loPK6iXl2SuJbVxLgiSY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686198; c=relaxed/simple;
	bh=vbPO1Z2O5/XQmrbQpNnJxGj4ucnLwhHQhFQ9Eq3o/ww=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rLsJ+z+E83FG5PAXEXukg7Uspn7VxEW/NvuzukfpAeY8GLTncRKvx3y3PsK3vVIt6k+k5U6Ie9NlwPgerginXLAC3Ox4SgudhLjtfx7Ub+6Wt6tuvhv80U+1BQm1LT+fHPFwMZ8TaY63TFiIu5DOku1sOidmsbognyBKu35ndio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkpOygPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1630C4CEED;
	Fri,  8 Aug 2025 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754686198;
	bh=vbPO1Z2O5/XQmrbQpNnJxGj4ucnLwhHQhFQ9Eq3o/ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jkpOygPBC6uVqxsjIISAmmQTQgtCPwPZrrB7ssczBMtMfKgUruj9UXTZ5mvthYfbk
	 yG48m2hSvLhaxVrRArMUg6qLSSMulgEeZ6rNMUmBj+ZZMNHgbHIULgmz8fWV9Wcm5H
	 BSaFISENaUHNIQvJAqUhlBJpiE0cimgRQQoXoH/j08/3euVgGjFhOYdUfuVy5U9v/h
	 vVa27oQYj2+8p0PIFIHm4oESVd/Hl6NgTzrU4KPLfUUnxosVOAvBx0fkkFBHmTbulb
	 +O2tziYvKT7thTvxpRG1ElM/crabUxAV+gDcsahmzeBoJmq6u5/EAxtvLoawFQKiGl
	 ko7Z3Q7zJIAeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B78383BF5A;
	Fri,  8 Aug 2025 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] hv_netvsc: Fix panic during namespace deletion
 with VF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175468621124.263488.11010327015683191308.git-patchwork-notify@kernel.org>
Date: Fri, 08 Aug 2025 20:50:11 +0000
References: <1754511711-11188-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1754511711-11188-1-git-send-email-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Aug 2025 13:21:51 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The existing code move the VF NIC to new namespace when NETDEV_REGISTER is
> received on netvsc NIC. During deletion of the namespace,
> default_device_exit_batch() >> default_device_exit_net() is called. When
> netvsc NIC is moved back and registered to the default namespace, it
> automatically brings VF NIC back to the default namespace. This will cause
> the default_device_exit_net() >> for_each_netdev_safe loop unable to detect
> the list end, and hit NULL ptr:
> 
> [...]

Here is the summary with links:
  - [net,v2] hv_netvsc: Fix panic during namespace deletion with VF
    https://git.kernel.org/netdev/net/c/33caa208dba6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



