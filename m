Return-Path: <linux-hyperv+bounces-1345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCFD815F5E
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 14:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A663CB216C3
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 Dec 2023 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EEA44375;
	Sun, 17 Dec 2023 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIuNjv9h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029744368;
	Sun, 17 Dec 2023 13:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49778C433C7;
	Sun, 17 Dec 2023 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702819552;
	bh=ylkP0Dm94uUDf3yvVALYoxZUe7EaLIQ0d83lxLefEUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIuNjv9hrBVuqmVA5anmfzAhDISWcDsG0wjgXPiHzfbJTjtGaRWVvFHndHjbZBEp5
	 lWO+mBBt7paDQETPAIQWrVAFLKynu4btxNZCQHtm1xhGyoQiZSjvSjshpKu9PZRE3o
	 Wj7vmyYCV1OYD8rjKjcXxi45QT2+8gSk+HclvdyoASibPIxrhmDUsVslOORJFF2vcX
	 lhNIwXzkYUfE0Aw1CajRa4cBqM8LASUCWnvgk1KflCAFZdwvlmxFF0k1WsQ1tWZkoh
	 FnDwQ6vmVSSU0txXEwYeMqxNuTjdHWCUGg4/VNWVfA1apgIfEca6L3EfAlPM/8F2yE
	 UjyJErf5FifCQ==
Date: Sun, 17 Dec 2023 15:25:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [Patch v4 0/3] Register with RDMA SOC interface and support for
 CQ
Message-ID: <20231217132548.GC4886@unreal>
References: <1702692255-23640-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702692255-23640-1-git-send-email-longli@linuxonhyperv.com>

On Fri, Dec 15, 2023 at 06:04:12PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> This patchset add support for registering a RDMA device with SoC for
> support of querying device capabilities, upcoming RC queue pairs and
> CQ interrupts.
> 
> This patchset is partially based on Ajay Sharma's work:
> https://lore.kernel.org/netdev/1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com
> 
> Changes in v2:
> Dropped the patches to create EQs for RC QP. They will be implemented with
> RC patches.

You sent twice v2, never sent v3 and two days later sent v4 without even
explaining why.

Can you please invest time and write more detailed changelog which will
include v2, v3 and v4 changes?

Tanks

> 
> 
> Long Li (3):
>   RDMA/mana_ib: register RDMA device with GDMA
>   RDMA/mana_ib: query device capabilities
>   RDMA/mana_ib: Add CQ interrupt support for RAW QP
> 
>  drivers/infiniband/hw/mana/cq.c               | 34 ++++++-
>  drivers/infiniband/hw/mana/device.c           | 31 +++++--
>  drivers/infiniband/hw/mana/main.c             | 69 ++++++++++----
>  drivers/infiniband/hw/mana/mana_ib.h          | 53 +++++++++++
>  drivers/infiniband/hw/mana/qp.c               | 90 ++++++++++++++++---
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  5 ++
>  include/net/mana/gdma.h                       |  5 ++
>  7 files changed, 252 insertions(+), 35 deletions(-)
> 
> -- 
> 2.25.1
> 

