Return-Path: <linux-hyperv+bounces-1334-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17081458A
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Dec 2023 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176022850C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Dec 2023 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797E249F2;
	Fri, 15 Dec 2023 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNW/FWL+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D6208D7;
	Fri, 15 Dec 2023 10:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB068C433CD;
	Fri, 15 Dec 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702636224;
	bh=zUs38Qy9ljrIft3cFXjmCP9RlrZz941EopDb/Elva7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HNW/FWL+3oF57oWSaXPYZVA58wYO5saeO1L5r7ygxBVFyiA7dcyPMK4EyZnkpIbdX
	 I14R3LO3j+Ujr6H820AwI3m3qGdSlZATJnRgSsXgEiqSFkeMealVd2v6E+vQrBZ32d
	 A6iD4vt2uXmKzEp60lWGbxESOmUBozkc9EndYNXQ+wbsp46OyWtjUAA65f70I1hMYB
	 Oqgw6EgbscC4b5LWicVpLmiUTO4qPg24ZcZXxxhMEaog6IP/pUqZ+hLyzBxkqX+mEr
	 ufUk93Dts+zv2QJKFJIeaJXZm/F9r67NojH4yv3iG7fF8zDpOKM+Zq7fRza5Wq/9Pg
	 yFSS0vXYohnKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 943F5DD4EF5;
	Fri, 15 Dec 2023 10:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH for-next v2] net: mana: add msix index sharing between EQs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263622459.29656.3858446025399076996.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 10:30:24 +0000
References: <1702461707-2692-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1702461707-2692-1-git-send-email-kotaranov@linux.microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, kuba@kernel.org, leon@kernel.org, decui@microsoft.com,
 edumazet@google.com, cai.huoqing@linux.dev, pabeni@redhat.com,
 davem@davemloft.net, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Dec 2023 02:01:47 -0800 you wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch allows to assign and poll more than one EQ on the same
> msix index.
> It is achieved by introducing a list of attached EQs in each IRQ context.
> It also removes the existing msix_index map that tried to ensure that there
> is only one EQ at each msix_index.
> This patch exports symbols for creating EQs from other MANA kernel modules.
> 
> [...]

Here is the summary with links:
  - [for-next,v2] net: mana: add msix index sharing between EQs
    https://git.kernel.org/netdev/net-next/c/02fed6d92bad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



