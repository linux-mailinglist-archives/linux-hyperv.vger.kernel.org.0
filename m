Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8714EACE9
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Mar 2022 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiC2MRP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Mar 2022 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiC2MRP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Mar 2022 08:17:15 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02A234558;
        Tue, 29 Mar 2022 05:15:32 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id h16so10166965wmd.0;
        Tue, 29 Mar 2022 05:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T2jLrwWe1iSHMc5kpeBG3DQY2pIuRegpnsz85M8uusM=;
        b=W1MpE2ttN/acM+zNpdMUgN21uUTsn2ELEePtgInxF33vAy5ddUq/sQYhlLifeWTEdH
         wQLQcbm9Vq3dv6hCn9lw5vGKDw6VRB7JTS/fiLYvUqMnIwPxB4w2EI9zFXS6fLwb6Jsm
         2la0ADxXxOq4EXTrnQSaWT4h8fcyYPPb0IQ8Mls1vHFp00HbJ7lFpGjyqcEwvUI/PI5h
         cQ3UrWR0RnaO25IMwqyjx4MvoNb/P95WmYkd07ofCZrH8zCBqe23q2CWSqbP42Qv2imj
         AYeI5IwjpDatUltr5yhn5+WvrajsrchtiQ2HfJ8Ahofgi2wY2KXN/v/BOllo99gO0PwR
         dccw==
X-Gm-Message-State: AOAM533YwnvETz6S0/KoAkkmiy8jSrrT8sKjXvM7k91C4mfMVVbpp2R2
        3Y8Cj+w//qWrQPGnBM/zYpc=
X-Google-Smtp-Source: ABdhPJxXuTcR3NfAkRsxJHv6E8qdHUJogLPiA+Q9aX4xvsnU07sHIdhCXFrrTUWp10zLcRWE4C3qjw==
X-Received: by 2002:a05:600c:4ec9:b0:38c:9146:563 with SMTP id g9-20020a05600c4ec900b0038c91460563mr6670263wmq.198.1648556130816;
        Tue, 29 Mar 2022 05:15:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b00205d3d37dcdsm904568wrq.103.2022.03.29.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 05:15:30 -0700 (PDT)
Date:   Tue, 29 Mar 2022 12:15:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
        lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 0/2] Fix coherence for VMbus and PCI pass-thru devices
 in Hyper-V VM
Message-ID: <20220329121528.lrk4fjfgpw3yg3bg@liuwe-devbox-debian-v2>
References: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 24, 2022 at 09:14:50AM -0700, Michael Kelley wrote:
> Hyper-V VMs have VMbus synthetic devices and PCI pass-thru devices that are added
> dynamically via the VMbus protocol and are not represented in the ACPI DSDT. Only
> the top level VMbus node exists in the DSDT. As such, on ARM64 these devices don't
> pick up coherence information and default to not hardware coherent.  This results
> in extra software coherence management overhead since the synthetic devices are
> always hardware coherent. PCI pass-thru devices are also hardware coherent in all
> current usage scenarios.
> 
> Fix this by propagating coherence information from the top level VMbus node in
> the DSDT to all VMbus synthetic devices and PCI pass-thru devices. While smaller
> granularity of control would be better, basing on the VMbus node in the DSDT
> gives as escape path if a future scenario arises with devices that are not
> hardware coherent.
> 
> Changes since v2:
> * Move coherence propagation for VMbus synthetic devices to a separate
>   .dma_configure function instead of the .probe fucntion [Robin Murphy]
> 
> Changes since v1:
> * Use device_get_dma_attr() instead of acpi_get_dma_attr(), eliminating the
>   need to export acpi_get_dma_attr() [Robin Murphy]
> * Use arch_setup_dma_ops() to set device coherence [Robin Murphy]
> * Move handling of missing _CCA to vmbus_acpi_add() so it is only done once
> * Rework handling of PCI devices so existing code in pci_dma_configure()
>   just works
> 
> Michael Kelley (2):
>   Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
>   PCI: hv: Propagate coherence from VMbus device to PCI device

Patch 2 will not be very useful without patch 1 so I've applied the
whole series to hyperv-fixes. Thanks.
