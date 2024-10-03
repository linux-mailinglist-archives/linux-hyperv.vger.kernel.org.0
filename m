Return-Path: <linux-hyperv+bounces-3107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A654A98EE7B
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B611F23901
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898A51547C6;
	Thu,  3 Oct 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPxXHG5C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C81474C5;
	Thu,  3 Oct 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956227; cv=none; b=lKrQ0qol8ZfdJ5B08cddV9zt8AXPFrxgKxNAnj86jv7Hqh+W8eGtgTrNAuFOem78p+Fmj7lep5D/GwWjJyF+WWoHaiGj1Mfyz0uTnLDeXPC7zl6AWXE2bfB9tUWvSPDRosaGU/Zo0btgsKkSBMP9JuEE4xKv2W4+V9Xt2PqCVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956227; c=relaxed/simple;
	bh=g4MP9ugxBnR5ddbXUOrC/2+O4iuBEfGHKQ7OSl+BM3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RJPI7EoxgvxVPWpYw5s7z1H2nQhtDiXnwlVIeiOhlj7rjDp+qNwZD9nVkQ5aBdQrT/cxinRLQPWZ3KS6oORXkcpCZ5M2qEtCV+Z4CEJbI9Iu7rblE1P+odjUpLWHzaTQIEXulzmDrXJGuxUaHRYOMdsHwcsCfm/NyO2pWtrOqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPxXHG5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8B5C4CEC5;
	Thu,  3 Oct 2024 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727956226;
	bh=g4MP9ugxBnR5ddbXUOrC/2+O4iuBEfGHKQ7OSl+BM3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DPxXHG5CX514RPM1S9lXnmJAXC2Hj/VHpNhl335xrFZItKrWPAFusfJa5fNE04XVG
	 dAe8wPTRYEjiwqBRkCYuqmqoatYi2jtFRsMzzx3tbWUqz7MhYTmGFE9tkWh5wWRmOI
	 V8OwmI3O8CA6AsvZQD0TjDPdqRd9KU8Hq/7If9TNX2xLfDrgoC176eod37M1kDOabU
	 HiZv26ybUh5K7zlPDzmQ7qYKe0BK7C8Gl5F/RqwV6pRWC0cq3XpAotH1CeXUCxOn4w
	 4q+dEPG0q0vl1YaoQJtBCuCLYylAbDxsI3KvJsSsVjnkLRBlrUH5ETHZ6wI+RTzi+B
	 VE1snNMkKRy4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E9D3803263;
	Thu,  3 Oct 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mana: Add get_link and get_link_ksettings in
 ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172795623026.1832228.2819429248368280593.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 11:50:30 +0000
References: <1727674934-12130-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1727674934-12130-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 leon@kernel.org, colin.i.king@gmail.com, ahmed.zaki@intel.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 29 Sep 2024 22:42:14 -0700 you wrote:
> Add support for the ethtool get_link and get_link_ksettings
> operations. Display standard port information using ethtool.
> 
> Before the change:
> $ethtool enP30832s1
> > No data available
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mana: Add get_link and get_link_ksettings in ethtool
    https://git.kernel.org/netdev/net-next/c/c30a3f54e661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



