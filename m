Return-Path: <linux-hyperv+bounces-2887-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BD961A70
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB531C22FDB
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 23:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5091D54C3;
	Tue, 27 Aug 2024 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd2TtpJd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56A1D2F78;
	Tue, 27 Aug 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800835; cv=none; b=tn7ucmJPXHG4CMbneI7km/NuV07/VwUXzUQU90NFg4x2kTGPlD1D3q3vLvOzmPzYbLRlSQsiEG41o3EOvhU9i9XI1jmthyfihjh6M0jkrN9WL0R8qTcOJwxrQobGHZPvxx+L1hhyWc+r6op6gedoH123J9pMGAWP7ekpNHZEXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800835; c=relaxed/simple;
	bh=JqAJyDzkuTQdgzY0EdwWlgQLgQ3Cojco3ZN11kWFADM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aDSsJQeHE+bY6N9CdFumA8QkqmFW9qn9vZS92Zu1WGxD6meU9pKh2CfqZEVwQNedwOz8xErUNbpNUlTPXePwW08tiXb1OToEDx1Kd9NNjOE/f2456b3mbk7T7sccPsa7RESt87RRIVWkxGSOQ4SfE/SxX3naab1Wm2CERF6OOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd2TtpJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCCEC4AF1C;
	Tue, 27 Aug 2024 23:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724800834;
	bh=JqAJyDzkuTQdgzY0EdwWlgQLgQ3Cojco3ZN11kWFADM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jd2TtpJdR/xdN3Jy8gFSEzmF2wnMEmpOPpIjmqWNc/0vtEQVjQFFMYmifM4cgoIL4
	 Z5odPv04JBOsSeInvnok4H80Fwfa9dcbgUIsHSczjUILOaSG+gS0L1m0jamhwBrxBH
	 Uk9PKJmRc19eSnNr2VDb/USDyo9TNBhwrDjSjcs4iIjaVXlHta9hdf05tR47IBns7f
	 EtIpD/nQ0cai6oaISEscq06/uQOj6sqJaRz6vP0d7vtdNXWTyLeICQinkZrNnxbH+o
	 UsJmD3AoMsb1hcYJdifTaeTQA5eDKT+cVezeeGMQIX2cN5j7y6ebOZJmGHyTtl7Ar9
	 3Y4ahOty7Vx6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD83822D6D;
	Tue, 27 Aug 2024 23:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: mana: Implement get_ringparam/set_ringparam
 for mana
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172480083424.787068.16112040114699879400.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 23:20:34 +0000
References: <1724688461-12203-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1724688461-12203-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, horms@kernel.org, kotaranov@microsoft.com,
 schakrabarti@linux.microsoft.com, erick.archer@outlook.com,
 pavan.chebbi@broadcom.com, ahmed.zaki@intel.com, colin.i.king@gmail.com,
 shradhagupta@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 09:07:41 -0700 you wrote:
> Currently the values of WQs for RX and TX queues for MANA devices
> are hardcoded to default sizes.
> Allow configuring these values for MANA devices as ringparam
> configuration(get/set) through ethtool_ops.
> Pre-allocate buffers at the beginning of this operation, to
> prevent complete network loss in low-memory conditions.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: mana: Implement get_ringparam/set_ringparam for mana
    https://git.kernel.org/netdev/net-next/c/3410d0e14f9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



