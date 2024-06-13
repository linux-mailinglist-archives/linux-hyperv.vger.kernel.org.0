Return-Path: <linux-hyperv+bounces-2412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C48907FE8
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F811F22926
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2024 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B614D71E;
	Thu, 13 Jun 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lleNsJm7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044280624;
	Thu, 13 Jun 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322631; cv=none; b=kC5MMyqIdw9Dbb4BIm5ZF/fVeChHiM4zw/chcK62f8CI9HfwALJNMdd1dBWcfyPKc4a73uDV3jvabQu49D41DFudVB28wiZIs8cnI1waf6c0TqP6CWSJoLj3X9ZDEDjNy5Ph8t7nrHuKgtPnu75i6oGmzbnY6yyoxeR5FX9ETiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322631; c=relaxed/simple;
	bh=9Rwb9V89e521vCos4JoUPsTmonIgE7LjwTwvWYKkfsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R6JL3T32dpiRhBsyFHCYh9e9gcZrvsNuvxo4GwXNhWw5gD5Kb6gycXBtEtNpKYWfAtXKmz3dbtRQY2bRbqFZw0EdI5MWch+RcuZpw3j+EC+ZpKmnRd+0ix6Jm5AdCef9NzU8lXvLriiXEMJZHOSGy4/d99Ipo+4hjIiMz62+WJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lleNsJm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3915C4AF1A;
	Thu, 13 Jun 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718322630;
	bh=9Rwb9V89e521vCos4JoUPsTmonIgE7LjwTwvWYKkfsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lleNsJm722b8c7cL9urUpRTpFkcGroOwytrJTkgBdm84yhj46kL+T5x34yiqb9TnE
	 IMhgD4yYgG0sj92nJLm+yw8qVz0BpN+Gd0xK3IOVbkAai3Cc+JlRS+/+l+4gwOugJs
	 M3tGLjmn9l4etsHDK1cqTF3UZkM82FUxYZDiSaHdZDl/dxFz1BlpkfJFKnFAwVrsYr
	 DSWJojpLt5kvOEnXsB4n11naVBPQO4T3sryCYVxF7hU7+ejdEzR4/JXh7oAw81ix3l
	 yQc1QQaKP99M3mAMGzcCQuE1Kosn4n/aaDYvv8M3unyVxKyT1z4L6X6XyzVI1F11zu
	 Yg7s1fviSoxsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A27F5C43619;
	Thu, 13 Jun 2024 23:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: mana: Allow variable size indirection table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171832263066.32226.1051481550894111174.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 23:50:30 +0000
References: <1718015319-9609-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1718015319-9609-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, colin.i.king@gmail.com, ahmed.zaki@intel.com,
 pavan.chebbi@broadcom.com, schakrabarti@linux.microsoft.com,
 kotaranov@microsoft.com, keescook@chromium.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, leon@kernel.org, jgg@ziepe.ca, longli@microsoft.com,
 shradhagupta@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Leon Romanovsky <leon@kernel.org>:

On Mon, 10 Jun 2024 03:28:39 -0700 you wrote:
> Allow variable size indirection table allocation in MANA instead
> of using a constant value MANA_INDIRECT_TABLE_SIZE.
> The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> indirection table is allocated dynamically.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: mana: Allow variable size indirection table
    https://git.kernel.org/netdev/net-next/c/7fc45cb68696

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



