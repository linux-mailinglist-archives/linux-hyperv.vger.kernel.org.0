Return-Path: <linux-hyperv+bounces-7475-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D2C4256B
	for <lists+linux-hyperv@lfdr.de>; Sat, 08 Nov 2025 04:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC7E18832A3
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Nov 2025 03:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5802D739F;
	Sat,  8 Nov 2025 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4P3ihaQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065B258EF5;
	Sat,  8 Nov 2025 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570861; cv=none; b=klOrTddYxQPR2DejFl5Ic4xp715sA/xofn+/B1InPSlWjqvUhYkH8aKmVHg7USuLx8xpx4ZjG37MrIKj8ySUgFo4iBX2HERewfdlJH8EL8H/iIAVZkA4AKZyBo6mxv1qhxtCicyAO9P0cSTOazHkZp8Wx+2kMkOoWH3Edo180ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570861; c=relaxed/simple;
	bh=vxdNXH57C9w1M2OkY45LeSU26Hq2p55YcG6tRkp4xnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=as0+ycmyP6YXMjKo2hg1BCbA53MrQJV4aDGtUXzkxAPszbbStJvJ2c11ye3Pt6C/3d8zbiQw+MnSUgFh1LoYvHDpfEWr6L7okR8nu2TI31KRtteEnzKUgnxmu8clgUMiZBGhfN50OdaRNRxazuCpt+L2vmds28UReXag9hEJ/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4P3ihaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C807C4CEF7;
	Sat,  8 Nov 2025 03:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762570861;
	bh=vxdNXH57C9w1M2OkY45LeSU26Hq2p55YcG6tRkp4xnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p4P3ihaQXJUMgOCRFLDWAyJcvj3QUnTJnxqzp3HIxBmuLN36TTL/5SikPA55efjIz
	 1EGo8JheZWnikuyHlJ3DVZQR7e73trMacpiYHbObkDj27MuIgk4IuYI4JSkEMhToYc
	 +NzfeelgaBahZFm9gaAJYdk/xUZKNQVDLDxtsxM1R06siF//KicRPgobGYAEVQZ8hF
	 RI8DfoeCGUlTx6UV+ohdtGRIuZ8RZduAtrdCNz61jUKkSsweU+BHTDhCJqIW+9GAic
	 ISBj2r6lHNyA5xoCes2GlUjf+F/Uzyf11hssMdyKnSAYj7Y5fcp1fgx0bcuJTE7DI9
	 feHi/AanyfNYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7E3A40FCA;
	Sat,  8 Nov 2025 03:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: mana: Fix incorrect speed reported by
 debugfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257083299.1232193.3554184058724318559.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:00:32 +0000
References: <1762369468-32570-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1762369468-32570-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 kotaranov@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Nov 2025 11:04:28 -0800 you wrote:
> Once the netshaper is created for MANA, the current bandwidth
> is reported in debugfs like this:
> 
> $ sudo ./tools/net/ynl/pyynl/cli.py \
>   --spec Documentation/netlink/specs/net_shaper.yaml \
>   --do set \
>   --json '{"ifindex":'3',
>            "handle":{ "scope": "netdev", "id":'1' },
>            "bw-max": 200000000 }'
> None
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: mana: Fix incorrect speed reported by debugfs
    https://git.kernel.org/netdev/net-next/c/140039580efa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



