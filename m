Return-Path: <linux-hyperv+bounces-1499-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BB845D70
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAA41F26472
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA75539C;
	Thu,  1 Feb 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="legpP2Iy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E855220;
	Thu,  1 Feb 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805627; cv=none; b=Mn3baYHBvsQCbPsSFzQ6/hu2l0Z6O+RtCfIIb6OCv8KNkW35Bv0eN2LrUKiAmooWQr1wc9v5/xDSPlNl3L163COXX1dKdXITkI8U3coH0nHdTmdWFNJyaNGrFDeLRpSQDvUsVIEQMR3iHAVybyk0aD/eHUaNpZ9aYb65meHhc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805627; c=relaxed/simple;
	bh=cEeiNYKArm+VYNgUm6O2A02TGK3a297C60jApYVOn98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kstfxy1wkE4wktLTvtPk9KNwUeSZkd+aNfaCe7N0KDcyjsHgDu4ix7uu7Wsk4ijqnk43yW/9Hg6H8RL57yO+qLpY7TZ01j5d+kDAkwGSvlV7KSN1LuFBiaROFXjpmN9RKJkzVxRH/WQgKAdZpVgdjDLn7eV5+3lOZaKDEkensik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=legpP2Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5EA0C43394;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805627;
	bh=cEeiNYKArm+VYNgUm6O2A02TGK3a297C60jApYVOn98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=legpP2Iyco/ENQwWpCazE2ZQ7lro7yMbH+fUnmbTsUZ93ltNeCemnU/i2OAR8ktO1
	 z6Tal1lytqo0gU8XTTfEsQ3gynyVQ8hp42TWd+js388O5xMIndV2+3fnB7nK3RqOdL
	 JfMTP02HqekWuLtUshOiJmkO+FqcUzulC5CmbrUFC/AnTxQE+k3UogvpMsz8RXRmJ/
	 XwAfRzK2jkrx3IpuaEyMAjhvabz2oKjBGUvGr+dVA2h24Dilw+VuMr3VcMSmQ/RprM
	 EML0Ef6fhbcOyAo25B36NcTO4SKr688xvJG/YrvCNgJeBG/g6oAqP0nHNmVcwlB8Uf
	 k+hA+LwKiq+CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC251D8C9A3;
	Thu,  1 Feb 2024 16:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net] hv_netvsc: Fix race condition between netvsc_probe and
 netvsc_remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680562683.32005.9726914174097287156.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 16:40:26 +0000
References: <1706686551-28510-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1706686551-28510-1-git-send-email-schakrabarti@linux.microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 yury.norov@gmail.com, leon@kernel.org, cai.huoqing@linux.dev,
 ssengar@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 schakrabarti@microsoft.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jan 2024 23:35:51 -0800 you wrote:
> In commit ac5047671758 ("hv_netvsc: Disable NAPI before closing the
> VMBus channel"), napi_disable was getting called for all channels,
> including all subchannels without confirming if they are enabled or not.
> 
> This caused hv_netvsc getting hung at napi_disable, when netvsc_probe()
> has finished running but nvdev->subchan_work has not started yet.
> netvsc_subchan_work() -> rndis_set_subchannel() has not created the
> sub-channels and because of that netvsc_sc_open() is not running.
> netvsc_remove() calls cancel_work_sync(&nvdev->subchan_work), for which
> netvsc_subchan_work did not run.
> 
> [...]

Here is the summary with links:
  - [V2,net] hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove
    https://git.kernel.org/netdev/net/c/e0526ec5360a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



