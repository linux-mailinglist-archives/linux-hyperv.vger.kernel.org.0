Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC030FBF6
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhBDSuX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 13:50:23 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:54860 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239379AbhBDSth (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 13:49:37 -0500
Received: by mail-wm1-f43.google.com with SMTP id w4so4026128wmi.4;
        Thu, 04 Feb 2021 10:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GOOsv7iu4uxhMIW8Kn3SvcGAFHdQmyE/1M1/Ndzpetc=;
        b=F8SIn+6yuWWeeGUlNIzpe3FTTdzs4IiXJK/7dK0vlS4SPnFv0dGZ2ZfXtRA1KZToIY
         AAVVvVWFEidiBRHn4bQUtHqQQVYJakeq2lejeKUpnXPCPjeMYeK6JTvsXRA0koy33Vha
         FIBDCr6sd8EroM3c2+6sFPqr+RDsyyvDBnlZEcfI0rPJ4/DbtJOa/kVlpVMTZ1YE9CIi
         KCO/HFD3sTTGehAqbjoM/QPNwbCC938hOdXdmSVUC/kuYQ9KMFSfH7a4cgZXeKS/GQnD
         FVMbuiBx9xVw9h37eL0cSAXnCsyOM8FpMEOIhxxq9oSjlFqRazQfm2pjLR0UE24zjczO
         3RaA==
X-Gm-Message-State: AOAM531/cl7sEsVLdec6bFUwcJyX1EG49TNjbH0IFkalZdCKEVSbX6g8
        fRcS+fdMe2vGCBsVVOCQrw4V+p6w1F8=
X-Google-Smtp-Source: ABdhPJx/QVCrF9T8JTZpgUmuDb824n1SNcWtl48mtsHmUpfIIVZNO3kWiVHrcu5JfDhtVIB+1H1OMA==
X-Received: by 2002:a1c:a5d0:: with SMTP id o199mr470959wme.81.1612464531311;
        Thu, 04 Feb 2021 10:48:51 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e12sm9210080wrs.67.2021.02.04.10.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:48:50 -0800 (PST)
Date:   Thu, 4 Feb 2021 18:48:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" 
        <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH v6 08/16] ACPI / NUMA: add a stub function for
 node_to_pxm()
Message-ID: <20210204184849.fx2bxwmy2a6rvgwo@liuwe-devbox-debian-v2>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-9-wei.liu@kernel.org>
 <20210204183841.y4fgwjuggtbrnere@liuwe-devbox-debian-v2>
 <CAJZ5v0gJD1B92FsSo9xMrdFWYEh5DHqAQQ4TiFbHV=a2XpBEbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gJD1B92FsSo9xMrdFWYEh5DHqAQQ4TiFbHV=a2XpBEbg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 04, 2021 at 07:45:25PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 4, 2021 at 7:41 PM Wei Liu <wei.liu@kernel.org> wrote:
> >
> > On Wed, Feb 03, 2021 at 03:04:27PM +0000, Wei Liu wrote:
> > > There is already a stub function for pxm_to_node but conversion to the
> > > other direction is missing.
> > >
> > > It will be used by Microsoft Hypervisor code later.
> > >
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> >
> > Hi ACPI maintainers, if you're happy with this patch I can take it via
> > the hyperv-next tree, given the issue is discovered when pxm_to_node is
> > called in our code.
> 
> Yes, you can.

Thanks Rafael. I will add your ack to the patch as well.

Wei.
