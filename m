Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA53C2522
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhGINpn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 09:45:43 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36549 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhGINpk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 09:45:40 -0400
Received: by mail-wr1-f50.google.com with SMTP id v5so12235843wrt.3;
        Fri, 09 Jul 2021 06:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q7mB1luMo6HbqDXiBnl1Lwdd0jsa0W6EKAtYOrdTCZQ=;
        b=by///3buMRDDAm1A8U7VKz6X350wmpKMSldK1WiuThHZiEyb4BcCH2hl8tJE7M6Anr
         EKPn5lEltKEdZPKF3zL7TyJv/aZ9WygwGWaxhSxtxSsxeSbxxvnhdHHVrW1wuSkXDBiM
         HoCW5XwiZJxYUPyEX4AaiWbuJhEAY4wVIqFcKrJuOhlGgp+Q2qC8f2Netad7vX2upUrB
         /Z0STFweCxfh/pKiHenf0+SIKLZRgwJjiVnPQEsPDf/iIFKg66zD5MVVUbLIa94KeMqz
         IIiZIZREmEIhlFHj7sSam4ARMQkagHVkf3O82B6ODjccqidrfufNuXL2yOgvRkGdLtH7
         eZNw==
X-Gm-Message-State: AOAM5306huwZM+ntLyAlw11CwvKcVqyAWRNJs3f7k4FqSwRFcNK86cKH
        nyjeDWYxabQoiHgf1oOG/xs=
X-Google-Smtp-Source: ABdhPJy1Vhv89E6JlCPqe86nNsogAgxU+t9rVvrr2JLaDugrBsREJ7+fYhw4wwqlJCIcXWLMD2M1ow==
X-Received: by 2002:adf:fd4d:: with SMTP id h13mr36177102wrs.5.1625838175836;
        Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s9sm5305291wrn.87.2021.07.09.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:42:55 -0700 (PDT)
Date:   Fri, 9 Jul 2021 13:42:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
        kumarpraveen@linux.microsoft.com,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "open list:INTEL IOMMU VT-d" <iommu@lists.linux-foundation.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC v1 3/8] intel/vt-d: make DMAR table parsing code more
 flexible
Message-ID: <20210709134253.274m4dpqukxn43q7@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-4-wei.liu@kernel.org>
 <e1dcc315-4ebb-661e-4289-d176b3db39b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1dcc315-4ebb-661e-4289-d176b3db39b5@arm.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 09, 2021 at 01:56:46PM +0100, Robin Murphy wrote:
> On 2021-07-09 12:43, Wei Liu wrote:
> > Microsoft Hypervisor provides a set of hypercalls to manage device
> > domains. The root kernel should parse the DMAR so that it can program
> > the IOMMU (with hypercalls) correctly.
> > 
> > The DMAR code was designed to work with Intel IOMMU only. Add two more
> > parameters to make it useful to Microsoft Hypervisor. Microsoft
> > Hypervisor does not need the DMAR parsing code to allocate an Intel
> > IOMMU structure; it also wishes to always reparse the DMAR table even
> > after it has been parsed before.
> 
> We've recently defined the VIOT table for describing paravirtualised IOMMUs
> - would it make more sense to extend that to support the Microsoft
> implementation than to abuse a hardware-specific table? Am I right in

I searched for VIOT and believed I found the correct link
https://lwn.net/Articles/859291/. My understanding is based on the
reading of that series.

VIOT is useful. I think it solves the problem for guests.

It does not solve the problem we have though. The DMAR tables are not
conjured up by some backend software running on the host side. They are
the real tables provided by the firmware. The kernel here is part of the
host setup, dealing with physical hardware.

No matter how much I wish all vendors unified their tables, I don't see
how that's going to happen for readily available servers. :-(

> assuming said hypervisor isn't intended to only ever run on Intel hardware?

Yes, that's correct. We also plan to add support AMD and ARM64.

Wei.
