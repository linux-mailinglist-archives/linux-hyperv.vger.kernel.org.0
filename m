Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828CC388272
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 May 2021 23:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhERVyn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 May 2021 17:54:43 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35633 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhERVym (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 May 2021 17:54:42 -0400
Received: by mail-wm1-f44.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so2332486wmk.0;
        Tue, 18 May 2021 14:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SbhE0iSK8kwkfF5k3gEa4k3XZSxzWdx+S3mqdnigAW8=;
        b=eniDNL53vm0q9RuEC3o/4F+pG8zWA0HPzumJXlY4JikNmGf5rtqIA3fUj9OphpoDMl
         GZtQnMj9XUQVf4XbFz3QiBfShjcMbYJ7AEP679WG+9NsxrzbXGsGdBaB1jteA9qckIpw
         obwA8M2UlK13D9bfHS51SCwveGIoywxOV6RoWjvLeoG7xAG45QXphi4WAPfS23tFRjP9
         WJ9F9GAqY5/ep6mB2uXxAdWMDWzSb71+GpwxW58AblD4YE7WergY8kZW0tuxpFKqiiO6
         HEv8VlM0pUVwnRS1fgrkohk24W+jTQD65uCp3fAsOu2saylcwcGTMIFfjxxg8Z3VGztO
         Nv5g==
X-Gm-Message-State: AOAM533rPKxQ/UaKfTLhfsVBQ/L89awGIiyO4GdqE+AB4q1ghdrnoXe5
        of0cR4xxOel+7zngWCoRavY=
X-Google-Smtp-Source: ABdhPJwRwSXIo1FB+tqxPueLwXz9QZqTF0wkAFEi/eP9dDOaopfPEWETvtcv3dozXk7g3ENAdxtsuA==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr7154705wmq.164.1621374801402;
        Tue, 18 May 2021 14:53:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c12sm3284407wrr.90.2021.05.18.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:53:21 -0700 (PDT)
Date:   Tue, 18 May 2021 21:53:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Long Li <longli@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
 paths
Message-ID: <20210518215319.yshxwkvxaxsv77bv@liuwe-devbox-debian-v2>
References: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
 <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
 <20210518110122.7jbktl6olsl75vqz@liuwe-devbox-debian-v2>
 <BY5PR21MB15069658A7DE04A863C75036CE2C9@BY5PR21MB1506.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR21MB15069658A7DE04A863C75036CE2C9@BY5PR21MB1506.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 18, 2021 at 09:50:17PM +0000, Long Li wrote:
> > Subject: Re: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
> > paths
> > 
> > Cc Long Li.
> > 
> > Long, Stephen suggested I check with you. Do you have any opinion?
> > 
> > Wei.
> > 
> > On Tue, May 11, 2021 at 09:52:27AM +0000, Wei Liu wrote:
> > > On Sun, May 09, 2021 at 09:13:03AM +0200, Christophe JAILLET wrote:
> > > > If 'vmbus_establish_gpadl()' fails, the (recv|send)_gpadl will not
> > > > be updated and 'hv_uio_cleanup()' in the error handling path will
> > > > not be able to free the corresponding buffer.
> > > >
> > > > In such a case, we need to free the buffer explicitly.
> > > >
> > > > Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until
> > > > first use")
> > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > ---
> > > > Before commit cdfa835c6e5e, the 'vfree' were done unconditionally in
> > > > 'hv_uio_cleanup()'.
> > > > So, another way for fixing the potential leak is to modify
> > > > 'hv_uio_cleanup()' and revert to the previous behavior.
> > > >
> > >
> > > I think this is cleaner.
> 
> Christophe has mentioned that the patch is already picked up by Greg KH.
> 
> I think both approaches are correct. We can go with this one.

OK. That's fine.

Wei.
