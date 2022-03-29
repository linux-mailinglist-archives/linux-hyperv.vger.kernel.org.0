Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D11E4EB6C5
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Mar 2022 01:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiC2XdF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Mar 2022 19:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbiC2Xcq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Mar 2022 19:32:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482D2B260;
        Tue, 29 Mar 2022 16:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6953CE1BFB;
        Tue, 29 Mar 2022 23:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B770C2BBE4;
        Tue, 29 Mar 2022 23:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648596659;
        bh=olgtT6FewsbbSzY2KR3/opVw6l4AyJdbQzHKvg6cQWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ckJ81WBU0rBsNq8nACQmS7TncLpvlUwXOZcZpTzCy8wbhYywWXvwiC4mieNI+ajQX
         dBjO2hHVpzs+v2SEKW82oz/SSnn1RFx9aeDC/ZoA02wEtOlepMXanXdNgWCtOVfpu8
         kmuGuez58o7uWdfrCabormL4WpvwpunirnBvEUmsqWlJbqrOGlC265o4hNN7Ln2w+H
         2NWJuejngYNrTdyHmuGmZgXwS41JoS+Q+gwyCuVRp4vaIR3BOTJLRhvt1k10+BVT7m
         JGvcHijQNyFJ/oTLOj0RIzLgOY2nvaiMpVedDWrApSM3vyaAZavz0c/CWFl+L8OaSB
         KvIGCKhqhCjhg==
Date:   Tue, 29 Mar 2022 18:30:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        boqun.feng@gmail.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hv: Remove unused function
 hv_set_msi_entry_from_desc()
Message-ID: <20220329233057.GA1643812@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317085130.36388-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Applied to for-linus for v5.18, thanks!

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
