Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECEA6E1135
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDMPeP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Apr 2023 11:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDMPeO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Apr 2023 11:34:14 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6AD1735;
        Thu, 13 Apr 2023 08:34:13 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3971977wmo.0;
        Thu, 13 Apr 2023 08:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400052; x=1683992052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL7l8rFrlcpe/xiNSpGTIsY2ITjrB7+gQWfKwecs0Zk=;
        b=J/x/D1qwiC8QULuqAIUApMTkALgb+hmGAXP5QJcj/hT83Vjmw4Y72JckJnzCglM7ro
         T7zueBw/H50h8RYrGLCyq6R2WiH/CakU2Cb9UuauWnL9icxcrbq67XQykGOgfluRbZNN
         nOFswHtlU1fOr1G8Fum3r4eWb34rL5Q4swGif1lOs0urXT8lrzaC6HgpH4NXYO0BHTSb
         AiBn1DdNU+M1LlvFjq9e/Gg94IJbPgrtT9rotIkKF2dJkup92alnfGqSeu/I5w+YVmCE
         D3cmfguo03vepQ9KHvanZbYkAZLQHBlpnSxQDhWFjsb/UeWc8rbA3UuNV1wW7FVg0YbJ
         ptYQ==
X-Gm-Message-State: AAQBX9cvOTBNKrWr29+0UPlECyEAK30LZ+2NGxHnZwC0HRqZSLIMdMno
        dqguEpfR56vLNMmNKl4BdUY=
X-Google-Smtp-Source: AKy350ZXINt7MAa6jIBI5IRWUmAG08Cv4/HGMeCXYz3QbS43jFGtd7EOBtgtIhVhrIZEEAarFjXTDQ==
X-Received: by 2002:a1c:7312:0:b0:3f0:9f9b:1665 with SMTP id d18-20020a1c7312000000b003f09f9b1665mr2361796wmb.3.1681400052184;
        Thu, 13 Apr 2023 08:34:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003f09d7b6e20sm2136546wmc.2.2023.04.13.08.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 08:34:11 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:34:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Jinank Jain <jinankjain@linux.microsoft.com>,
        "g@liuwe-devbox-debian-v2" <g@liuwe-devbox-debian-v2>,
        Jinank Jain <jinankjain@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Message-ID: <ZDgg7sq4mXk8025W@liuwe-devbox-debian-v2>
References: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
 <ZDdZVw9Y0q7oT1FG@liuwe-devbox-debian-v2>
 <BYAPR21MB168827DA138ADE39298FFB37D7989@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168827DA138ADE39298FFB37D7989@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 13, 2023 at 03:05:09AM +0000, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, April 12, 2023 6:23 PM
> > 
> > On Tue, Apr 04, 2023 at 11:35:46AM +0000, Jinank Jain wrote:
> > > In case of nested MSHV, retargeting interrupt hypercall should be sent
> > > to L0 hypervisor instead of L1 hypervisor.
> > >
> > > Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> > 
> > Applied to hyperv-next. Thanks.
> 
> I'd like to hold off on taking this change.  Nuno and I are discussing
> how best to handle nested hypercalls.  In addition to the proposed
> nested changes,  we have hypercall changes coming as part of the
> TDX and fully enlightened SNP patch sets.  If possible, I'd like to
> avoid adding logic at the hv_do_hypercall() call sites.  It's not clear
> whether avoiding such logic will really be feasible, but I'd like to
> think about it for a bit before reaching that conclusion.

I thought that discussion will go on for a while but this patch fixed a
real bug.

Holding off is fine too. I will remove this patch from hyperv-next.

Thanks,
Wei.

> 
> Michael
> 
