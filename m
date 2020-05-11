Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C301CDF15
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2020 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgEKPcU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 May 2020 11:32:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53978 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgEKPcT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 May 2020 11:32:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id k12so18447355wmj.3;
        Mon, 11 May 2020 08:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/5Nwk9mLhRZScYYCn9683XrSojxRsX8XSuLtfNRp8A=;
        b=WGJDx612oqrb49MW8+SD+uUXyfJzvaTqDgPbb77Yl7WtLYJphJNU0/ChfaR8Q+LaNY
         SwmkhK2s/XaJs8HhcguQQHHAwD5dd8XM3HgC48l5bqUzIB/o9yltQbzeru5BKgirMM2j
         PLPufO8POanZakPa3Yk1HkdNEQM98hu/sT3Bcbc1ewo4QtYaAydHSE/eH4Akr6A7/dF+
         Y6q28EETeP2m0nTO5CDaSmx2M8Tr6f0lFlbqjPc6jMtexNboYbFvgbwEfVePGe32JrMy
         Tcet1Ks7dkPNbdOWfexVHYWpKQNSDTFJ0fngbxXcU4wMNnU9jSmlvUQVBWOsw6B7IAzT
         YT6g==
X-Gm-Message-State: AGi0PubbTtep7uHHrFqqcN8qbQfa/Z8ClorXAEatRHbZvSV3/tZCSOBX
        UIB/mLLbQXPxtdnOVLz+YV6dqeC2
X-Google-Smtp-Source: APiQypK85TB4whX36I8/SG1CyR1R9Kq/5evRMvh5tebUY7NF3E42iOhAs7jNrcK9J3lezxEIt9MiJw==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr31102935wmi.187.1589211137820;
        Mon, 11 May 2020 08:32:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 7sm20219591wra.50.2020.05.11.08.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:32:17 -0700 (PDT)
Date:   Mon, 11 May 2020 15:32:15 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH] PCI: export and use pci_msi_get_hwirq in pci-hyperv.c
Message-ID: <20200511153215.spcqylnde6p36n6j@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200422195818.35489-1-wei.liu@kernel.org>
 <20200507205831.GA30988@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507205831.GA30988@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 07, 2020 at 03:58:31PM -0500, Rob Herring wrote:
> On Wed, Apr 22, 2020 at 07:58:15PM +0000, Wei Liu wrote:
> > There is a functionally identical function in pci-hyperv.c. Drop it and
> > use pci_msi_get_hwirq instead.
> > 
> > This requires exporting pci_msi_get_hwirq and declaring it in msi.h.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  arch/x86/include/asm/msi.h          | 4 ++++
> >  arch/x86/kernel/apic/msi.c          | 5 +++--
> >  drivers/pci/controller/pci-hyperv.c | 8 +-------
> >  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> Would be better if done in a way to remove an x86 dependency. 

This is a good point, Rob. I will see what I can do.

Wei.

> 
> I guess this would do it:
> 
> #define pci_msi_get_hwirq NULL
> 
> when GENERIC_MSI_DOMAIN_OPS is enabled.
