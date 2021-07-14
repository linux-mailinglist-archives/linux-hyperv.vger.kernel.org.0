Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE30A3C80A1
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 10:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbhGNIuV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 04:50:21 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38445 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238432AbhGNIuV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 04:50:21 -0400
Received: by mail-wm1-f48.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so3390097wmb.3;
        Wed, 14 Jul 2021 01:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZcKu6JzHt5KJb3Xql7bkDVD+N0alIA9rphZxYoZe6yk=;
        b=TXaPKzVBu0NkYrw75dK/PFQnjGY/gstqSbgpjxmD387DFsMMzDHu53+7091/aipGHp
         ZexBdGP9ZWoNL1j5pZWoV5EaCwcTGeDU/dEPTaQltarZjc9Tva7daUUSFvF4m3keIGsC
         ms1MAhQlujtYO4qCdjo14AHtypcLtyGBbNM7N1WMB7shmh5dzCzWJupqBh8ioL/Z3Cup
         xyljQz0WTdg+I7DovmsrC5hD/JTBr/WRp7CriR7gE7+brxwQIztpIRo49huWLqm208yT
         h4jvWaq6Jp2CaMHByzLwmDNqWrZYiC+Ub1LMYQ2xISaFponYDnbS/gTfzGdHjZtYXNKZ
         0swA==
X-Gm-Message-State: AOAM532SBxMuF/BZG0YZGjBS5cjF93czIKuch0nWcgSehdiRfs6odCCp
        Jz8ENMsii9X5hHyaBGn5G2w=
X-Google-Smtp-Source: ABdhPJx6gTDt7Mx/u77c//bGw9Tbdbun269RavkN2+RKuhQ+f+AA/+Z2bkSgxQYMmWgjXsDKti52Lg==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr2780414wmj.37.1626252449320;
        Wed, 14 Jul 2021 01:47:29 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l20sm1506246wmq.3.2021.07.14.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:47:28 -0700 (PDT)
Date:   Wed, 14 Jul 2021 08:47:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3 1/1] PCI: hv: Support for create interrupt v3
Message-ID: <20210714084727.y3cxrj3365k4sfw6@liuwe-devbox-debian-v2>
References: <MW4PR21MB20026A6EA554A0B9EC696AA8C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB20026A6EA554A0B9EC696AA8C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 12, 2021 at 09:58:18PM +0000, Sunil Muthuswamy wrote:
> Hyper-V vPCI protocol version 1_4 adds support for create interrupt
> v3. Create interrupt v3 essentially makes the size of the vector
> field bigger in the message, thereby allowing bigger vector values.
> For example, that will come into play for supporting LPI vectors
> on ARM, which start at 8192.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
