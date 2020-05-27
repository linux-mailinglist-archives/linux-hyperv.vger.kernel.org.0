Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD11E428B
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2020 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgE0Mja (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 May 2020 08:39:30 -0400
Received: from 8bytes.org ([81.169.241.247]:44968 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729919AbgE0Mj3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 May 2020 08:39:29 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 82F30247; Wed, 27 May 2020 14:39:25 +0200 (CEST)
Date:   Wed, 27 May 2020 14:39:24 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] drivers/iommu: Constify structs
Message-ID: <20200527123923.GJ5221@8bytes.org>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 25, 2020 at 11:49:56PM +0200, Rikard Falkeborn wrote:
> Constify some structs with function pointers to allow the compiler to
> put them in read-only memory. There is not dependency between the
> patches.
> 
> Rikard Falkeborn (2):
>   iommu/hyper-v: Constify hyperv_ir_domain_ops
>   iommu/sun50i: Constify sun50i_iommu_ops
> 
>  drivers/iommu/hyperv-iommu.c | 2 +-
>  drivers/iommu/sun50i-iommu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied both, thanks.
