Return-Path: <linux-hyperv+bounces-1508-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C63848E1F
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Feb 2024 14:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F9E1C21974
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Feb 2024 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A3224EA;
	Sun,  4 Feb 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdlsK2hj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DE22064;
	Sun,  4 Feb 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054026; cv=none; b=fT/LJb8xyXQBX02KgDB6/as668JUNBRmwJT+wf8DteQIgmGoOGeKe7bIvq6vKtCyHEiaN2PsOrpLEqqX9qO9UssMQdPP9stUPl9hRLwc8iFNYYpXED2ksdnsLZ/f0Xc/Qn64hRVHXjWHPKgrrCz03OrlpIU8ZIwviCtBJsVv21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054026; c=relaxed/simple;
	bh=w5QM7+1JPXBZU46T1reJ00UqrQ3v4Gvwy+gpzb0INUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gGLS9virNXV7tZVuhpH3WEsWn8e9Q3fi85bo6LXezlTpzaRYyeghzCVUy0bPVKE780/IXNzzO1D32W8Q60VjoRvnhreCpLYcynQgUU+52X/iC14JPziTFkpl/i94/0krXC3AITOHEHGzd47eqzzTOFSs42sWtLSwnx+y8WXeCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdlsK2hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DAA2C433C7;
	Sun,  4 Feb 2024 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054025;
	bh=w5QM7+1JPXBZU46T1reJ00UqrQ3v4Gvwy+gpzb0INUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QdlsK2hj6TNjhFUKcVOBt7Gi001hj9Gq0j5y8/rb2v9cG19A4DxIwB+gb3KwdvI3Q
	 EtDs4CtXt6zBAiTqTs8W/r+CmbNg/dbHdAqPgiyeJ/G9GJRSg2BhfxNlS7yFaxGLvZ
	 jWh82wjzmQ/zOn/OmT9JlnDuYXyW70l94Jpt/eyIgPS2FiYudDs/wLcgc7TU+itXgC
	 /ulTaTbpSKWLojgoXM8TS2NsenDdbiKYnXfdk4EegtT9uesoCelMLiEPWONR/SbJKm
	 6dBMDuLatEZQw2NNvwc11rf/4pOF0iaP6+cehEidibBamqGbVzhVm9wmSb1pjiQ8oY
	 tyQHKWMZUxfkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8429EE2F2EC;
	Sun,  4 Feb 2024 13:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] hv_netvsc: Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170705402553.16095.3173468091429343383.git-patchwork-notify@kernel.org>
Date: Sun, 04 Feb 2024 13:40:25 +0000
References: <1706848838-24848-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1706848838-24848-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wojciech.drewek@intel.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shradhagupta@microsoft.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Feb 2024 20:40:38 -0800 you wrote:
> If hv_netvsc driver is unloaded and reloaded, the NET_DEVICE_REGISTER
> handler cannot perform VF register successfully as the register call
> is received before netvsc_probe is finished. This is because we
> register register_netdevice_notifier() very early( even before
> vmbus_driver_register()).
> To fix this, we try to register each such matching VF( if it is visible
> as a netdevice) at the end of netvsc_probe.
> 
> [...]

Here is the summary with links:
  - [net,v2] hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed
    https://git.kernel.org/netdev/net/c/9cae43da9867

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



