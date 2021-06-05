Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB639C77E
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jun 2021 12:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFEKmM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Jun 2021 06:42:12 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:39453 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEKmL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Jun 2021 06:42:11 -0400
Received: by mail-wm1-f46.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso9336120wmh.4;
        Sat, 05 Jun 2021 03:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MxmxV/mHxrDJzyy3n7zHJvUC9KP69YHsvKcSnHbPolw=;
        b=TRgGCSTTLbauWIbp/hW6+SxB79aeJt9tVC1CfnljBTa7SVyn+lpwGGwNe+vf3+HmzN
         XiRFIzm3zD5F2D/HSW8tGC4uUSLrQtq8p1lBf/0O6ZEKZRoLbVAlm+wsNHPo7jVKk//L
         HEae/f8CLefAXuU74f/vxYZWBL5Humg7Gi215sWc60Guyv9yQnpI4spUfFs2lqo4BwoV
         /DP96SCiv3LEgEGnoC6lGBe+WafZrVTRoXXmEKQ4COtDZMirYgkpg8ivitOwbMnWWC9N
         aa6qFDWDs41BDbuVhKsEm8lMWOf8L8I+rWmsix5+nzLQVTiYZbhPFn2w/cRx12iqTOVx
         lFiQ==
X-Gm-Message-State: AOAM530Sk9xBZGeKWN4stmJWsTL4PzZMfr2Ony6msPXc4u7AVhOiOW2G
        /vNIlHsHiUJnHMSC1mzWpQY=
X-Google-Smtp-Source: ABdhPJznTaipBm9WBZkXSg1Hd8uDl7mUVzTiZvhqC3xEzmoyM4aaTFDvDboh6C0S6DdxTQXXq/oqzA==
X-Received: by 2002:a1c:4c07:: with SMTP id z7mr7525903wmf.90.1622889623185;
        Sat, 05 Jun 2021 03:40:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d5sm9217270wrb.16.2021.06.05.03.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 03:40:22 -0700 (PDT)
Date:   Sat, 5 Jun 2021 10:40:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, kys@microsoft.com, olaf@aepfle.de,
        vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: Add check for hyperv_initialized in
 init_hv_pci_drv()
Message-ID: <20210605104021.amywuuhlyesgmybw@liuwe-devbox-debian-v2>
References: <20210602103206.4nx55xsl3nxqt6zj@liuwe-devbox-debian-v2>
 <20210604212622.GA2241239@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604212622.GA2241239@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 04, 2021 at 04:26:22PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 02, 2021 at 10:32:06AM +0000, Wei Liu wrote:
> > On Tue, May 25, 2021 at 04:17:33PM -0700, Haiyang Zhang wrote:
> > > Add check for hv_is_hyperv_initialized() at the top of init_hv_pci_drv(),
> > > so if the pci-hyperv driver is force-loaded on non Hyper-V platforms, the
> > > init_hv_pci_drv() will exit immediately, without any side effects, like
> > > assignments to hvpci_block_ops, etc.
> > > 
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > Reported-and-tested-by: Mohammad Alqayeem <mohammad.alqyeem@nutanix.com>
> > 
> > Hello PCI subsystem maintainers, are you going to take this patch or
> > shall I?
> 
> This was mistakenly assigned to me, so I reassigned it back to
> Lorenzo.
> 
> If you *do* take this, please at least update it to follow the PCI
> commit log conventions, e.g.,
> 
>   PCI: hv: Add check ...
> 
> and wrap the text so it fits in 75 columns.

Lorenzo already picked up two Hyper-V PCI patches from Long Li. I think
leaving this to him is better.

Wei.
