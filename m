Return-Path: <linux-hyperv+bounces-4468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E968A5F482
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 13:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E088319C22E8
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32EC267B06;
	Thu, 13 Mar 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDGhZDs7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70798267AFD;
	Thu, 13 Mar 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868999; cv=none; b=dv+5lHLU7M0LdsojI+CEmCDL+BuR6PPrEfXKWzVelPuHJS2sihoDFWAnYIUgvmsz8mOpmOg3k/1jYBsa76gGIr6A35/Qch22CVqzr6FP8BSRIvUUT5vZpwxUo5Je9WPN5+oFKsF6Gf9OlAEKlAUatWFU+fwMcpsTgR34vRhoq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868999; c=relaxed/simple;
	bh=iCC+RlmGwLC9DGgjtMedAFqXUbdNm/kiYIj6yiU3nu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DymVD2aYzx9ph00zZ+RVZpkLaPPbAdtCqPdlUGGSifWCeLjUAP+0u/a7peURpUfy0rNTnZEv2rrYnq/EhYcA3c1wZyJXWKysNRm/HkZyWj0dS924/NclDajJI5lDr/dEwiRHMmxkyUR3hA0v5BvQhqh17PrLbbhxUHgzW8CrbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDGhZDs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359AAC4CEEA;
	Thu, 13 Mar 2025 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741868999;
	bh=iCC+RlmGwLC9DGgjtMedAFqXUbdNm/kiYIj6yiU3nu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oDGhZDs7+uxmQZrAfA5xI0jDxiAGmeaVavbe900sPcVEnBa7njboUIsewPRaWdg6d
	 QfMXlTfNNFzl7pYNrStthSjM/VtL+o5Tyi35zEJ1U/HMLgFiCW6rJLk4f3Fu/6MFq1
	 J+kaLON2ciGFf+WJb6dQF0jeMEwafthEEVI5U21H8txvIULz5GAQAj/TZ3WQZrQ4ma
	 hIqoh7EQsw8I5QlPLOEu3vkUAepyYXuZV7jkbmT5AmG5v/CDqJHa88btR3Z6LUgIBr
	 6+fFF9yFruhHJOmX/j8IXpeDbNR8nuQx/uXvHbWIwRiUaRID6l48n/iW1dQggnt06d
	 KGkEkA51dzxUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0143806651;
	Thu, 13 Mar 2025 12:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: cleanup mana struct after debugfs_remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174186903377.1494261.697056613145771727.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 12:30:33 +0000
References: <1741688260-28922-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1741688260-28922-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 longli@microsoft.com, schakrabarti@linux.microsoft.com,
 erick.archer@outlook.com, leon@kernel.org, ernis@linux.microsoft.com,
 kotaranov@microsoft.com, peterz@infradead.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, michal.swiatkowski@linux.intel.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, shradhagupta@microsoft.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 03:17:40 -0700 you wrote:
> When on a MANA VM hibernation is triggered, as part of hibernate_snapshot(),
> mana_gd_suspend() and mana_gd_resume() are called. If during this
> mana_gd_resume(), a failure occurs with HWC creation, mana_port_debugfs
> pointer does not get reinitialized and ends up pointing to older,
> cleaned-up dentry.
> Further in the hibernation path, as part of power_down(), mana_gd_shutdown()
> is triggered. This call, unaware of the failures in resume, tries to cleanup
> the already cleaned up  mana_port_debugfs value and hits the following bug:
> 
> [...]

Here is the summary with links:
  - [net] net: mana: cleanup mana struct after debugfs_remove()
    https://git.kernel.org/netdev/net/c/3e64bb2ae7d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



