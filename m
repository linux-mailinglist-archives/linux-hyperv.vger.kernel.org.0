Return-Path: <linux-hyperv+bounces-6277-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C877FB08FE4
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 16:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18559A45ED6
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CB2F9499;
	Thu, 17 Jul 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f09aUh1G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39D2F9497;
	Thu, 17 Jul 2025 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763810; cv=none; b=tQSk8fqKuhRUWTGrJ6RcitK7YPDa8qGCiR2/qsK5s5T9+VkytOsLmLth5Ui1gdkBu+iX2nOOFXFZN1oP4OBf7tCbK4ZXyPu6Q2U8yeIVbGKWDq+dlDx8mEelqfT0D9p8Fgo+94S3VvqYNzJ9/fGk7yXu5WpYFPOzZwflmuWJoGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763810; c=relaxed/simple;
	bh=vWyQJHUOzV1MpPMbxli/i1xxas1uvgGB5zwciL1fqKc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iepRsCX6lx5XemfJaMRv3NXpGnLWXRwIqFvYTiHz0ho+Uryap2IC9ooexPTbOgdTV36i2dslRLNXOLButPGlgaZRb20n5uo6RHN+CfXcCb3e0E3QhlGOn4u1O8XExs59BTlBWLNuv4qHLvVFSzwEjv0qPf7qum/uHsbpnYbYLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f09aUh1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A264BC4CEE3;
	Thu, 17 Jul 2025 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763809;
	bh=vWyQJHUOzV1MpPMbxli/i1xxas1uvgGB5zwciL1fqKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f09aUh1GUvjPCxEcm3r2HPbLVOca9XOGyG7lmrIWwXPUKbQZLqJhHikG5HNDA4p+2
	 GlIPvjsI3xaIN+titFTw8k6bKXLOXBBTKSbcW+xppaoEpLr1I61VXTW8tpW9T9eWBT
	 7zEMfJU2yUaAvzfs1VXhwv7PNFJksosDzpdwRLCz+erLNtVGpf8ES97OtcSAnp3Wwn
	 9oU1clHaPo9+hIdYk+JOYSWps77ABS8grbPhkhdISleT58ThC+P6NBYmReR8efLreu
	 2QjYBoB6qVPXGU7NAczlX3Cqk9V7eJUMBZITPZdpHfkWHrHZ/FlmNeM75CiuFpwLaI
	 NoCGnGz88UbDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7A383BF47;
	Thu, 17 Jul 2025 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before
 open to prevent IPv6 addrconf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276382950.1959085.7504024045631289038.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:50:29 +0000
References: <20250716002607.4927-1-litian@redhat.com>
In-Reply-To: <20250716002607.4927-1-litian@redhat.com>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
 stephen@networkplumber.org, longli@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 08:26:05 +0800 you wrote:
> Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit under Fixes added a new flag change that was not made
> to hv_netvsc resulting in the VF being assinged an IPv6.
> 
> Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> Suggested-by: Cathy Avery <cavery@redhat.com>
> Signed-off-by: Li Tian <litian@redhat.com>
> 
> [...]

Here is the summary with links:
  - [v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
    https://git.kernel.org/netdev/net/c/d7501e076d85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



