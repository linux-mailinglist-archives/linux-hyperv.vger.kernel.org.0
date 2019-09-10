Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E60AEAED
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2019 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbfIJM4m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Sep 2019 08:56:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44368 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbfIJM4m (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Sep 2019 08:56:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id u14so16290601ljj.11;
        Tue, 10 Sep 2019 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThZUjst48nBsQQrwmyp4kkeqgEJqPKlkWHGIw30bhN4=;
        b=b3q/Lpqg9Sp34lOtUgzjULZ9aV3rmUKNkbT0CrVcbQzJ9ET1bQxl9z9U9BxJs7qMny
         n94QaUzz81Lo0A4ZGMfzKns8Agjx4Bf2PoMlceqJGMeNwuOD6bdZLREa7H/LenwpuCo+
         Y+oIzhIA9H8HYwHjTTtV9f4IG3o5KfXSnGFFr7IkSzv9m2X9+F5+M82mQ5Go8kzhU+tg
         qekG0xSEC51m0qJTX5VfXsIxSYWuJojb6yItYiPBCiqbui+363+EO94btvTPeNABHwV3
         CZ2ul6a0X5Gv20H/I114/+V5GgEUBeNlseTDrMc2me8SZZpFZtQZwa83USnlRJ0cxUw/
         /Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThZUjst48nBsQQrwmyp4kkeqgEJqPKlkWHGIw30bhN4=;
        b=n/W/Zt4keH38rCiYZfq6rrCiXYFnopXtNSqKXaJ6Vo30v8y61MxlIzkMvqOEMTpIDP
         nnHcX3PQUd11h07VNQAhwrJ3FrxzPiyMipI5+E9+w4AYrPrAe+Y6uQ1BbOH5dnssi9hN
         NWZliF1Def5CrxXOvA9kKeEKokFiftXU3wUqnEt+jT2JRm++wEB53OOuUGUYM1ncKIkt
         yFq7JVcjeNytoByuMuuj4qpLddk0c3vfVg9FFtRVpa7BxyGLwiZz02ylgUO5P9CVqZek
         hGrbc8CSBMVLcNn3ACrINDCOrDsE+6D5Q+FzRt2yKl0e2vOl4owTIeze2/T/lFK8eo2x
         +Ztw==
X-Gm-Message-State: APjAAAV5NsTSC2y3tTakPMuEv8WET+ZZwxYnvZz4M9NYDy0jRlUTLIh/
        OuEVdG3EINQgwxTX8eYJk51xxk8cf81Aj5lvbjw=
X-Google-Smtp-Source: APXvYqxq4KmKDj3pDHYdpmtLYyyUHmVZr8CQS2gK4J2CDzE4ivbWi++aFawMEADWVn/+QqgnnwuW1PQNzQrcK1Tku6s=
X-Received: by 2002:a2e:83d6:: with SMTP id s22mr19759114ljh.104.1568120200429;
 Tue, 10 Sep 2019 05:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567889743.git.jrdr.linux@gmail.com> <20190909154253.q55olcm4cqwh7izd@box>
In-Reply-To: <20190909154253.q55olcm4cqwh7izd@box>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 10 Sep 2019 18:26:28 +0530
Message-ID: <CAFqt6zZNHGdgaiiRvz-1AFe5g1652oyZpNQidK1V0B6weQHz0w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Remove __online_page_set_limits()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        osalvador@suse.com, Michal Hocko <mhocko@suse.com>,
        pasha.tatashin@soleen.com, Dan Williams <dan.j.williams@intel.com>,
        richard.weiyang@gmail.com, Qian Cai <cai@lca.pw>,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 9, 2019 at 9:12 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sun, Sep 08, 2019 at 03:17:01AM +0530, Souptick Joarder wrote:
> > __online_page_set_limits() is a dummy function and an extra call
> > to this can be avoided.
> >
> > As both of the callers are now removed, __online_page_set_limits()
> > can be removed permanently.
> >
> > Souptick Joarder (3):
> >   hv_ballon: Avoid calling dummy function __online_page_set_limits()
> >   xen/ballon: Avoid calling dummy function __online_page_set_limits()
> >   mm/memory_hotplug.c: Remove __online_page_set_limits()
> >
> >  drivers/hv/hv_balloon.c        | 1 -
> >  drivers/xen/balloon.c          | 1 -
> >  include/linux/memory_hotplug.h | 1 -
> >  mm/memory_hotplug.c            | 5 -----
> >  4 files changed, 8 deletions(-)
>
> Do we really need 3 separate patches to remove 8 lines of code?

I prefer to split into series of 3 which looks more clean. But I am ok
with other option.
Would you like to merge into single one ?
