Return-Path: <linux-hyperv+bounces-3188-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA289AE308
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2024 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D41F2302B
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1141C0DE2;
	Thu, 24 Oct 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omRk4Lks"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73F14831C;
	Thu, 24 Oct 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767030; cv=none; b=gxILnMLAr8+/qF6bn5yygY6m6fEt0hnlRi2jF5T/dmzwdJLmzuhbrPX5bV30YBZJ5gSoBI6FTdPyWWHOlDMR3SbSjcCQBiuv12SdpnDmPkO4cIzAXprY4fA2xRsdgGiQiDwbCDr6uVHRhAFFyW42zsjEPMLOuNoN6EiFEkCJIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767030; c=relaxed/simple;
	bh=VZe0fKnl1yN3UZ2hnTaLC+QemnvFSVsvHOx2vfdvxuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TjiMuY4b7XnJcHEFr7v9QDsqwF4+3/L68S2Dfrx7rXW/IceZn8GrPhKGdccRtmxGA3fW6pyQQe1P2tCK1DrMAiDxPzk7vEaOICk2lrSvmLufeGodhn0Z7y777rZbqyBisis0D7W55vJtEj9YbD8Easjv9wuH9VzzQZfuh4SbTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omRk4Lks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6728C4CECC;
	Thu, 24 Oct 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767029;
	bh=VZe0fKnl1yN3UZ2hnTaLC+QemnvFSVsvHOx2vfdvxuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=omRk4LksKRf3/UXisvC0dADy391ZzeiZPGfGSetPluzDqXzffkIBZgWA1fiyl598M
	 JlZxlm+wlMNvkA/BH5GAE7OF35KvvWmELGBJ3uT5/RzjtBxLbrVx/K37AEwxjTNhRw
	 biTpcOY0xFWN6jc/ZmiucmQj5sHw564Stv5YYMFFzSeOHufSTXiNVL5D0AMr/FNZ7Z
	 w7rS0/ywQqb02BciRbr9o+CKHsaKzHAjF5WsHXyEMhylbFROEv94bWHFeM6YMdH3Dm
	 sbdtgs+UJF9t/FF+vaIAIWjz04T0kYhzO5v8CksVDjB3QC/UvFw2V73p8u3BO0aV9L
	 ha2mwmxgUoVMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E78380DBDC;
	Thu, 24 Oct 2024 10:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v3] hv_netvsc: Fix VF namespace also in synthetic NIC
 NETDEV_REGISTER event
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172976703602.2195383.3298909892256176154.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 10:50:36 +0000
References: <1729275922-17595-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1729275922-17595-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, stephen@networkplumber.org,
 davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 11:25:22 -0700 you wrote:
> The existing code moves VF to the same namespace as the synthetic NIC
> during netvsc_register_vf(). But, if the synthetic device is moved to a
> new namespace after the VF registration, the VF won't be moved together.
> 
> To make the behavior more consistent, add a namespace check for synthetic
> NIC's NETDEV_REGISTER event (generated during its move), and move the VF
> if it is not in the same namespace.
> 
> [...]

Here is the summary with links:
  - [net,v3] hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event
    https://git.kernel.org/netdev/net/c/4c262801ea60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



