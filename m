Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C015E5813E0
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jul 2022 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiGZNJR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jul 2022 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiGZNJO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jul 2022 09:09:14 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A72315A;
        Tue, 26 Jul 2022 06:09:13 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id l15so16026049wro.11;
        Tue, 26 Jul 2022 06:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LUMaKXkVvWIJpdA+4n1XBPobt062sN0oITrvSdAqdAY=;
        b=FT1+me17OUffyiyYaPbSXk7po6TiLWjLo6G4wL9qfQerSzvE3Idaau0Nz0R4G8aPOl
         YjaE4GFl+Twx6qhnMb+jxF5+jgyvwJmdobrpha0zmVpx5Zb8N2d8hSQG2VePJko6dTHf
         2WhXfMZT/qM2zuFu1pa2BBR2EdViDZ8LZdtT3+dvAx1UqV7m7wEhgSTMrw4N80We3xIQ
         PC1rjTKSNeAkvQbKXhzDuxOGwS3MlOIc8bTd8/0sI8ZB8f+6JzFuoad21hrGbTCKoF+p
         6foD9DnQaIifSh6pNc+bKjj5FDp+A2OOFd+VtShBYjjYJ3O3ER/gTqW9kiGiaawqjM5b
         ducw==
X-Gm-Message-State: AJIora/hVhMUw+hiGrmvLp8XAVvhl88Bbp8V+3t1BEBUepCUlTp8EFnS
        SdGc26/O19PRGtrs1T5cNPk=
X-Google-Smtp-Source: AGRyM1vw7dZ0+zdf7ovRK9cRi5k+lbX+miTo9Z8YAsT302jzpJU2YCBHWsEkZdxiNa4KztoyCFBmGA==
X-Received: by 2002:a5d:62cf:0:b0:21e:6e8c:34a8 with SMTP id o15-20020a5d62cf000000b0021e6e8c34a8mr9768554wrv.154.1658840952226;
        Tue, 26 Jul 2022 06:09:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003a04d19dab3sm3225732wmb.3.2022.07.26.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:09:11 -0700 (PDT)
Date:   Tue, 26 Jul 2022 13:09:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, will@kernel.org, robin.murphy@arm.com,
        samuel@sholland.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Message-ID: <20220726130909.jnj5etogffm4b2c5@liuwe-devbox-debian-v2>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
 <Yt+Uro8y219/MNFE@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt+Uro8y219/MNFE@8bytes.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 26, 2022 at 09:15:58AM +0200, Joerg Roedel wrote:
> Hi Michael,
> 
> On Mon, Jul 25, 2022 at 05:53:40PM -0700, Michael Kelley wrote:
> > Recent changes to solve inconsistencies in handling IRQ masks #ifdef
> > out the affinity field in irq_common_data for non-SMP configurations.
> > The current code in hyperv_irq_remapping_alloc() gets a compiler error
> > in that case.
> > 
> > Fix this by using the new irq_data_update_affinity() helper, which
> > handles the non-SMP case correctly.
> > 
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> 
> Please add a fixes tag.
> 
> Where is the change which breaks this currently, in some subsystem tree
> or already upstream?
> 

The offending patch aa081358 is in linux-next.

> In case it is still in a maintainers tree, this patch should be applied
> there. Here is my
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>

I can take this patch via hyperv-next. This is a good improvement
anyway.

Thanks,
Wei.

> 
> for that.
> 
