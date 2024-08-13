Return-Path: <linux-hyperv+bounces-2767-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F97D95039D
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 13:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88531C20B20
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BEE198E6E;
	Tue, 13 Aug 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOCT/6Ks"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85518B480;
	Tue, 13 Aug 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548630; cv=none; b=OJ7feyqhrIAuwkZAB0cVOvAi8VJ+FiFR08CZwRDqYftLJEDAlpICBiDhtKifFfVjp2Qvk5fxdl3f2+M6gohbfjm4SHsLLLM4e9sExrb4dG7S248GvPTIM0QUk40K23bBuKnSRwsbUnOA9r3bLIAbRCPajk0BCdS2bJu/qBzRAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548630; c=relaxed/simple;
	bh=kiwXUxfjx4OtcKC14SZI8xUFCU5QGPX4eXEN8CbXRLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sShtepDCZRwFfuBZ0rmg1akSWDaMsw0J9jjFZhJYEB2qTteieBBeu1AP1a/Fg5V/xbAKthCALi1npdWnBa3+McaKs4afDvyKily+28coPyNZUiAk3Vc5/aJa8/FP7VzCkjNLpDcj1TSBwtKrRwOTjOhT6Fbl3L6yJaf/m3ps1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOCT/6Ks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C097C4AF0B;
	Tue, 13 Aug 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723548630;
	bh=kiwXUxfjx4OtcKC14SZI8xUFCU5QGPX4eXEN8CbXRLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HOCT/6Ks9SESeseIvikOwerpDR78YS4ROZoV5WqO9XHA9EokNr5d3KulKwHsxH9Vm
	 +lIwOH4EXJkWrf+/cmvX6AX2jhSiOdHyFtxIhtTjGxLxx/CHYhCPLesXAMmh7ucSmg
	 gAZmQt7mDq6wbgHQDvtGGfhyQS3bXxrouzAsn5uE/G/dKD5EfQIixWoUDsKucnupEp
	 0JLll8NdhvHt6P+8nyURKE5n9Qc9DbH/xtBpYT5vVjYk8Ys9fakAj1q97Hy8w1MEjO
	 3gkVR+z+iXhQQBTr9RlOzQcj9ip7YOiAkqP5153xDUJ3Rb+QC/xbOiqgLD7FECOA49
	 qv3Z8t3nAEMAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB83823327;
	Tue, 13 Aug 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172354862926.1604273.6519840713233454447.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 11:30:29 +0000
References: <1723219138-29887-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1723219138-29887-1-git-send-email-longli@linuxonhyperv.com>
To: Long Li <longli@linuxonhyperv.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 horms@kernel.org, kotaranov@microsoft.com, schakrabarti@linux.microsoft.com,
 erick.archer@outlook.com, paulros@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 longli@microsoft.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Aug 2024 08:58:58 -0700 you wrote:
> From: Long Li <longli@microsoft.com>
> 
> After napi_complete_done() is called when NAPI is polling in the current
> process context, another NAPI may be scheduled and start running in
> softirq on another CPU and may ring the doorbell before the current CPU
> does. When combined with unnecessary rings when there is no need to arm
> the CQ, it triggers error paths in the hardware.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: mana: Fix doorbell out of order violation and avoid unnecessary doorbell rings
    https://git.kernel.org/netdev/net/c/58a63729c957

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



