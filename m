Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1851A4E8410
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Mar 2022 21:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiCZUOG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 26 Mar 2022 16:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiCZUOF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 26 Mar 2022 16:14:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5553F241B52;
        Sat, 26 Mar 2022 13:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3E10B80B62;
        Sat, 26 Mar 2022 20:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8004C340E8;
        Sat, 26 Mar 2022 20:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325545;
        bh=v0VAvn6gKBj9/RPPOmu/NqjulhFIIDZa7vr43mHc5ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NT1ygPvfLzr/A+BcnpYcb6ApuaMLzweEQ1v+2nlucZueDlfj9jt4TxKVyrFmca+yH
         /xsuw2s/i/Rv9iJcAtHv/nI1SfOFAxR3T36kOwYqcESCEkBT6JAsK1YSGFUBnXpROu
         RcIH7blHpaA3KItQMsroV7FBt1faWEn7uqN735xzVkIyps0q7U5MtRFCfb2tkj0uts
         JBwMXlg+Uev2xy+XjQMeSFYQynQCQU/J1n+mFtCgDOk+vEAF0SZ8Zs9vId4FC1PsHI
         Wz7aej5f/lbbcRRSkiMEKrZnuN1BsWR12VK4CxHMLvgWuRzbO00JQZDU2t9Go7lTZN
         pRUVanDQ2B6fw==
Date:   Sat, 26 Mar 2022 13:12:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        boqun.feng@gmail.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hv: Remove unused function
 hv_set_msi_entry_from_desc()
Message-ID: <Yj9zooV4TO8tZr9f@dev-arch.thelio-3990X>
References: <20220317085130.36388-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317085130.36388-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 17, 2022 at 04:51:30PM +0800, YueHaibing wrote:
> This patch fix the following build error:
> 
> drivers/pci/controller/pci-hyperv.c:769:13: error: ‘hv_set_msi_entry_from_desc’ defined but not used [-Werror=unused-function]
>   769 | static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> 
> On arm64 hv_set_msi_entry_from_desc() is not used anymore since
> commit d06957d7a692 ("PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64").
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

This build breakage is now in mainline, can it please be picked up in a
timely manner?

> ---
>  drivers/pci/controller/pci-hyperv.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index df84d221e3de..558b35aba610 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -766,14 +766,6 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
>  	return irqd->parent_data->hwirq;
>  }
>  
> -static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> -				       struct msi_desc *msi_desc)
> -{
> -	msi_entry->address = ((u64)msi_desc->msg.address_hi << 32) |
> -			      msi_desc->msg.address_lo;
> -	msi_entry->data = msi_desc->msg.data;
> -}
> -
>  /*
>   * @nr_bm_irqs:		Indicates the number of IRQs that were allocated from
>   *			the bitmap.
> -- 
> 2.17.1
> 
> 
