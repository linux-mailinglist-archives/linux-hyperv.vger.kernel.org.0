Return-Path: <linux-hyperv+bounces-6175-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C49AFF717
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 04:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D06E561239
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74490280305;
	Thu, 10 Jul 2025 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3hM1Ftc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98A27FD4A;
	Thu, 10 Jul 2025 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115799; cv=none; b=WHQIoOgzrVRar1VlVzHQtk9d6lVHvm9KoRcf2IdepV8wmElIb99A/28fYMJGKSCBN/LX/E+RCiCdb47TG4B3wqTSwoSQbuobRaeV0+t+UyNbX8EoHPsttoTbBfskyGbC+jlBTfJ4B6PerXpqrH4WGzh2aYtJIT0hJcDU1rY4qDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115799; c=relaxed/simple;
	bh=BBG6fmEuZKVJVXAjZ82nwUl8JpitbtZRkzy8Jlxku3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sk0NhC3jr9t4Eg5KxQMn3bDaibUupYpQ7qQfd+oCMrDqz13RJ+aECpMIaaBZtYalrm+2AdX68rorKNHQHmo85sSruW7IL9iKXSK288WSWjClbJTIP+FrfPIDHGtzbsI1eR5qYaSMlwwFsmmB5kwVsVSJC03sqmwLihGRJpdNtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3hM1Ftc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144D4C4CEEF;
	Thu, 10 Jul 2025 02:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115799;
	bh=BBG6fmEuZKVJVXAjZ82nwUl8JpitbtZRkzy8Jlxku3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m3hM1FtcJRdIntqvf5/gO0vmDcvttiggTqgcaxAWRNt6MiqTO/SdC74zVEvGoditx
	 9nr5Yl+Ym0tFcPqIGzAQkycecduW83b5pUoL2LJODpRFgE89UAu9NobM1zy22rTB/V
	 7u6oXtx0gyc4yrcPzANyNhwEUlqrJcmCisDapClo6L35j1flSlyv3JNbSSLCfUDpto
	 fo8FqI18wPBllGqpJ3YxtUy0fu7FBSMyEDFkowx5zd5irdV/oJNgOzqNNv8ZbDGgMZ
	 q5CSv6IQcEIOeTpQurdXcw1p9puRV6CCdAJrwN8Rf9VScy9zCeV5qNUmNwenIGQeMj
	 lSHWgN+ovJMZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7F383B261;
	Thu, 10 Jul 2025 02:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/4] vsock: Introduce SIOCINQ ioctl support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211582149.967127.15893085355857485590.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:50:21 +0000
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
In-Reply-To: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, niuxuewei97@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Jul 2025 14:36:10 +0800 you wrote:
> Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
> bytes.
> 
> Similar with SIOCOUTQ ioctl, the information is transport-dependent.
> 
> The first patch adds SIOCINQ ioctl support in AF_VSOCK.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/4] hv_sock: Return the readable bytes in hvs_stream_has_data()
    https://git.kernel.org/netdev/net-next/c/f0c5827d07cb
  - [net-next,v6,2/4] vsock: Add support for SIOCINQ ioctl
    https://git.kernel.org/netdev/net-next/c/f7c722659275
  - [net-next,v6,3/4] test/vsock: Add retry mechanism to ioctl wrapper
    https://git.kernel.org/netdev/net-next/c/53548d6bffac
  - [net-next,v6,4/4] test/vsock: Add ioctl SIOCINQ tests
    https://git.kernel.org/netdev/net-next/c/613165683d34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



