Return-Path: <linux-hyperv+bounces-3132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA9991F5F
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Oct 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713731C2154B
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Oct 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286E513D889;
	Sun,  6 Oct 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFMJtHOI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3926D520;
	Sun,  6 Oct 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228623; cv=none; b=JmhR+mmFCkp5+XTiILPUdFyMPuRH/TZWVV0XzhaVH7UWJMN0xIjwKPRtaqCbcAMBoonnzo3z+2vBPleYWdubfWQbzoktTmUvg0AcVv/t02mc0a9DIwDtQ2CIlCTZILKC9kLWpz0FJosOxnb9rbux8fMtsl1lJEraT3aC3CsX7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228623; c=relaxed/simple;
	bh=7osjnz3x6fGyCNgfs1x2wSRnEILY1nEWjh37pv0qYKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3FuRozO7jW0kHG87bCJ7jF7UE+LkQ+FIt3pBBxE2NMXM0j4oT03QnpnPbjS7tDZHVmEuhC0TfHSBwU1Gc7i6AaA4/BkUgIMlPS10NQprKabh5huLgJJXrXvFL+Xd7zjpYqj6pjgxRqZkB7W1zROdJZbtGFUzIkUQr36uTkPOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFMJtHOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0E3C4CEC5;
	Sun,  6 Oct 2024 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728228622;
	bh=7osjnz3x6fGyCNgfs1x2wSRnEILY1nEWjh37pv0qYKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFMJtHOIwKzV5n+t3NhKWiKCZLNH5PaeXi6gq4r9QgCHV7Uy9EBGTDZEbXdOozWBY
	 fpnxHpjEH/rZkuAMuSHqdpQeUD24Ez5lt/kYfRPqne8q9k+SkCTWpqhiu1unw5lAAG
	 hxkUoa+jAWLu5rQPNUMTNzqKHJM52QxqbZHjwTq//wPwEO5LEMXsRNHAAx+sRCrLwj
	 mjTKzZ/5BxDSpAn7kvCnV1sAbE8bHmnqveOkQbhSn8T/ZVQ8l+rzc8K/ZyD/IBMiDt
	 p+ybpDrPgEeE/dkPu5MA1ilaBKXAHhoc0o32XdsxTAZt9eRtpSmK89ThjxkfcdXYPC
	 dWXbdfRf3urrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3ED3806656;
	Sun,  6 Oct 2024 15:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 0/1] hyperv: Link queues to NAPIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172822862677.3446944.3843359587147988770.git-patchwork-notify@kernel.org>
Date: Sun, 06 Oct 2024 15:30:26 +0000
References: <20240930172709.57417-1-jdamato@fastly.com>
In-Reply-To: <20240930172709.57417-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, horms@kernel.org, davem@davemloft.net,
 kys@microsoft.com, decui@microsoft.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 30 Sep 2024 17:27:08 +0000 you wrote:
> Greetings:
> 
> Welcome to v2.
> 
> This was previously an RFC [1], see changelog below.
> 
> I've only compile tested this series; I don't have the software for testing
> this so I am hoping some one from Microsoft can review and test this
> following the instructions below :)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] hv_netvsc: Link queues to NAPIs
    https://git.kernel.org/netdev/net-next/c/8b641b5e4c78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



