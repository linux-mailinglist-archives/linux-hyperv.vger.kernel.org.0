Return-Path: <linux-hyperv+bounces-1363-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF35819A7D
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Dec 2023 09:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F91E1F26911
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Dec 2023 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84991C694;
	Wed, 20 Dec 2023 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDYmvX8B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23981C686;
	Wed, 20 Dec 2023 08:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70022C433C8;
	Wed, 20 Dec 2023 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703061014;
	bh=AWahYc/zb4CGXGe14tOMs+KcFUn0xBNBN9JLTLcrIDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tDYmvX8BYrz6Hk2mhzAweehkaxxH+Adho4snNw/4Vzq/9XNeaHrxH+Ux/6w8X1SYW
	 wqaiWK7aeim09ncLSX0UHaR6rbtV8KZb2kQ/L+FAt7soLFQ7+dYXzmg3MAh1+XibX0
	 qJp0N4TbvNoMg/3kyInlONZXNm1Rctk5ebXS9ZB5fG8/plTbVBQRQKbg7SUgMwHSix
	 czxycFQqtPgsMOS6Y8ifKTpTPMq1zMT4//bEaHBBj2ujhXSLHCs/9/SwOMu9cPER4B
	 GYkSFBOz/i3K6Ueq5po6ppvU2fMlg266HHiS6LpP/LMEQjlmcBCJhGp1EJSGG1uVii
	 h3qJaO6Af4fzw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 longli@linuxonhyperv.com
Cc: linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Long Li <longli@microsoft.com>
In-Reply-To: <1702692255-23640-1-git-send-email-longli@linuxonhyperv.com>
References: <1702692255-23640-1-git-send-email-longli@linuxonhyperv.com>
Subject:
 Re: [Patch v4 0/3] Register with RDMA SOC interface and support for CQ
Message-Id: <170306100950.190589.7827009512386066627.b4-ty@kernel.org>
Date: Wed, 20 Dec 2023 10:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 15 Dec 2023 18:04:12 -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> This patchset add support for registering a RDMA device with SoC for
> support of querying device capabilities, upcoming RC queue pairs and
> CQ interrupts.
> 
> This patchset is partially based on Ajay Sharma's work:
> https://lore.kernel.org/netdev/1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com
> 
> [...]

Applied, thanks!

[1/3] RDMA/mana_ib: register RDMA device with GDMA
      https://git.kernel.org/rdma/rdma/c/a7f0636d223ca9
[2/3] RDMA/mana_ib: query device capabilities
      https://git.kernel.org/rdma/rdma/c/2c20e20b22d9fc
[3/3] RDMA/mana_ib: Add CQ interrupt support for RAW QP
      https://git.kernel.org/rdma/rdma/c/c15d7802a42402

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

