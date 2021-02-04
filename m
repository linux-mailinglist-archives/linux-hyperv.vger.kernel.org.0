Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB1630FBE3
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239361AbhBDSrf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 13:47:35 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41499 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbhBDSqg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 13:46:36 -0500
Received: by mail-ot1-f48.google.com with SMTP id s107so4408935otb.8;
        Thu, 04 Feb 2021 10:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnuUw1FLcM4+2rBIDsM0pF6wdlTJf4QW7NKIBa7PlDU=;
        b=FSBP/7o608u2T/6CsEOHE082t7ThtmgZRsV0oE6+H6WcdO4zFsmjZ93caRvUkpninm
         paFLDPwC6Em42lc2x4ccoYauhiOAXswkhDPLpRrd8YVFqdB+Et6dVoXwdKHvmrfAZdjq
         2OtP+7XzBfpGNHjwiPBH66FfSsOdwi/H7hLbvZoehWCo9Qz4lYIZ2Eao1y7nYd1WKJPD
         lQgQLILP1R7DNmmz6uvWYEbzWeo9VsM7SLwyCSvckoatztDJCr4jn0mtDmvuzIOx6cOW
         QvHYjY4at+d+hOdLTCH++XHOLHbWuMLi+8+gTarQzqflnLF2D1cuTcLtuWr6TfkoxJ3y
         9EMg==
X-Gm-Message-State: AOAM5302rykKyorCKoTlLnElkXKHk3RP0B/Q1neRLkDWShPrthMIlPGM
        vMoPTKc7nRkwVlrm/IYLzrXryKBgB84FJEy5B+k=
X-Google-Smtp-Source: ABdhPJwK95CDaaKkEZNHkySmn2WdN+iBqCzuyanMrOGG8WbGe+I9XJxDm16VMC5E8ME5QFhIbip3DGg0SxLQwDn8Ov0=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr554329ote.321.1612464336202;
 Thu, 04 Feb 2021 10:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20210203150435.27941-1-wei.liu@kernel.org> <20210203150435.27941-9-wei.liu@kernel.org>
 <20210204183841.y4fgwjuggtbrnere@liuwe-devbox-debian-v2>
In-Reply-To: <20210204183841.y4fgwjuggtbrnere@liuwe-devbox-debian-v2>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Feb 2021 19:45:25 +0100
Message-ID: <CAJZ5v0gJD1B92FsSo9xMrdFWYEh5DHqAQQ4TiFbHV=a2XpBEbg@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] ACPI / NUMA: add a stub function for node_to_pxm()
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 4, 2021 at 7:41 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Wed, Feb 03, 2021 at 03:04:27PM +0000, Wei Liu wrote:
> > There is already a stub function for pxm_to_node but conversion to the
> > other direction is missing.
> >
> > It will be used by Microsoft Hypervisor code later.
> >
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>
> Hi ACPI maintainers, if you're happy with this patch I can take it via
> the hyperv-next tree, given the issue is discovered when pxm_to_node is
> called in our code.

Yes, you can.

Thanks!

>
> > ---
> > v6: new
> > ---
> >  include/acpi/acpi_numa.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index a4c6ef809e27..40a91ce87e04 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -30,6 +30,10 @@ static inline int pxm_to_node(int pxm)
> >  {
> >       return 0;
> >  }
> > +static inline int node_to_pxm(int node)
> > +{
> > +     return 0;
> > +}
> >  #endif                               /* CONFIG_ACPI_NUMA */
> >
> >  #ifdef CONFIG_ACPI_HMAT
> > --
> > 2.20.1
> >
