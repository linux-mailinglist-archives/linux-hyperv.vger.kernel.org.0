Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DFA580C3A
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jul 2022 09:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiGZHQG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jul 2022 03:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiGZHQE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jul 2022 03:16:04 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4765E3
        for <linux-hyperv@vger.kernel.org>; Tue, 26 Jul 2022 00:16:03 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7133E669; Tue, 26 Jul 2022 09:15:59 +0200 (CEST)
Date:   Tue, 26 Jul 2022 09:15:58 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, will@kernel.org,
        robin.murphy@arm.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Message-ID: <Yt+Uro8y219/MNFE@8bytes.org>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Michael,

On Mon, Jul 25, 2022 at 05:53:40PM -0700, Michael Kelley wrote:
> Recent changes to solve inconsistencies in handling IRQ masks #ifdef
> out the affinity field in irq_common_data for non-SMP configurations.
> The current code in hyperv_irq_remapping_alloc() gets a compiler error
> in that case.
> 
> Fix this by using the new irq_data_update_affinity() helper, which
> handles the non-SMP case correctly.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Please add a fixes tag.

Where is the change which breaks this currently, in some subsystem tree
or already upstream?

In case it is still in a maintainers tree, this patch should be applied
there. Here is my

Acked-by: Joerg Roedel <jroedel@suse.de>

for that.

