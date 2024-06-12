Return-Path: <linux-hyperv+bounces-2405-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41CC905AE9
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 701BEB2228D
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC45844C94;
	Wed, 12 Jun 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcN1LmqV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3632904;
	Wed, 12 Jun 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217056; cv=none; b=QMpC2AnTN94zW2MQLUZIBZCdIOYlWjeP/tJwCQdmwHt22HiZNdkLFDWn0sba0hbjIXC4AqTubKTS6Inaix5+xZWYsUHGqfXawmeTQg7Icjh/S4ZxAL+b75gBqxUFUcSZ98dPtbJkhQneM8kByNe1+S8nmPwEemriTXGL4dv8Q2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217056; c=relaxed/simple;
	bh=e3QzXrAaU67B/41FElb0xb11by+jePMPQ9A+1cBeILs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDAKUX/4gGxufVdPuVUrMYOXA0N+h6jWw9JdwbF3w5uAotapO8h5BWuyZcYKGgX3+9V87oaRHUTXPtt4Xo08mPPlJ0UM2VCe9hbPkOC/DCiqJ5ZLW2T/mki/+WBKUVkAqOCb9cxntBQCHNt2EHU6j04egvL89C//Z6bdxxkVCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcN1LmqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA306C116B1;
	Wed, 12 Jun 2024 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718217056;
	bh=e3QzXrAaU67B/41FElb0xb11by+jePMPQ9A+1cBeILs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcN1LmqVDCujeGcsZoS9HdgBzlkuVNCDq07GI+9cpH8K5pC1eVzYA0EJ1U+5Us3S6
	 8XS6xBsIILjM86ioB0/3ul9dJdGy3rwr7nHauYBjgGCgr8BPYWtxh3zJgc1oZTxbaY
	 uUuFBemjxteVBFqOxC30bM9JizYIgAFgmgfj9fUE+C5nY0PYGVpMzFcw+C3fvvr+hz
	 +6oKQKeBrB2U3zhHGXnsLjgs9PCMOHkX4PdmiR41VkKu5Jez/H/cOWI+tXr3B/GXkc
	 LMpXgSRf+g6u/4EfHaLitBTwNO+7XigGtjyoYl5WY/+f9wL/CDHIqaI5Mrc9zDgwFF
	 o2pqi914O6sqw==
Date: Wed, 12 Jun 2024 21:30:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Kees Cook <keescook@chromium.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v4] net: mana: Allow variable size indirection
 table
Message-ID: <20240612183051.GE4966@unreal>
References: <1718015319-9609-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718015319-9609-1-git-send-email-shradhagupta@linux.microsoft.com>

On Mon, Jun 10, 2024 at 03:28:39AM -0700, Shradha Gupta wrote:
> Allow variable size indirection table allocation in MANA instead
> of using a constant value MANA_INDIRECT_TABLE_SIZE.
> The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> indirection table is allocated dynamically.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v4:
>  * Skip NULLify after free
>  * Log proper errors in mana_probe() if mana_attach(), mana_probe_port()
>    fails
>  * Implement mana_cleanup_indir_table() to avoid code duplication.
> 
>  Changes in v3:
>  * Fixed the memory leak(save_table) in mana_set_rxfh()
> 
>  Changes in v2:
>  * Rebased to latest net-next tree
>  * Rearranged cleanup code in mana_probe_port to avoid extra operations
> ---
>  drivers/infiniband/hw/mana/qp.c               | 10 +--
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 85 ++++++++++++++++---
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 27 ++++--
>  include/net/mana/gdma.h                       |  4 +-
>  include/net/mana/mana.h                       |  9 +-
>  5 files changed, 104 insertions(+), 31 deletions(-)

Hi Jakub,

Like we talked, I created new shared branch for this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=mana-shared

Because it took time, the base of this branch is v6.10-rc3 as I'm eager
to get the commit c9d52fb313d3 ("PCI: Revert the cfg_access_lock lockdep mechanism")
from Linus's master, and this shared patch gives me the reason to pull
the fix.

I see that your net-next didn't get -rc3 tag yet, so please pull it after you
advance net-next. After that I'll do the same in RDMA tree.

Thanks

