Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B046EB397
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Apr 2023 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjDUVZw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Apr 2023 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjDUVZv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Apr 2023 17:25:51 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EFA2114;
        Fri, 21 Apr 2023 14:25:50 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-63d4595d60fso17011513b3a.0;
        Fri, 21 Apr 2023 14:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682112350; x=1684704350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJedWDsXF2ePbB+lpNfK2XfHgdkLTIbTwwWaJkjgNsg=;
        b=Hp3DZdXx5oZkK0SM62FeZHoFOXMtJUjq4HPcQ62gp2qIHNAHH7Iuu3hPqP7sSdXIcu
         vuqiYWleENmapCflnsau5kqytyean+6kvxV6eWe85gn7rM5LA+n9WULYNQNy+sIehziw
         GNEsW/2q8OS7CL17OLQ8FecefSGEepm/tA6JCYF2szNvhqxs4ow2KGO0SoRFVw7/tkM/
         AM3YQXjXJVzbSQ3Lnkrj1ooVKdKGvulte/eCda57cPjPtADlMrAlDycLLTzzlv5CRWNC
         Odw0CYwid0nzwVi/p2fhcrZoui4YXaa1cP/+Vgwl4efVjnsiqkRotO8btsu8fhl/xu8w
         TQIQ==
X-Gm-Message-State: AAQBX9fPBO6l7M66YxrG4jAXJuC45zyRGuZpRh5m5h2QtYvuXYcZGnOx
        TW8X9Poo8mUtYoyIlyD20xc=
X-Google-Smtp-Source: AKy350ZyV6LAptqS0cWu/ZM4PDGtVYhbk1ei0PqnURQ/YhiAFHsz7Eptwna7wObXwOOzFJpT4LAIjg==
X-Received: by 2002:a17:902:e80d:b0:1a6:46d7:77f0 with SMTP id u13-20020a170902e80d00b001a646d777f0mr13620766plg.0.1682112349602;
        Fri, 21 Apr 2023 14:25:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001a281063ab4sm3090772plg.233.2023.04.21.14.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:25:49 -0700 (PDT)
Date:   Fri, 21 Apr 2023 21:25:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Message-ID: <ZEL/W59LHx+5o4r4@liuwe-devbox-debian-v2>
References: <20230421013025.17152-1-decui@microsoft.com>
 <ZEJdSXv6IwSxPp9r@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEJdSXv6IwSxPp9r@lpieralisi>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 21, 2023 at 11:54:17AM +0200, Lorenzo Pieralisi wrote:
> On Thu, Apr 20, 2023 at 06:30:25PM -0700, Dexuan Cui wrote:
> > 4 commits are involved here:
> > A (2016): commit 0de8ce3ee8e3 ("PCI: hv: Allocate physically contiguous hypercall params buffer")
> > B (2017): commit be66b6736591 ("PCI: hv: Use page allocation for hbus structure")
> > C (2019): commit 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
> > D (2018): commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
> > 
> > Patch D introduced the per-CPU hypercall input page "hyperv_pcpu_input_arg"
> > in 2018. With patch D, we no longer need the per-Hyper-V-PCI-bus hypercall
> > input page "hbus->retarget_msi_interrupt_params" that was added in patch A,
> > and the issue addressed by patch B is no longer an issue, and we can also
> > get rid of patch C.
> > 
> > The change here is required for PCI device assignment to work for
> > Confidential VMs (CVMs) running without a paravisor, because otherwise we
> > would have to call set_memory_decrypted() for
> > "hbus->retarget_msi_interrupt_params" before calling the hypercall
> > HVCALL_RETARGET_INTERRUPT.
> > 
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> > 
> > Changes in v2:
> >   Fixed the inaccuracy in the commit message (Thanks Michael):
> >     "Confidential VMs (CVMs)" -> "Confidential VMs (CVMs) running without a paravisor".
> > 
> >   Added Michael's Reviewed-by.
> > 
> >  drivers/pci/controller/pci-hyperv.c | 48 +++++------------------------
> >  1 file changed, 7 insertions(+), 41 deletions(-)
> 
> Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 

Applied to hyperv-next. Thanks.
