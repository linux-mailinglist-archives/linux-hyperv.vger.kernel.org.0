Return-Path: <linux-hyperv+bounces-3825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E889A258DF
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2025 13:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA2C1885B32
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2025 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4371320409D;
	Mon,  3 Feb 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGIZjGh1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC6C20371E;
	Mon,  3 Feb 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738583817; cv=none; b=HFmR+9U/CMQL5cbQ5A8y1eowoTYs6zac/xhQj5liOAPnFD5ipBr0oacdn9JvneoDWGb6Czmzpq3MnSt3iUS4U0Pk4SECsRGu3nb+W6IElE4xr8tRk6tdch27gL1PF0+9K98iGK/8KhhSx7ROqkxDGb8kXauRwJqXEKSkQAE4deM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738583817; c=relaxed/simple;
	bh=vebKXFPzIRoJk3TKQHgf/1dguJDhSsqhc+ZH4Sn0iuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qLqRDAxlfDQvL3KOaB5wBbV2sRjhUMf+O55twnJGddwsqyBvSqPzYc2YgELS8Qx8rQcJdxycaTKbDM2SEcNtIr4ymiewKjJPqfiESXfpP68VNUTbVl//s4APIuQxNKeKmfzPRalpe79YWehBzze1K2hIN4PX9bamntJ22FZdMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGIZjGh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB5C4CEE5;
	Mon,  3 Feb 2025 11:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738583816;
	bh=vebKXFPzIRoJk3TKQHgf/1dguJDhSsqhc+ZH4Sn0iuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RGIZjGh1XtgX1j6PhCyq8QgOyVjXMUFN99V8NrxjpT25j7JNshg+fbjtNuZVGZ7+K
	 TOZIwCGWIEivL3Hj80bXGfQDO852zKkC5atuLS1Lvs97JF83x+BffXjRLzs32w4Jk9
	 oJbRqeeWDWTzaL6Y1bGvywopigueIsd+76Ofdt8URW7YpUCWlLaZ6ktx4kaMHRl4DD
	 mHwsKapAEdQknaorXVRuZm07jDR0y8owh+3dt0S8QZgiZaTAL+3+uAVZFYkDYVx447
	 AbXK1AVltKKE/RLipc1v23tkNgiQpiKpH5QlO1VVC9XqrrhvZ6/+NrRcidIDhAfb+E
	 pPVxZ3fX7TujQ==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, shirazsaleem@microsoft.com, pabeni@redhat.com, 
 haiyangz@microsoft.com, kys@microsoft.com, edumazet@google.com, 
 kuba@kernel.org, davem@davemloft.net, decui@microsoft.com, 
 wei.liu@kernel.org, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 00/13] RDMA/mana_ib: Enable CM for mana_ib
Message-Id: <173858381321.653438.2087352921783439879.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 06:56:53 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 20 Jan 2025 09:27:06 -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series enables GSI QPs and CM on mana_ib.
> 
> Konstantin Taranov (13):
>   RDMA/mana_ib: Allow registration of DMA-mapped memory in PDs
>   RDMA/mana_ib: implement get_dma_mr
>   RDMA/mana_ib: helpers to allocate kernel queues
>   RDMA/mana_ib: create kernel-level CQs
>   RDMA/mana_ib: Create and destroy UD/GSI QP
>   RDMA/mana_ib: UD/GSI QP creation for kernel
>   RDMA/mana_ib: create/destroy AH
>   net/mana: fix warning in the writer of client oob
>   RDMA/mana_ib: UD/GSI work requests
>   RDMA/mana_ib: implement req_notify_cq
>   RDMA/mana_ib: extend mana QP table
>   RDMA/mana_ib: polling of CQs for GSI/UD
>   RDMA/mana_ib: indicate CM support
> 
> [...]

Applied, thanks!

[01/13] RDMA/mana_ib: Allow registration of DMA-mapped memory in PDs
        https://git.kernel.org/rdma/rdma/c/78683c25c80e54
[02/13] RDMA/mana_ib: implement get_dma_mr
        https://git.kernel.org/rdma/rdma/c/6e1b8bdcd04f4e
[03/13] RDMA/mana_ib: helpers to allocate kernel queues
        https://git.kernel.org/rdma/rdma/c/f662c0f5b3396a
[04/13] RDMA/mana_ib: create kernel-level CQs
        https://git.kernel.org/rdma/rdma/c/822d4c938e0d93
[05/13] RDMA/mana_ib: Create and destroy UD/GSI QP
        https://git.kernel.org/rdma/rdma/c/392ed69a9ac45c
[06/13] RDMA/mana_ib: UD/GSI QP creation for kernel
        https://git.kernel.org/rdma/rdma/c/bf3f6576bbbd51
[07/13] RDMA/mana_ib: create/destroy AH
        https://git.kernel.org/rdma/rdma/c/09ec8a57903348
[08/13] net/mana: fix warning in the writer of client oob
        https://git.kernel.org/rdma/rdma/c/622f1fc2ca7dea
[09/13] RDMA/mana_ib: UD/GSI work requests
        https://git.kernel.org/rdma/rdma/c/8d9a5210545c27
[10/13] RDMA/mana_ib: implement req_notify_cq
        https://git.kernel.org/rdma/rdma/c/cd595cf391733c
[11/13] RDMA/mana_ib: extend mana QP table
        https://git.kernel.org/rdma/rdma/c/9fe09a01ade76d
[12/13] RDMA/mana_ib: polling of CQs for GSI/UD
        https://git.kernel.org/rdma/rdma/c/4aa5b050800325
[13/13] RDMA/mana_ib: indicate CM support
        https://git.kernel.org/rdma/rdma/c/842ee6aeddff08

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


