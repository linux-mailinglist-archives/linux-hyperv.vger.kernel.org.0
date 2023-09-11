Return-Path: <linux-hyperv+bounces-23-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F279A7ED
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Sep 2023 14:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6831C208E5
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Sep 2023 12:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB7CC134;
	Mon, 11 Sep 2023 12:32:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196E3D65;
	Mon, 11 Sep 2023 12:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCC9C433C8;
	Mon, 11 Sep 2023 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694435555;
	bh=12rjUtL5HEALdRFSuOzsv77FTRX5QNcc0RqwVBBnWoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0oZM60k7f/1FvtAP/Ch5Zd8Hfm3Xgwn+THG3BoogI5AgzXnPyRefUfmSWU09ik8A
	 TjWeOmQtJUaGvclbftnB0myTWnZOfU4E0v/geoSc5dHl+qjJck3yp82c1VF6z+eMcg
	 IMUaPBuwBfLv+wB0L71t5HU0xuMqIhkklhWrn+vaqw0+d1DcX8H/Npal9P+gHu51PB
	 74EpqWF55XGa7jtfWunCE0I/aQK5qa4VV2KdOYsxbm5Vvgh5GQdHnDxq3Crh5zP5xa
	 bJKIeSBoyJoRiwSVgu7JwcWtgi3+UtN2eVz53UJHonDrH+z3LONWVk50xDwz8dwR/D
	 fo6CFpLC5Ks3g==
Date: Mon, 11 Sep 2023 15:32:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: sharmaajay@linuxonhyperv.com
Cc: Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v5 0/5] RDMA/mana_ib
Message-ID: <20230911123231.GB19469@unreal>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>

On Thu, Sep 07, 2023 at 09:52:34AM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> Change from v4:
> Send qp fatal error event to the context that
> created the qp. Add lookup table for qp.
> 
> Ajay Sharma (5):
>   RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
>   RDMA/mana_ib : Register Mana IB  device with Management SW
>   RDMA/mana_ib : Create adapter and Add error eq
>   RDMA/mana_ib : Query adapter capabilities
>   RDMA/mana_ib : Send event to qp

I didn't look very deep into the series and has three very initial comments.
1. Please do git log drivers/infiniband/hw/mana/ and use same format for
commit messages.
2. Don't invent your own index-to-qp query mechanism in last patch and use xarray.
3. Once you decided to export mana_gd_register_device, it hinted me that
it is time to move to auxbus infrastructure.

Thanks

> 
>  drivers/infiniband/hw/mana/cq.c               |  12 +-
>  drivers/infiniband/hw/mana/device.c           |  81 +++--
>  drivers/infiniband/hw/mana/main.c             | 288 +++++++++++++-----
>  drivers/infiniband/hw/mana/mana_ib.h          | 102 ++++++-
>  drivers/infiniband/hw/mana/mr.c               |  42 ++-
>  drivers/infiniband/hw/mana/qp.c               |  86 +++---
>  drivers/infiniband/hw/mana/wq.c               |  21 +-
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
>  include/net/mana/gdma.h                       |  16 +-
>  10 files changed, 545 insertions(+), 258 deletions(-)
> 
> -- 
> 2.25.1
> 

