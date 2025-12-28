Return-Path: <linux-hyperv+bounces-8087-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F49CE4AA3
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Dec 2025 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC89330049FB
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Dec 2025 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3929B8E0;
	Sun, 28 Dec 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WljUubgF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CD7081E;
	Sun, 28 Dec 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766915673; cv=none; b=DTx0vzjCF2hATxtZjHMuLDPqRk6bIt79Y0l0DQsute32Vw91Enaxi35REhHl7GoeWz3wACjwZPD01DHxTVQuOWP93WPmkZ8J6llC0U9uAZPUUDVUow7Xh8KZvAkS/8gyBva6oIIFrR1nxkQNPy5nFrCPT95HvgRWgOegsMulRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766915673; c=relaxed/simple;
	bh=1JhtYSmaX52dqMFjRgL/WPL55BcSU8b8R1L5w9jGErU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nkIWpdbP2Mu4+JVuNsesIZBeZ+/tHJJuXnP6ou24IQ+exDyM/Y5hBYuVGBFSy6p5orrYWCyDVqoZaCVdsJQgfnQTskeHttj0TR7HI+2MNb5EFSaPv3FpxbOTS57ME/aecgM54T+lMbMf64ehriwSKRwM7ZdtJwaPUKslz8c+QTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WljUubgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24C9C4CEFB;
	Sun, 28 Dec 2025 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766915672;
	bh=1JhtYSmaX52dqMFjRgL/WPL55BcSU8b8R1L5w9jGErU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WljUubgFWNdq85sAeorH/ijlRDLItlciWOFhi7KO7LBisHvgqF/IzagKRVhZ14ccl
	 WNhUNZbvWkViCMysYcAoTv3Mx5Dp3f5cvuZbHrdnI9DqJ6s/TSo19chEtN7k9M7W1u
	 2Fy/uUBkxuHBlQlIWgl4AbKmfVkxv3/7jUckhhmZEQEJBzXZvKHg0Tms4iVYDnga5w
	 BgItkY+TMzIurv/1WFFXxVTCTckguOt0tAQeQNbLVrNSmfeBosN8tSw06xvTMVuC/F
	 9+WVU10dQqiT8UNqD7W4JpDCqOIUCoZMsKLKYWmesPQ3IvZ2YSDk6ZMkkKpxKF3+dk
	 8suGoRNbGGL4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78DC03AB0926;
	Sun, 28 Dec 2025 09:51:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net, v2] net: mana: Fix use-after-free in reset service
 rescan path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176691547632.2296662.6661455228363086264.git-patchwork-notify@kernel.org>
Date: Sun, 28 Dec 2025 09:51:16 +0000
References: 
 <20251218131054.GA3173@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <20251218131054.GA3173@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Dec 2025 05:10:54 -0800 you wrote:
> When mana_serv_reset() encounters -ETIMEDOUT or -EPROTO from
> mana_gd_resume(), it performs a PCI rescan via mana_serv_rescan().
> 
> mana_serv_rescan() calls pci_stop_and_remove_bus_device(), which can
> invoke the driver's remove path and free the gdma_context associated
> with the device. After returning, mana_serv_reset() currently jumps to
> the out label and attempts to clear gc->in_service, dereferencing a
> freed gdma_context.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: Fix use-after-free in reset service rescan path
    https://git.kernel.org/netdev/net/c/3387a7ad478b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



