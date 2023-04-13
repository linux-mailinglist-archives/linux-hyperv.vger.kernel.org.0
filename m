Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE66E03CC
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 03:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDMBln (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 21:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMBln (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 21:41:43 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EB830CB;
        Wed, 12 Apr 2023 18:41:42 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id i3so3342395wrc.4;
        Wed, 12 Apr 2023 18:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681350101; x=1683942101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRK6818Jy+em8aMAf7sWZ9ZpmPkX8RUSskuWqBtofAg=;
        b=I2Gsytenfi8Ewh82L+aoluskYoukCnDEzVfM10pTaPVhn1VWzh7seaYPI6fZpbaTVn
         SSgUsbGfAbajjkB1MN8MqjYBI4PfWnI+xsrJw/KsdVufxNt7u4GJ23HUiH0Vl/ux8yfH
         L0VWTEhRqT/FGNb9aZ6MFv5RlpkplPJYgXOUvLi+WbQCzSgbnKsZCw7AWthjEZeDyncM
         7S+RAciKkO0e3UPYp9Cpm7oVCPj6D5ZCNB8LO2woNfJdukju3hTVn6URM4b3krUXQwjb
         /ShGDf6rcf9z1uWooh7IKr8pypLUGZe/xBUByntm2mLiHRdFJgPjLe8wHOmBYanid6IH
         JkPg==
X-Gm-Message-State: AAQBX9dC6PVd05ePrLuam4rNvU2zLk6YDkVvDNEm3D/U10RwPbXH2eim
        ViRoUWOSuTwstUVC5En8UhU=
X-Google-Smtp-Source: AKy350YTMS2yn1zkhX69SeODq3A3IbWZT/r5T6TvWQeybqwM1usJCfEdQD0mJ4ztPhv7laCbuYmJLA==
X-Received: by 2002:adf:f98c:0:b0:2f0:9f9f:797 with SMTP id f12-20020adff98c000000b002f09f9f0797mr99509wrr.16.1681350100712;
        Wed, 12 Apr 2023 18:41:40 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w13-20020adfec4d000000b002efb6e0c495sm129227wrn.91.2023.04.12.18.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:41:40 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:41:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Message-ID: <ZDdd0FZT9RHfg3cm@liuwe-devbox-debian-v2>
References: <20230408211112.15235-1-decui@microsoft.com>
 <BYAPR21MB1688F1E184FD1A914637EFB0D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688F1E184FD1A914637EFB0D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 11, 2023 at 05:27:41PM +0000, Michael Kelley (LINUX) wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 2:11 PM
> > 
> > 4 commits are involved here:
> > A (2016): commit 0de8ce3ee8e3 ("PCI: hv: Allocate physically contiguous hypercall
> > params buffer")
> > B (2017): commit be66b6736591 ("PCI: hv: Use page allocation for hbus structure")
> > C (2019): commit 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by
> > the hbus buffer")
> > D (2018): commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
> > 
> > Patch D introduced the per-CPU hypercall input page "hyperv_pcpu_input_arg"
> > in 2018. With patch D, we no longer need the per-Hyper-V-PCI-bus hypercall
> > input page "hbus->retarget_msi_interrupt_params" that was added in patch A,
> > and the issue addressed by patch B is no longer an issue, and we can also
> > get rid of patch C.
> > 
> > The change here is required for PCI device assignment to work for
> > Confidential VMs (CVMs), because otherwise we would have to call
> > set_memory_decrypted() for "hbus->retarget_msi_interrupt_params" before
> > calling the hypercall HVCALL_RETARGET_INTERRUPT.
> 
> Well, not all CVMs.  It's not required for SEV-SNP vTOM VMs on Hyper-V because
> of the paravisor.  Is it more accurate to say "for Confidential VMs (CVMs) running
> without a paravisor"?
> 

Let me know how this text should be reworded.

> Otherwise,
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
