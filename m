Return-Path: <linux-hyperv+bounces-1058-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F97F9F6B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 13:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215BA1C209D7
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2561CF96;
	Mon, 27 Nov 2023 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYVnsgfu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D51DFC1;
	Mon, 27 Nov 2023 12:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D7AC433C9;
	Mon, 27 Nov 2023 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701087625;
	bh=2xL/uJq6qI8TQ3qq2PiEINw1Ueax4X6ay/YZyvpjaWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tYVnsgfuHt1Z2m4uLjWHgJmiqHaFj0WJ6yLBScYenEScmFpLZxk7nGC8pct1Cn4om
	 f8+6yCkpwuv3nyo0Pz5Okc03wFiZbSH5Nbo8DcQvtiJfW1Gmu3QsnH25pQ9m+EOyh+
	 oIxhBcyisB41B8n3phJyKyfy+HtjEwbjgSBSsaXa7EErWQrITQsnCUuPZOHJx2sS+d
	 T9+V3pDxMWIYVKRFkIDItYG8rbszq47W0FwpSNlHEjQrGbH+KuynX/OZGIyeVmilTS
	 OQUAlPwK+cSgQF5iAKoX9i8kePY01KCG/Eu+EBIBXj4vxw6W6hQ6VLkl2rPsA+kufB
	 V6HD1jVgXIJfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 786E7E1F66D;
	Mon, 27 Nov 2023 12:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net :mana :Add remaining GDMA stats for MANA to ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170108762548.32093.15380933168923149331.git-patchwork-notify@kernel.org>
Date: Mon, 27 Nov 2023 12:20:25 +0000
References: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1700830950-803-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sharmaajay@microsoft.com,
 leon@kernel.org, tglx@linutronix.de, bigeasy@linutronix.de,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, mikelley@microsoft.com,
 shradhagupta@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Nov 2023 05:02:30 -0800 you wrote:
> Extend performance counter stats in 'ethtool -S <interface>'
> for MANA VF to include all GDMA stat counter.
> 
> Tested-on: Ubuntu22
> Testcases:
> 1. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 2. LISA testcase:
> PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
> 
> [...]

Here is the summary with links:
  - net :mana :Add remaining GDMA stats for MANA to ethtool
    https://git.kernel.org/netdev/net-next/c/e1df5202e879

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



