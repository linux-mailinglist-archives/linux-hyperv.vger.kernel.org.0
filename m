Return-Path: <linux-hyperv+bounces-6066-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E08EAF0896
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 04:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE07443C4E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jul 2025 02:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D555D1D6DA9;
	Wed,  2 Jul 2025 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6rFgR/U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5621D5ADC;
	Wed,  2 Jul 2025 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424002; cv=none; b=MH/Ge+uXwj5LPiI6cp/dSbmPgHtzNXh/6pf9Rrdz4BidD/KrnJT65Fz2uqvVkhsWHFHMOoapBl+OWj+kJi1nTGeB0jhZ2QODETfGceXCTCff0JNETRcTf+kzPPZp6yGT2kP5J4Y4gLpinRnFTd1uwJVQcG3LEPQZLhMLBsl7d64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424002; c=relaxed/simple;
	bh=BgqoyH7BZAdjNzSV8UuKTMppKfENt1BfB4wMrIRE850=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E0yZcHceAWOht2nfePb1ERffEPqkaLZVC/JOUtWXAyj1z5WU8DAB6PoiCLtYbVT40akQPsHMyHnFTCP0suaLq3B0tpEaDulIVNe86QS2ml+UhGcv/hbKwRcuT77WLN2JyoOkSuSGLBXSmhY4JOOOVaIXru8j4GfrpD7EWebN+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6rFgR/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D83C4CEEF;
	Wed,  2 Jul 2025 02:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751424002;
	bh=BgqoyH7BZAdjNzSV8UuKTMppKfENt1BfB4wMrIRE850=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C6rFgR/UGjtdTidwgGKyZXamMpf13xxwc4hqQbUeb59RuKSpw3puMxppVDXyqEpTN
	 zPI6QNtetzxZMFZ6EOGceVp6GwXgk0jAmnqbhQiX+PsvVENK+zj1q68R5pRdiyquKT
	 KAzefG9sSn07mXu6WThKWjM1lStf2UEWsR4uRuJCPvL42b6duw5S7uJSZe0b5kUjTm
	 XYKMzGx7DxqB8FQZuO9XsuY7DUDEgRpiMGovsATR8HlxkczWxy1HbNrEjESsFNOEZH
	 yp00P7Pn8+k6mw+02UfNMVGx32WXZGIGHbfGRwzGyMwiigJ/EmiTPFXF/nk5fbzkBa
	 ZyeDBn4ThsFDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC6383BA06;
	Wed,  2 Jul 2025 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: Handle Reset Request from MANA NIC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142402700.183540.8619749523804992864.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 02:40:27 +0000
References: <1751055983-29760-1-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1751055983-29760-1-git-send-email-haiyangz@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, decui@microsoft.com, stephen@networkplumber.org,
 kys@microsoft.com, paulros@microsoft.com, olaf@aepfle.de,
 vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 13:26:23 -0700 you wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Upon receiving the Reset Request, pause the connection and clean up
> queues, wait for the specified period, then resume the NIC.
> In the cleanup phase, the HWC is no longer responding, so set hwc_timeout
> to zero to skip waiting on the response.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mana: Handle Reset Request from MANA NIC
    https://git.kernel.org/netdev/net-next/c/fbe346ce9d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



