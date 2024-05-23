Return-Path: <linux-hyperv+bounces-2211-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A98CDB0E
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976901F233BF
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 May 2024 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D3384D0F;
	Thu, 23 May 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7MfGGDv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9A84D03;
	Thu, 23 May 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493603; cv=none; b=qpFCDAIDexZKMIVbISNAxazXiLAyMi+IA9Raa9lHbnd5JQfuCBd8Q1eZRqQ7y1QnvLpKdCKE9VvcBohFCNXy8IRkh7MPeKiTl7RuLOCnOl1XeBZhMOdxAg31begkCHtfKhvbqCgnNX5GmYWKKV1RnLQq6qQARwIJsgf10RYSa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493603; c=relaxed/simple;
	bh=CNMblmqVNA2x8vqn+HiJkT+FDFOXwcL+13QaZX5Oh+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd+nTGrCtxl5nwEdtH7fI54Dg/B+KgVFne3cuaKgeWToC/SL4G4D5QQ8l6Ee0dTHu9JUvVOObc4dJvNy3Rn8BYlsuO++S+MjVNq9b/FrNJFl2j3Cf8shqLH2WBswOhGczf46kVSf2lwEIUQ1gSKzv85pvy2k30VxHh+ZF2Ho/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7MfGGDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C586CC32789;
	Thu, 23 May 2024 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716493602;
	bh=CNMblmqVNA2x8vqn+HiJkT+FDFOXwcL+13QaZX5Oh+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N7MfGGDv43k//EXXxDaT78UMClX9z4BWj3Ah8Prrtroqda09n9OB3crXWwaAlSbjd
	 ET2oo3+E7EC2OE2LH/IA4tRjZesCZIKUnemd8/5eDmN1Y6DNCa2EdT0M8sHuLKDU4J
	 Wj1tbDCh1fPeDgFhEGrJCgeI0vkLLcEdywgUNmFS8ZIVPLOMlr3repCghGPDR70+u1
	 3FPhWDZZZPMICnM/HRXS60bG7rRSt/EE80dcdJ/8HXndkHKtpNz9vebf4OUUgbxHTY
	 T3WrEBDxK47O4/gGcmh+/qmSnSEXFjVnUi44z1c0PCe7xnhGExc1dqxuCZmQP5HNcs
	 UvR2sAI/P50HQ==
Date: Thu, 23 May 2024 12:46:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Kees Cook <keescook@chromium.org>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Jason
 Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>, Long Li
 <longli@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Allow variable size indirection
 table
Message-ID: <20240523124640.40ccd9f8@kernel.org>
In-Reply-To: <1716483314-19028-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1716483314-19028-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 09:55:14 -0700 Shradha Gupta wrote:
> Allow variable size indirection table allocation in MANA instead
> of using a constant value MANA_INDIRECT_TABLE_SIZE.
> The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> indirection table is allocated dynamically.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

## Form letter - net-next-closed

The merge window for v6.10 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


