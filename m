Return-Path: <linux-hyperv+bounces-5963-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05907AE074E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E214A4058
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 13:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE7D270EDD;
	Thu, 19 Jun 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgp6q+17"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7426E701;
	Thu, 19 Jun 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339787; cv=none; b=QhaT8tox+GPzZ8JynUqY9jLVBHIqEfkZ2yZjapTr5HV1T2RHx5swkiR1lfpu6UZPwG4ttDJwHwB8UWVnreLHL3ITyOu0/0LGeQmU7htDJ32XK4ArctD6i6YerLt6CnF9F2oBpSHynvg7mIjwFOCm4h7bQNLJwo3PdkrYNjsem8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339787; c=relaxed/simple;
	bh=FaMfLH+zASWj6RQ2hfI5lxo04Guv62Z/Oj3reFGID6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bcqxkTLA/liQRXQIhGiOyiwIdUu+AzZtt9vSgSVi1/BcSJTkc/l2TjMBjLMRFgtrmEnptmgBjVqNsUbHhYulDTX/9RRkxEJ5sdeCzyXWVgJQS2F+QtvmvjJnOPCgVRtxiWQ9fz0OfZGj9yTT7CVmjehGLazrV4giY6dIei17POw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgp6q+17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED8FC4CEEA;
	Thu, 19 Jun 2025 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750339786;
	bh=FaMfLH+zASWj6RQ2hfI5lxo04Guv62Z/Oj3reFGID6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tgp6q+17JO7gmCqulFeQTWGjy53/mM83Op7i2WiL38PoMcFsaxlK91mZmWEpFKhpH
	 Rqc6AvNyRD4l7uhZOmFG8BVaO+lo5HnKxOHDAwGYBK1aLJ7QZTSOqfCFJ2LEQvrWf4
	 fD0G1iSEi1e1deqHQpcdqhFQAiFOZN3xkB722n4qkz5pGP9gb56hnxYqQDGzSDsH58
	 SjlOonL0RJ2x0WI08hNbGBUJZZy+NDf0zMtw00+YhH3cMSxquhhjh45tZk3eTXAcVw
	 ko/G2M6KaznyZ4IgJ8hY/BryS7eO/UJLtwlnO49XPRPllxvKt9lMpwVs5b8DHwqmAa
	 nvMte+Ea2CE5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC943806649;
	Thu, 19 Jun 2025 13:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] Support bandwidth clamping in mana using
 net
 shapers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175033981475.865029.2634804125287393920.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 13:30:14 +0000
References: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shirazsaleem@microsoft.com, leon@kernel.org,
 shradhagupta@linux.microsoft.com, schakrabarti@linux.microsoft.com,
 gerhard@engleder-embedded.com, rosenp@gmail.com, sdf@fomichev.me,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Jun 2025 00:17:32 -0700 you wrote:
> This patchset introduces hardware-backed bandwidth rate limiting
> for MANA NICs via the net_shaper_ops interface, enabling efficient and
> fine-grained traffic shaping directly on the device.
> 
> Previously, MANA lacked a mechanism for user-configurable bandwidth
> control. With this addition, users can now configure shaping parameters,
> allowing better traffic management and performance isolation.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net: mana: Fix potential deadlocks in mana napi ops
    https://git.kernel.org/netdev/net-next/c/d5c8f0e4e0cb
  - [net-next,v3,2/4] net: mana: Add support for net_shaper_ops
    https://git.kernel.org/netdev/net-next/c/75cabb46935b
  - [net-next,v3,3/4] net: mana: Add speed support in mana_get_link_ksettings
    https://git.kernel.org/netdev/net-next/c/a6d5edf11e0c
  - [net-next,v3,4/4] net: mana: Handle unsupported HWC commands
    https://git.kernel.org/netdev/net-next/c/ca8ac489ca33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



