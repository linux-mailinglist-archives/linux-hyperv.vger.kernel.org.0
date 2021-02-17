Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9DF31DD40
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Feb 2021 17:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhBQQX1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Feb 2021 11:23:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234155AbhBQQX0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Feb 2021 11:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613578920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuOtIRKbYuj2Xd7iVcnrNwE+xcVixB8X3bMZPpVqG1k=;
        b=Cg8JMYC3PV8cBNK9Y1pnkCLO51CSwyMSZWlJiKElshxy9FjyMLs8fKLuXKn1KULb0EpQsW
        0bYdYS3osnKis0tnn6AI7MedsHgTwyVNJDOiQ6fRDYx0ggqUBheDiWBJQzm3dvSGxDC2Ot
        A5aM+0Xxny7ehQoJDSGejJAbg76Cy/o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-f5-mBwpmODOBojKPxoHxXw-1; Wed, 17 Feb 2021 11:21:58 -0500
X-MC-Unique: f5-mBwpmODOBojKPxoHxXw-1
Received: by mail-ed1-f69.google.com with SMTP id p12so1956875edw.9
        for <linux-hyperv@vger.kernel.org>; Wed, 17 Feb 2021 08:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zuOtIRKbYuj2Xd7iVcnrNwE+xcVixB8X3bMZPpVqG1k=;
        b=L/vi/TZk68fVO8oO9xcrFOR7xuUIoRbyWnG3cxQTJPnM/bBrhpqh39saKgVjagk90M
         KmweO16UhUbPZl4Olu2vxf/zgTX0HgDEqTDBgdQ1K1YXA7dwRRa8/6VdtBa3YKWvLnj/
         4k2MVVj1Si+oGHxnAYOzZjwQh4SeUyYcClmsT89yAjuTpKWGCGI6hvQWplaHVzfWmrmT
         ccE8TNRumWEv5586WzEnlAMkw2DRHwOLZrHuo1Cz5k71CKkQAFeVr63S0VO1e4l+VDPg
         FA9flLXl8R89lI7WaVMzDXTZhs1Xohk6Ecc1EN1K24RpvYWEotraMdx4Ha906l6p9QlZ
         1okQ==
X-Gm-Message-State: AOAM530tlwXevFv5nRBxbvzhIHTAmwAeb6lRO7BWu/lXg85OsLhQwLzx
        oalPoxHw5FRGbZ5FF0K423ZRksbjRgAY0UeljOV49PvQ+7Cpn5TQKuOTVSk5uINWUZPXlhKFjF1
        713EFThdAbU3pkjslwUQ4+11f
X-Received: by 2002:a17:907:9d6:: with SMTP id bx22mr7133374ejc.331.1613578917392;
        Wed, 17 Feb 2021 08:21:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQ1Ki1oJA1qfHwYHXxMOTvEPU2QJDOhm6xJnFyYpk+Q9lA7Rish8CnAdi9jZPvrrxRWt75yw==
X-Received: by 2002:a17:907:9d6:: with SMTP id bx22mr7133343ejc.331.1613578917141;
        Wed, 17 Feb 2021 08:21:57 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i10sm1203519ejy.64.2021.02.17.08.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:21:56 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Deepak Rawat <drawat.floss@gmail.com>,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
In-Reply-To: <20aead71c4aa3f640e19660875f807deae92f8d8.camel@gmail.com>
References: <20210216003959.802492-1-drawat.floss@gmail.com>
 <87k0r6kicg.fsf@vitty.brq.redhat.com>
 <20aead71c4aa3f640e19660875f807deae92f8d8.camel@gmail.com>
Date:   Wed, 17 Feb 2021 17:21:55 +0100
Message-ID: <87h7mak6l8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Deepak Rawat <drawat.floss@gmail.com> writes:

> On Wed, 2021-02-17 at 13:07 +0100, Vitaly Kuznetsov wrote:
>> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
>> > @@ -0,0 +1,51 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +/*
>> > + * Copyright 2012-2021 Microsoft
>> 
>> Out of pure curiosity, where does '2012' come from or what does it
>> mean?
>> 
>
> Thanks Vitaly for the review. Actually some of the code is derived from
> hyperv_fb, which has copyright 2012. Not sure if I should remove here
> or not?
>

I'm definitely not an expert (and couldn't quickly find a good
reference) here but I was under the impression that in such cases you
can just add a note like "based on 'hyperv_fb' driver" (if really
needed, if you just borrow a few things then it's even superfluous I
believe). Anyway, I was just a bit surprised to see '2012' in a new file
:-)

-- 
Vitaly

