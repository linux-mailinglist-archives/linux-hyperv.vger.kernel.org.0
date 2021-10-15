Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3021542F5B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Oct 2021 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbhJOOkj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Oct 2021 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbhJOOki (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Oct 2021 10:40:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B1C061762;
        Fri, 15 Oct 2021 07:38:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q19so8539410pfl.4;
        Fri, 15 Oct 2021 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SMQahSuLkYo9QaD+Qhh/rr+IxtoKzA8Nwb2h7pqvaCk=;
        b=f9C5vvm05bjesX8SnDHArhRL/E4xsJyDuEdJdwo5gcUf4ds7/HfzOPqvl9MVE+v0M6
         EH7GnDmywUofusbnWPXVnINbgFSpnQQFZmnzb7QqVieAiT/UdCFWm0GBlTb+mCPv2pun
         OnwPmERB7qtMSDnSi2tlwoSxdk/X8844lFEUBLPCdfpvpxm9nPnCtyJmTIKtP+r2lq+e
         TUO1xQcIQKdBvW9lBgv+/nd24P/tA+7XcGHESXe8RQz3qKZIXlQZm2rppNxQi1ggqxTU
         84IXAI1DqiTvtEukEhdcxB46Cn/EXGdOEHlI1TqWy75PyBy2naikDOERIKqtUYVj5pam
         2N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMQahSuLkYo9QaD+Qhh/rr+IxtoKzA8Nwb2h7pqvaCk=;
        b=TARxMk/JE61L2KUKbtAtGh+nwSBFIvbl3yy1600ceOle/Q/BpU8hbqcItiLWZmFArI
         oSaJR0KYKJEx0kyYaIvxan2bU2HDb+7fUK8zwsFtLvf6Jo5Hihe59+eGYJjWj97GNyJz
         HqPyphzrIvYuZ4g6+AMGXf1ZpTyeMEOLVe5MYqEkmwcjGbDjpFspJpdXS/KafunFrHqz
         OZqAqu1pfw8paXLsCZAcJAXFZBOUVPLSTXdL+s3bBflCvJNv1+BHDsEthcCZxwRFXFC4
         /hNng8p99m42UNPspPzPAx/2TBqSQTbIA//2alNe/1c2qIJ72DD5lYLnwq5faTGyXtcU
         axug==
X-Gm-Message-State: AOAM5303YRRs+Y7myCBU/BuYFQB1IHfPmNe+9rtXmZavAAfIBHbvNMgY
        zAkFudaOEN64P3ozTCa4ZiU=
X-Google-Smtp-Source: ABdhPJy3KchjBGO6Ql9f4dVlV9jPJcB0Yra/m1Nx/lqa6aj1Bh1ThIeCJpbVbUTEIVBjipN6SfnlEA==
X-Received: by 2002:aa7:8149:0:b0:44c:916c:1fdb with SMTP id d9-20020aa78149000000b0044c916c1fdbmr12465808pfn.34.1634308711265;
        Fri, 15 Oct 2021 07:38:31 -0700 (PDT)
Received: from theprophet ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id g14sm11656625pjd.24.2021.10.15.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:38:30 -0700 (PDT)
Date:   Fri, 15 Oct 2021 20:08:18 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH v2 00/24] Unify PCI error response checking
Message-ID: <20211015143818.gvkcs5j6zvdino2r@theprophet>
References: <cover.1634300660.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634300660.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 15/10, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the 
> CPU read, so most hardware fabricates ~0 data.
> 
> This patch series adds PCI_ERROR_RESPONSE definition and other helper
> definition SET_PCI_ERROR_RESPONSE and RESPONSE_IS_PCI_ERROR and uses it
> where appropriate to make these checks consistent and easier to find.
> 
> This helps unify PCI error response checking and make error check
> consistent and easier to find.
> 
> This series also ensures that the error response fabrication now happens
> in the PCI_OP_READ and PCI_USER_READ_CONFIG. This removes the
> responsibility from controller drivers to do the error response setting. 
> 
> Patch 1:
>     - Adds the PCI_ERROR_RESPONSE and other related defintions
>     - All other patches are dependent on this patch. This patch needs to
>       be applied first, before the others
> 
> Patch 2:
>     - Error fabrication happens in PCI_OP_READ and PCI_USER_READ_CONFIG
>       whenever the data read via the controller driver fails.
>     - This patch needs to be applied before, Patch 4/24 to Patch 15/24 are
>       applied.
> 
> Patch 3:
>     - Uses SET_PCI_ERROR_RESPONSE() when device is not found and
>       RESPONSE_IS_PCI_ERROR() to check hardware read from the hardware.
> 
> Patch 4 - 15:
>     - Removes redundant error fabrication that happens in controller 
>       drivers when the read from a PCI device fails.
>     - These patches are dependent on Patch 2/24 of the series.
>     - These can be applied in any order.
> 
> Patch 16 - 22:
>     - Uses RESPONSE_IS_PCI_ERROR() to check the reads from hardware
>     - Patches can be applied in any order.
> 
> Patch 23 - 24:
>     - Edits the comments to include PCI_ERROR_RESPONSE alsong with
>       0xFFFFFFFF, so that it becomes easier to grep for faulty 
>       hardware reads.
> 
> Changelog
> =========
> 
> v2:
>     - Instead of using SET_PCI_ERROR_RESPONSE in all controller drivers
>       to fabricate error response, only use them in PCI_OP_READ and
>       PCI_USER_READ_CONFIG
> 
> Naveen Naidu (24):
>  [PATCH 1/24] PCI: Add PCI_ERROR_RESPONSE and it's related definitions
>  [PATCH 2/24] PCI: Set error response in config access defines when ops->read() fails
>  [PATCH 3/24] PCI: Unify PCI error response checking
>  [PATCH 4/24] PCI: Remove redundant error fabrication when device read fails
>  [PATCH 5/24] PCI: thunder: Remove redundant error fabrication when device read fails
>  [PATCH 6/24] PCI: iproc: Remove redundant error fabrication when device read fails
>  [PATCH 7/24] PCI: mediatek: Remove redundant error fabrication when device read fails
>  [PATCH 8/24] PCI: exynos: Remove redundant error fabrication when device read fails
>  [PATCH 9/24] PCI: histb: Remove redundant error fabrication when device read fails
>  [PATCH 10/24] PCI: kirin: Remove redundant error fabrication when device read fails
>  [PATCH 11/24] PCI: aardvark: Remove redundant error fabrication when device read fails
>  [PATCH 12/24] PCI: mvebu: Remove redundant error fabrication when device read fails
>  [PATCH 13/24] PCI: altera: Remove redundant error fabrication when device read fails
>  [PATCH 14/24] PCI: rcar: Remove redundant error fabrication when device read fails
>  [PATCH 15/24] PCI: rockchip: Remove redundant error fabrication when device read fails
>  [PATCH 16/24] PCI/ERR: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
>  [PATCH 17/24] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
>  [PATCH 18/24] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
>  [PATCH 19/24] PCI/DPC: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
>  [PATCH 20/24] PCI/PME: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
>  [PATCH 21/24] PCI: cpqphp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
>  [PATCH 22/24] PCI: keystone: Use PCI_ERROR_RESPONSE to specify hardware error
>  [PATCH 23/24] PCI: hv: Use PCI_ERROR_RESPONSE to specify hardware read error
>  [PATCH 24/24] PCI: xgene: Use PCI_ERROR_RESPONSE to specify hardware error
> 
>  drivers/pci/access.c                        | 36 ++++++++--------
>  drivers/pci/controller/dwc/pci-exynos.c     |  4 +-
>  drivers/pci/controller/dwc/pci-keystone.c   |  4 +-
>  drivers/pci/controller/dwc/pcie-histb.c     |  4 +-
>  drivers/pci/controller/dwc/pcie-kirin.c     |  4 +-
>  drivers/pci/controller/pci-aardvark.c       | 10 +----
>  drivers/pci/controller/pci-hyperv.c         |  2 +-
>  drivers/pci/controller/pci-mvebu.c          |  8 +---
>  drivers/pci/controller/pci-thunder-ecam.c   | 46 +++++++--------------
>  drivers/pci/controller/pci-thunder-pem.c    |  4 +-
>  drivers/pci/controller/pci-xgene.c          |  8 ++--
>  drivers/pci/controller/pcie-altera.c        |  4 +-
>  drivers/pci/controller/pcie-iproc.c         |  4 +-
>  drivers/pci/controller/pcie-mediatek.c      | 11 +----
>  drivers/pci/controller/pcie-rcar-host.c     |  4 +-
>  drivers/pci/controller/pcie-rockchip-host.c |  4 +-
>  drivers/pci/controller/vmd.c                |  2 +-
>  drivers/pci/hotplug/cpqphp_ctrl.c           |  4 +-
>  drivers/pci/hotplug/pciehp_hpc.c            | 10 ++---
>  drivers/pci/pci.c                           | 10 ++---
>  drivers/pci/pcie/dpc.c                      |  4 +-
>  drivers/pci/pcie/pme.c                      |  4 +-
>  drivers/pci/probe.c                         | 10 ++---
>  include/linux/pci.h                         |  9 ++++
>  24 files changed, 87 insertions(+), 123 deletions(-)
> 
> -- 
> 2.25.1
>

Please ignore this stray cover letter. I had a wrong message ID written
for it. Apologies for the inconvenience caused.

