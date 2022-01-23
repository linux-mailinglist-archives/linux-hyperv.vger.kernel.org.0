Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71394975FD
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jan 2022 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbiAWWae (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jan 2022 17:30:34 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40845 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiAWWae (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jan 2022 17:30:34 -0500
Received: by mail-wm1-f47.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so9014143wma.5;
        Sun, 23 Jan 2022 14:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMH3aROspB/kgllwn4/SStZwIDe9KDuajbHnkcsYmUQ=;
        b=giK/dYEJjhuERGZ6h4zgx9yD6xZJ69QgyAcsd2BF30WmN3n++agcOLFnJuIo0xgAH5
         Db3rYSM8S0CQZhee7TK/3TzhUQrbqJ3+pRGqij+6XeyvtKJwsKm4IG/+QFktB53A+fRg
         H9W0EJZPf/ibgzrgw+ib1DnqyGtTuP/Lbt8kCXtEGyPCDqJ20FvInteXArP0S8HkZjM9
         N4w3crXkV2NC506uJivEPC1TGgDTPRT4FCmgGisUVdNaYsrTyoyI5TC9hMsGKlL40SI+
         U5W198+NqxYlMDAS+XGnCfj7t18tkbc9pgBtZaLx95mgyPQIAKbilgV37kM/KeL2bA1f
         rq9A==
X-Gm-Message-State: AOAM5314cxGISZeKK3vRT6t1SnlhR4KCwhoRoCsLbXQb/jAgoPoAej94
        e7MT3SxFCS6XTchZxFcUg1w=
X-Google-Smtp-Source: ABdhPJw9NDCc2PhiY0fqwi7UBdUEmkYOshWw6VstDZdEF0SSKkrBdnOtRGFJx0y/nPspBxYjZZpipw==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr9217508wmc.53.1642977032623;
        Sun, 23 Jan 2022 14:30:32 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y14sm6165356wrd.91.2022.01.23.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:30:32 -0800 (PST)
Date:   Sun, 23 Jan 2022 22:30:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Hu <weh@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
        "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
        hhei <hhei@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] video: hyperv_fb: Fix validation of screen resolution
Message-ID: <20220123223030.ijdzrunduww76jiq@liuwe-devbox-debian-v2>
References: <1642360711-2335-1-git-send-email-mikelley@microsoft.com>
 <MN2PR21MB1295CE3BD15D4EB257A158DCCA569@MN2PR21MB1295.namprd21.prod.outlook.com>
 <20220123215606.fzycryooluavtar4@liuwe-devbox-debian-v2>
 <MWHPR21MB1593ED650DA82BC3009F66CED75D9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593ED650DA82BC3009F66CED75D9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jan 23, 2022 at 10:27:56PM +0000, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Sunday, January 23, 2022 1:56 PM
> > 
> > On Sun, Jan 16, 2022 at 09:53:06PM +0000, Haiyang Zhang wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > > > Sent: Sunday, January 16, 2022 2:19 PM
> > > > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Stephen
> > > > Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org; Wei Hu
> > <weh@microsoft.com>; Dexuan
> > > > Cui <decui@microsoft.com>; drawat.floss@gmail.com; hhei <hhei@redhat.com>;
> > linux-
> > > > kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> > fbdev@vger.kernel.org; dri-
> > > > devel@lists.freedesktop.org
> > > > Cc: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > > > Subject: [PATCH 1/1] video: hyperv_fb: Fix validation of screen resolution
> > > >
> > > > In the WIN10 version of the Synthetic Video protocol with Hyper-V,
> > > > Hyper-V reports a list of supported resolutions as part of the protocol
> > > > negotiation. The driver calculates the maximum width and height from
> > > > the list of resolutions, and uses those maximums to validate any screen
> > > > resolution specified in the video= option on the kernel boot line.
> > > >
> > > > This method of validation is incorrect. For example, the list of
> > > > supported resolutions could contain 1600x1200 and 1920x1080, both of
> > > > which fit in an 8 Mbyte frame buffer.  But calculating the max width
> > > > and height yields 1920 and 1200, and 1920x1200 resolution does not fit
> > > > in an 8 Mbyte frame buffer.  Unfortunately, this resolution is accepted,
> > > > causing a kernel fault when the driver accesses memory outside the
> > > > frame buffer.
> > > >
> > > > Instead, validate the specified screen resolution by calculating
> > > > its size, and comparing against the frame buffer size.  Delete the
> > > > code for calculating the max width and height from the list of
> > > > resolutions, since these max values have no use.  Also add the
> > > > frame buffer size to the info message to aid in understanding why
> > > > a resolution might be rejected.
> > > >
> > > > Fixes: 67e7cdb4829d ("video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V
> > > > host")
> > > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > [...]
> > >
> > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > >
> > 
> > Applied to hyperv-fixes. Thanks.
> 
> This fix got pulled into the fbdev/for-next tree by a new maintainer, Helge Deller.
> See https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?h=for-next&id=bcc48f8d980b12e66a3d59dfa1041667db971d86

OK. I will drop it from hyperv-fixes. Thanks for letting me know!

> 
> Michael
