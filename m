Return-Path: <linux-hyperv+bounces-1152-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101AF7FE83D
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 05:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424A51C20B6F
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7A1774A;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2gb8qah"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE216422;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C4F0C433C7;
	Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701318034;
	bh=cCbxWq0+NPkfY4QA9+yYjFe6vWIYbmPWSXdcfESV6FQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D2gb8qahivfMLNRgtbckYeMOPP7mTefC9L6uKpLMNbV1D1lvdOaUERpG1w/S4+AFJ
	 CxTNS+G1+4mX4wqS63rx4+u9ocP7u9zXw8jr25CXDnE8+1ifrXcABi1/D+kXcNeI8Y
	 VQkbUpWT64i+9qNIusddSYYcToUbrtCAma68M9D2amZ6J2KwzZYIHDTdFIZFZB8C85
	 mr10+WfXixqwtIGZEkhrccf2NTPz6nCkjiTk3ert+8q/6835CMympQhdpvlUn7Sm7M
	 w86WVgzo4amVCarDuemfcOV7Et4hhITSMdAVxpttZBfBLdtHDqvat8+9rPibbn0bmC
	 eRYJKbZ9G8Xng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEF2DC691E1;
	Thu, 30 Nov 2023 04:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: mana: Fix spelling mistake "enforecement" ->
 "enforcement"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131803390.31156.8118713082387306465.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:20:33 +0000
References: <20231128095304.515492-1-colin.i.king@gmail.com>
In-Reply-To: <20231128095304.515492-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 sharmaajay@microsoft.com, shradhagupta@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 09:53:04 +0000 you wrote:
> There is a spelling mistake in struct field hc_tx_err_sqpdid_enforecement.
> Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c      | 2 +-
>  drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 4 ++--
>  include/net/mana/mana.h                            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [next] net: mana: Fix spelling mistake "enforecement" -> "enforcement"
    https://git.kernel.org/netdev/net-next/c/f422544118cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



