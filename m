Return-Path: <linux-hyperv+bounces-2502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F891A42A
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jun 2024 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812F2281119
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jun 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A93F14830A;
	Thu, 27 Jun 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObLTprxC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD3146D7D;
	Thu, 27 Jun 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484829; cv=none; b=ceLi3bQNX1VuVeo/nwL8lcgU3nAMLQavpwjG4C9ihCNvYFG677Pj/rr42qWMzs4pUwRRmGDboTSCP1vPMvGEevWyIvWD2yKjx1bW2b0chRitkncczuY0NbC8zmFS+Nio0IvffSgn+UgwJME+bPVHCpKGmczbuidUDI2moPhbDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484829; c=relaxed/simple;
	bh=2MDDXR4KEvuWBsQmvWfPZ5K4Y9VhgvoWonIB2qz20OI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D7Z/lmnpBPRiwBuebu3UQXE7n1kbOeiG4pSfUg4F8XHBkoQBtKBJARhRL8KQ6d7e5lv2Sr0KMrzJ5oq3957wEbiSuOrpQ1l40+HJi8eghv1VONFEiPZYLj/P1HWyx9jtVHKkRJ0XcOSbhJzv0XfiXcnHWE6jrOJzdd7VAbsVFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObLTprxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A299DC32789;
	Thu, 27 Jun 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719484828;
	bh=2MDDXR4KEvuWBsQmvWfPZ5K4Y9VhgvoWonIB2qz20OI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ObLTprxCIkX2ujT0zyILcCHMJkH9dxPmWD0tZvicY6nT4/z6oh+JRRjxZY8SXxhVr
	 5c1q7RPE5ybiVkEHFKHxk0XaiT67kiePfXdLeZDTiOMC3mEwZz2IMnJfmDvQGh6cVx
	 ZX8n74FBGuNLHNZAbjBUOV0KxrosJdJCvXFjicHA6a2ThYmJrzXmyMZ5u8oHOIE/sw
	 LK4aE5h3QMKpkavWd1hSjwKFEmOiVMJSA/jFIaM6vhvdub8jpGdAFk/kgB6OWUyq8X
	 hDvm1UNpcWVsor1wtyqO+2atJQNiqtPOf+QiKj2Hc+g9fLr892Jktttn4imL3slHWM
	 8eJWJ271msG2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94ED9C4167D;
	Thu, 27 Jun 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: mana: Fix possible double free in error handling path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171948482860.885.1093281785997333661.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 10:40:28 +0000
References: <20240625130314.2661257-1-make24@iscas.ac.cn>
In-Reply-To: <20240625130314.2661257-1-make24@iscas.ac.cn>
To: Ma Ke <make24@iscas.ac.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 horms@kernel.org, kotaranov@microsoft.com, longli@microsoft.com,
 schakrabarti@linux.microsoft.com, erick.archer@outlook.com, leon@kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 25 Jun 2024 21:03:14 +0800 you wrote:
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), callback function adev_release
> calls kfree(madev). We shouldn't call kfree(madev) again
> in the error handling path. Set 'madev' to NULL.
> 
> Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [v3] net: mana: Fix possible double free in error handling path
    https://git.kernel.org/netdev/net/c/1864b8224195

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



