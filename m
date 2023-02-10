Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB968691AFF
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Feb 2023 10:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjBJJNY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Feb 2023 04:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjBJJNT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Feb 2023 04:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F5A37719
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Feb 2023 01:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676020356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcP66+mGB/CMJ6FBAYQszDN0y7xiLuPs6RLt7XSk6h4=;
        b=L7R3lZ9yY+05VL/Ia7Qfxq+414Sl4qxNQAgHETI9u+t8IlpGcwED3CpzlpiP/ph+spPTDW
        xedqKyrsF0EFZEoIWcfUiviZaEFJ4s6gLIdZquTyXIJZfpi+ZsPlppIenYQPa0WgVhsex3
        sIHvD+ibqNodQaEdCKQUGcIzGH6BVtA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-494-I4nvWh-YPn6tDQj_-iCznA-1; Fri, 10 Feb 2023 04:12:34 -0500
X-MC-Unique: I4nvWh-YPn6tDQj_-iCznA-1
Received: by mail-ot1-f69.google.com with SMTP id j60-20020a9d17c2000000b0068bd57aa53aso2029197otj.17
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Feb 2023 01:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcP66+mGB/CMJ6FBAYQszDN0y7xiLuPs6RLt7XSk6h4=;
        b=h9qpvoBghfWPu82/GdZ3RrCijPLM3wySy1fJZEaZ2YICb5qLo5bdoUBuerWKgn4+wH
         JQTpkusknT5q9OhCct4mjUPTHhQIw0g2Lsbxvpq8+kL16IxFsvNJnBqMnnru2jDq854G
         iDJrn8RAjzSNbKyQALO+BjpZr/h4AkT2qGluvdZrf2AS5ksqnHZQCadG9jXKkPkn1rbW
         8mFiIyX+vcABm0IToS8N5dIA2LEJsjWRfNPRvuvE5cHbcjGsfNxcvk8t0LsYXZRkOIRn
         NN6ij7dFvB20YMQxEMEuEpl2bo5xarQhFKJBhO87qmBZd4dx1tzp5Fxkcsa1PlVZ83Ru
         FQpA==
X-Gm-Message-State: AO0yUKXdYplqS+38JLv17rKrIliOjwYQYNfmXsPXICf/I/RUyy3d99rN
        mm16yqR8i/ahkfrwys1632/+GrApleL2eKnUuBk/nu8Ass7GLoB1IXBR4OqrRgx+PhjnAqbZTqH
        k0zh1c+sapFwh6Kz9X5Scyi66gg9OzCFHHVENu8WyB9TIuj1wDwE=
X-Received: by 2002:a05:6870:430a:b0:163:707c:124b with SMTP id w10-20020a056870430a00b00163707c124bmr1433050oah.10.1676020352824;
        Fri, 10 Feb 2023 01:12:32 -0800 (PST)
X-Google-Smtp-Source: AK7set/EJegEsENM7V+m6+Jtg5jDiE8FG91FQzXNEck4ZneudY944xVQOFHoTIleaV0uNM8rOEg5Qfg0KDD0d1rTVyw=
X-Received: by 2002:a05:6870:430a:b0:163:707c:124b with SMTP id
 w10-20020a056870430a00b00163707c124bmr1433042oah.10.1676020352597; Fri, 10
 Feb 2023 01:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20230208113424.864881-1-mgamal@redhat.com> <SA1PR21MB1335F1074908B3E00DFA21BDBFD89@SA1PR21MB1335.namprd21.prod.outlook.com>
 <CAG-HVq8GYwCYBgiBnjO8ca5M27j6-MPK3e9H_c+EPmyotmOHxw@mail.gmail.com>
 <CAG-HVq9KWPRhy3X1E8vs_0y7xeJFBA-hZ5u6Vxh7H9Tu=gV9WA@mail.gmail.com> <SA1PR21MB13352C415EE6A3E9D3072991BFDE9@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB13352C415EE6A3E9D3072991BFDE9@SA1PR21MB1335.namprd21.prod.outlook.com>
From:   Mohammed Gamal <mgamal@redhat.com>
Date:   Fri, 10 Feb 2023 11:12:21 +0200
Message-ID: <CAG-HVq9bYLv_whkNekuuNQsA0htBxM-jvS=NvDH9NB7bGfnw3A@mail.gmail.com>
Subject: Re: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        parri.andrea@gmail.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        wei.liu@kernel.org, Xiaoqiang Xiong <xxiong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

(Re-CC'ing people from the old thread)

On Fri, Feb 10, 2023 at 4:57 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Mohammed Gamal <mgamal@redhat.com>
> > Sent: Thursday, February 9, 2023 1:48 AM
> >  ...
> > > We saw this when triggering a crash with kdump enabled with
> > > echo 'c' > /proc/sysrq-trigger
> > >
> > > When the new kernel boots, we see this stack trace:
>
> Thanks for the details. Kdump is special in that the 'old' VMBus
> channels might still be active (from the host's perspective),
> when the new kernel starts to run.
>
> Upon crash, Linux sends a CHANNELMSG_UNLOAD messge to the host,
> and the host is supposed to quiesce/reset the VMBus devices, so
> normally we should not see a crash in relid2channel().

Does this not happen in the case of kdump? Shouldn't a CHANNELMSG_UNLOAD
message be sent to the host in that case as well?

>
> > > [   21.906679] Hardware name: Microsoft Corporation Virtual
> > > Machine/Virtual Machine, BIOS 090007  05/18/2018
>
> I guess you see the crash because you're running an old Hyper-V,
> probably Windows Server 2016 or 2019, which may be unable to
> reliably handle the guest's CHANNELMSG_UNLOAD messge.

We've actually seen this on Windows Server 2016, 2019, and 2022.

>
> Can you please mention kdump in the commit message?
>

Will do.

> BTW, regarding "before vmbus_connect() is called ", IMO it
> should be "before vmbus_connect() is called or before it finishes".

