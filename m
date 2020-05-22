Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C623A1DF062
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 22:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgEVUMK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgEVUMK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 16:12:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFAAC061A0E;
        Fri, 22 May 2020 13:12:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q129so3539989iod.6;
        Fri, 22 May 2020 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saotB9KMfqrIu5EigKoBdvAvBWnCKlQB7BToX+lAJBo=;
        b=oRv42hy2T+bM7Z8iTEgQN35278sq8mlGtIQsW10qpiG+XYpRS88a8R6ULhGuOvUeJj
         b8ByIq3W8jrGELY70yw/4qQPP1n+DlTJKPob67BR7MvvfWqYwum0z3bvfBoLy6f8bwCd
         amlPbOsD6s7M2kWFXhz7mlI9Y2ZiGnFWTKFcqKDk/DD7/F0xeVYTnt5FTjRq4u2++Pbx
         py5YjJu3uUQbc8UCxrssxC01uyvIayzDTdqvHBhJc41MAX3a0cLDo9Ak3L1cd31tLyG/
         SIcHMgdEH04zoN6cnISVFx6b/xAe5LMx/DtCZf6ab/MEPNyRgt9XroCT8bFBOqlD/XG7
         GK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saotB9KMfqrIu5EigKoBdvAvBWnCKlQB7BToX+lAJBo=;
        b=UbD9XbI4bh268epZSss8DvM/OQKadDkSazFW9EszON7Tl1LeqEekdI7RzHfimiP6+n
         KVqVxjKBZ10F6VlBQNkPvZhlwD8LF+j4xG1V7ljo6lrktFHf/V8S3ivJAzxoG+H7m3Kl
         cYEjw4tx6AxIOq9nsCh6GrRv+AqCOsFM+pTjqEwyE0hTUzm4+vCO3EaP5HKAg8wgVekG
         /Qu8Pa7cIDHzkdcJDilLDcSlnQdkCUT2G1BKHvNQ4nrxfkF4nW2Bt8KNAtboGxLvjLJ/
         RYYB+Ru5VYR2a3To5G4n48DpD7W8mWlPHpTwen0zSVJCHqxZStUvaVVpR9aAmYtGz6eS
         GeDw==
X-Gm-Message-State: AOAM532whkUl58XFr1N59YRq9HA1QQkBQ1k5E23UxsoE2sCUPU5oAgV6
        +hkFldch0kqOAJrhj0iHkONATAAFY+Ve3PAbr0A=
X-Google-Smtp-Source: ABdhPJyK+NMujnZMFVlJ0h9/y7LEh4I8LWSJ1cmCUrcTizs10uCA96bc27tU70V9cRph3PBIST3qNQ7EXMAuHPDs+sM=
X-Received: by 2002:a6b:b9d5:: with SMTP id j204mr4638521iof.38.1590178328351;
 Fri, 22 May 2020 13:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20200520090158.4x4lkbssm7ncirn7@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
 <SN4PR2101MB08804F99992085C64982C821C0B40@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB08804F99992085C64982C821C0B40@SN4PR2101MB0880.namprd21.prod.outlook.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 22 May 2020 13:11:57 -0700
Message-ID: <CAKgT0UdqWNvFFALUU_sAP-PsMSMQMrsygHrjL3ESyS0uwWLKgw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] x86/Hyper-V: Support for free page reporting
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 22, 2020 at 9:42 AM Sunil Muthuswamy <sunilmut@microsoft.com> wrote:
>

[...]

> >
> > > +           order = get_order(sg->length);
> > > +           range = &hint->ranges[i];
> > > +           range->address_space = 0;
> >
> > I guess this means all address spaces?
>
> 'address_space' is being used here just as a zero initializer for the union. I think the use
> of 'address_space' in the definition of hv_gpa_page_range is not appropriate. This struct is
> defined in the TLFS 6.0 with the same name, if you want to look it up.
>
> >
> > > +           range->page.largepage = 1;
> >
> > What effect does this have? What if the page is a 4k page?
>
> Page reporting infrastructure doesn't report 4k pages today, but only huge pages (see
> PAGE_REPORTING_MIN_ORDER in page_reporting.h). Additionally, the Hyper-V hypervisor
> only supports reporting of 2M pages and above. The current code assumes that the minimum
> order will be 9 i.e 2M pages and above.
> If we feel that this could change in the future, or an implementation detail that should be
> protected against, I can add some checks in hv_balloon.c. But, in that case, the ballon driver
> should be able to query the page reporting min order somehow, which it is currently, since it is
> private.
> Alexander, do you have any suggestions or feedback here?

For now we are keeping the limit to order 9 for a couple reasons. The
first being that we don't want to trigger the breaking apart of
transparent huge pages on the host, and the second being for
performance as it is better to report larger pages rather than smaller
ones.

If we were to enable bringing the value down lower we would likely
make it a part of the page reporting dev info structure and would have
to be set at initialization time. That way the device itself could
configure the minimum value. I don't see the value itself being
lowered without adding an option like that since it would likely cause
issues for several different reasons going forward though. If nothing
else you could do a BUILD_BUG_ON that would assert if
PAGE_REPORTING_MIN_ORDER was anything other than the same size as the
"large_page" size referenced above.

> >
> > > +           range->page.additional_pages = (1ull << (order - 9)) - 1;
> >
> > What is 9 here? Is there a macro name *ORDER that you can use?
>
> It is to determine the count of 2M pages. I will define a macro.

Is this the only spot where you are using order? Instead of converting
the length to an order why not just divide it by the 2M page size? I
would think that would be faster than having to do something like
having to call get_order on the length? Also instead of using "9" it
might make more sense if you have a define somewhere that says what
"large_page" size actually is. Then you could just divide by that
which should be translated into a shift which is fast and cheap.
