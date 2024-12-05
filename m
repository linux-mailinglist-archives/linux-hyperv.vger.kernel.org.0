Return-Path: <linux-hyperv+bounces-3398-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F270F9E5369
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 12:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD209164299
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Dec 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69871DDA35;
	Thu,  5 Dec 2024 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPO3cKKP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14B1DD0C7;
	Thu,  5 Dec 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397019; cv=none; b=qHGMoAdUNMaa9lxa417wZu+lQ6qsuvshwm9sdyFGoVKBqydwmVzWlOUiyGDesNeZRzQkzmRn1cYBd9i7e0IrAqhh5KCAWOCfyH9v9Xtlnxtbod6NWHE32/PihE5CsLZxtnl2M1ddVkuHxjz9o6pxYFGrA2sTFXatnow+vTXAIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397019; c=relaxed/simple;
	bh=i90CknQg+VPzlddK+0B4sQpYQFC/5UYP4mum2Dngnms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uz5GMcyRiQYTbJXeGYHPdn3cgX9Vchv3gpoLS71x+F4Kuenmh9qvbfHk1zvJY0ZLvj1nUKAjTFCSa/5DbGdqa/0rvT8Q9KyQFXIHQ1bhFf1HOsRp3/AI+Nso5Y8o8UuFgrRYhKW2Ma53rKxyUUnMxWQVpdRtcVY6pZNyg+CrBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPO3cKKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78EFC4CED1;
	Thu,  5 Dec 2024 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733397017;
	bh=i90CknQg+VPzlddK+0B4sQpYQFC/5UYP4mum2Dngnms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vPO3cKKPB/dLcHcik30htLZZpUGrRmJyOdKiRPuTsmCJD9GlnbhIAI+JIzfAA/LmX
	 OX8U3NISGIRS25sW0hEbYD/9CtRRe+TzIEZPXCxEPXvyDq5t6mOZc3rTUwl2h9wfAO
	 7o9wV8/xCVfLBeEQKzYtsZMGKoOEaWn5HlFd+uowkj0qlpaxCWV6nacmeGqqu2OrfT
	 PK8+vnLkqlH6HoixCRABcwcQhfL1FtYLiIxJxfJ69LARy/aXxBXZSLHj/Ch2Yo64Qb
	 0gC9wyFMp+EEXUfyD/BkQiMrVJHLxumOhwHUxX6TOsz+0YpJ2bb4yYa7py9CwCCNuG
	 lWJXJOY4/ZGtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE291380A94D;
	Thu,  5 Dec 2024 11:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net :mana :Request a V2 response version for
 MANA_QUERY_GF_STAT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173339703253.1552278.3279028556184368012.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 11:10:32 +0000
References: <1733291300-12593-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1733291300-12593-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com,
 schakrabarti@linux.microsoft.com, erick.archer@outlook.com,
 shradhagupta@microsoft.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Dec 2024 21:48:20 -0800 you wrote:
> The current requested response version(V1) for MANA_QUERY_GF_STAT query
> results in STATISTICS_FLAGS_TX_ERRORS_GDMA_ERROR value being set to
> 0 always.
> In order to get the correct value for this counter we request the response
> version to be V2.
> 
> Cc: stable@vger.kernel.org
> Fixes: e1df5202e879 ("net :mana :Add remaining GDMA stats for MANA to ethtool")
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net] net :mana :Request a V2 response version for MANA_QUERY_GF_STAT
    https://git.kernel.org/netdev/net/c/31f1b55d5d7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



