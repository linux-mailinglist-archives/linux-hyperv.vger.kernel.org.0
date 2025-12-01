Return-Path: <linux-hyperv+bounces-7911-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE9C99491
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07EB23462B4
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE16287516;
	Mon,  1 Dec 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdZwhU2a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E4283C8E;
	Mon,  1 Dec 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626593; cv=none; b=cNvfgHA6bk265voHheiw8NFgeklNVFxPZhO+Pu2M8KRuGwz5ss4dip8MVfe/URpgrgVEZDAinZrDCEOe+iF4amdNuLgnw3PO8bk76mwFJRRZyVPOYbP4ailRUjhztjAEF5RbbFNrOYVaWwal1LE/v/xl7lINl7CJi/2IbqJHfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626593; c=relaxed/simple;
	bh=COJX3I7JPxdMQbwBfXX31vKlq5L3/HXH0MQ8yei2Usg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebShwKalbMM3yy3hY1c1woryHtLeajUQraMctFJy+ZtEK88Nml8MAdaZwfLc4ee/i3/OOwxIJtHQe4wMvPRULmb9dt5/EAbH3hMMwNGla8PgbB5ox2PQJkgPDcS1g38j3xRjNQFvDI+z0mC9OLkEJ57gZDTwMkFNKXymfMywkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdZwhU2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946B2C116D0;
	Mon,  1 Dec 2025 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764626591;
	bh=COJX3I7JPxdMQbwBfXX31vKlq5L3/HXH0MQ8yei2Usg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bdZwhU2agBEae/My+f6BJv3Xv6DhHBq8HTxERDP/gWm71KgRpteRvG8NnFTPriUAy
	 +j9TrYKYcC3/e7yNEZNVtVaTyQj9inRYIDk5yzTMCYadMwY6v3WdTnwlXydEMMXrPF
	 VWT8hhv3TGwJRgSKyTO4Ld5fSoNHSNv8cuL5VL2E3WvAZt2nJJVBdrm2kn6JmVyByi
	 LnKYP/Yscti6hhZlLJsYEh2s+4tNNrIKL4d5vN1PHAkXxqXibmvIuODJ2gvdoo8IwS
	 YBLkLZ5Bok21n43CjZtyDvnyEk9oHsXEDI+kaXlrqYrLP3rLBbMQ5DNWmQMjQQqAyz
	 9sraMeUwSRXdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B588E381196A;
	Mon,  1 Dec 2025 22:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net-next v4] net: mana: Handle hardware recovery events
 when
 probing the device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462641145.2561615.8399106632061162779.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 22:00:11 +0000
References: <1764193552-9712-1-git-send-email-longli@linux.microsoft.com>
In-Reply-To: <1764193552-9712-1-git-send-email-longli@linux.microsoft.com>
To: None <longli@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 horms@kernel.org, kotaranov@microsoft.com, schakrabarti@linux.microsoft.com,
 erick.archer@outlook.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, longli@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Nov 2025 13:45:52 -0800 you wrote:
> From: Long Li <longli@microsoft.com>
> 
> When MANA is being probed, it's possible that hardware is in recovery
> mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
> middle of the probe. Detect such condition and go through the recovery
> service procedure.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: mana: Handle hardware recovery events when probing the device
    https://git.kernel.org/netdev/net-next/c/9bf66036d686

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



