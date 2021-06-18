Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3143ACC13
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jun 2021 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhFRNYs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Jun 2021 09:24:48 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50843 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhFRNYs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Jun 2021 09:24:48 -0400
Received: by mail-wm1-f48.google.com with SMTP id k42so3774207wms.0;
        Fri, 18 Jun 2021 06:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3J7spmUIge5HH2THGTJ309Cn2stvZUkJhLQIU1Ek4f0=;
        b=kP+DNkZX++3nnPE/QX0DE/99rBXmjTFRgckenz/b62SEKn0J50KhJ9mDs+6KkswFow
         wijvxjn4scng3o82b6Djd7gp+BgFsOkMv4LLs8F55AAyFsOFBpYfcGjYXimLaDwErB8G
         MGktC2M1xUXwDaIUfYskgEa5gHRlGPuPehF7Eq2eY2axdUrtlXBoh/mAaC+4QWjOWlN5
         Vwemy14VBnFd5JW5toUJAaa3eKnn7BYneZ14eLOIEpYpvjQZZqFl624fmxzDMZ1glbYO
         xFy1lIRJzPCzUbQ7kcQVGKgyjJFm1nmsxFaYGQCy0mBIc9/i8BS/ig6Kwj0HLsBd+7qV
         c19w==
X-Gm-Message-State: AOAM533GGJeQraPtnTnxbretu/BuC2E1mUg2hMA0JUEyBKAHP5uDpJVQ
        nTu/stR7YgFPeUJOX3rCqWU=
X-Google-Smtp-Source: ABdhPJy/zS4qjhm7YAjJS6scNKjq6SpCgzt/G5SfztfbH7yX1wWk9lsJXg9YeOQsw+BNU4+7jSk+bw==
X-Received: by 2002:a05:600c:1d1a:: with SMTP id l26mr11743448wms.189.1624022558258;
        Fri, 18 Jun 2021 06:22:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x14sm8177204wrq.78.2021.06.18.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 06:22:37 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:22:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, kys@microsoft.com, olaf@aepfle.de,
        vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci-hyperv: Add check for hyperv_initialized in
 init_hv_pci_drv()
Message-ID: <20210618132236.lhbszxfgqnv2p4hq@liuwe-devbox-debian-v2>
References: <20210602103206.4nx55xsl3nxqt6zj@liuwe-devbox-debian-v2>
 <20210604212622.GA2241239@bjorn-Precision-5520>
 <20210605104021.amywuuhlyesgmybw@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605104021.amywuuhlyesgmybw@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jun 05, 2021 at 10:40:21AM +0000, Wei Liu wrote:
> On Fri, Jun 04, 2021 at 04:26:22PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jun 02, 2021 at 10:32:06AM +0000, Wei Liu wrote:
> > > On Tue, May 25, 2021 at 04:17:33PM -0700, Haiyang Zhang wrote:
> > > > Add check for hv_is_hyperv_initialized() at the top of init_hv_pci_drv(),
> > > > so if the pci-hyperv driver is force-loaded on non Hyper-V platforms, the
> > > > init_hv_pci_drv() will exit immediately, without any side effects, like
> > > > assignments to hvpci_block_ops, etc.
> > > > 
> > > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > Reported-and-tested-by: Mohammad Alqayeem <mohammad.alqyeem@nutanix.com>
> > > 
> > > Hello PCI subsystem maintainers, are you going to take this patch or
> > > shall I?
> > 
> > This was mistakenly assigned to me, so I reassigned it back to
> > Lorenzo.
> > 
> > If you *do* take this, please at least update it to follow the PCI
> > commit log conventions, e.g.,
> > 
> >   PCI: hv: Add check ...
> > 
> > and wrap the text so it fits in 75 columns.
> 
> Lorenzo already picked up two Hyper-V PCI patches from Long Li. I think
> leaving this to him is better.
> 

This patch is still missing from pci/hv, so I've picked it up via
hyperv-next (with the adjustments required by Bjorn).

Wei.
