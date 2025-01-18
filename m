Return-Path: <linux-hyperv+bounces-3719-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C930A15B4A
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jan 2025 04:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DDB168FBC
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Jan 2025 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB028137923;
	Sat, 18 Jan 2025 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiqeXDgI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B81F95E;
	Sat, 18 Jan 2025 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172226; cv=none; b=cNowQWu7ndUJgJJ7IYt5Zg8hEWGS2vj71kueoXnbVp1Ru00XvDiUfKcFk2N0YoItEPcVsI7/2lc3Wo65lpw1VlG1xSAH+4MAaFQxiB18NNpIYSYKezfvoJL9YYstkd/5FaRm1SR7TevRa6QhtdWqNXC6gzuYYnfihlviIcG9DQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172226; c=relaxed/simple;
	bh=azCTQUWteNkvbSDmw25Oo2U37v/Fw+cp06WncVB5Hkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RqzrjpdpWkqMosAJW+P0uhU6xo+jlW/8RVeXyAEdKFCBABdKc/N6i113KkuB1t67Vv+J+iFzSYZLIVljfIYqRRz16lvTn5vYr+jCnPKh8Qq791/oFWarRS+vSQrq461AbNpdP9kkqZfXXx7er59PnaoENTVLMTyWCBA8/qyTZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiqeXDgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E051C4CED1;
	Sat, 18 Jan 2025 03:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172226;
	bh=azCTQUWteNkvbSDmw25Oo2U37v/Fw+cp06WncVB5Hkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eiqeXDgISdzuCmjOI1oGSAC9UhmVP5cM/Vg2XXU0lrjnb1uQN4G6CeTiQt/P4Ahuz
	 /uW8SK5G5TRn71l7GbS7dG89E/12npD4k1nXXEiUg8PLz8BsrSTN+pGxMJStzyfpOy
	 gsmLlW0yQQaKWbAFtjm4gPJPwRS45VoR9nEVyU37TPtml72/uKCc8Dz/mvXp5F+V+p
	 SJDrRaAmQWyUOKtjRU2teqm04qR9aIR31WNPLNCW/G9HBXaSiH6X/LEX/yPwCT9RZ/
	 206AoAUXLfwJp6TUnHnKQrNfN7CvVQdHrXZTBHT9S7fzYXpUmbMwrJhXU6F/WXdN6j
	 KucrcveidRdbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE5380AA62;
	Sat, 18 Jan 2025 03:50:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] hv_netvsc: Replace one-element array with flexible array
 member
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173717224924.2330660.9877956855330264065.git-patchwork-notify@kernel.org>
Date: Sat, 18 Jan 2025 03:50:49 +0000
References: <20250116211932.139564-2-thorsten.blum@linux.dev>
In-Reply-To: <20250116211932.139564-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-hardening@vger.kernel.org, romank@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 22:19:32 +0100 you wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct nvsp_1_message_send_receive_buffer_complete.
> 
> Use struct_size_t(,,1) instead of sizeof() to maintain the same size.
> 
> Compile-tested only.
> 
> [...]

Here is the summary with links:
  - [v2] hv_netvsc: Replace one-element array with flexible array member
    https://git.kernel.org/netdev/net-next/c/3df22e751027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



