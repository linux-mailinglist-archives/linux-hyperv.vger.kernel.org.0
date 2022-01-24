Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F51498114
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jan 2022 14:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbiAXNbX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Jan 2022 08:31:23 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37696 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiAXNbX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Jan 2022 08:31:23 -0500
Received: by mail-wr1-f51.google.com with SMTP id w11so1460969wra.4;
        Mon, 24 Jan 2022 05:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1L2Rdz570mj3uqEMkrYEWll3QovuaRRvHlpZ4r9ZnA=;
        b=bhb72u64kN2DaaiDRKBm3srYQbPkbni6QUQsNrC6jrwypyAiZXJSO//IsgYjMs7BZF
         36NU9jthShdIvrjvG1OpNoIJCYrDUJq+YIPXxQt8pJij3jD3OQgQ6f6x1PhMFpy00pEU
         dXzoUUETdDYIiHDfd4xUsmUgVnK5mPphq2yh070bsjlEYHpq9qoC7Bi15wZcPSBkHqbi
         /cf5EwQ3Bk+P26w1SwuXu/naXwdEbUL+eHvj59NvYKboFBmHxc8ZHsKOOspAuAQFdyB1
         J+duMHJVyuLBny6yCYMrtYERcAgan+DqjK9bH309hA6xMMw9UN4AZt6aN5ejMILLbgtH
         pxBQ==
X-Gm-Message-State: AOAM530RswOWfhGGm8ovIseSEm6eLokz/M9f2bNNdMwGPaMnblA85Okh
        cmLZVYLklQ1w2u0UoTjFr84=
X-Google-Smtp-Source: ABdhPJwkDMc9NJe+pdTdSaDdZePRKMNgaZ3acGP1cCDaMSrKMK6SWMU13FrrulxNnCj36uSV8RHdvg==
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr14356855wrt.93.1643031081599;
        Mon, 24 Jan 2022 05:31:21 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o3sm14101129wrq.70.2022.01.24.05.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 05:31:21 -0800 (PST)
Date:   Mon, 24 Jan 2022 13:31:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
Message-ID: <20220124133119.3yxfr7ypmmdotm6h@liuwe-devbox-debian-v2>
References: <1642360711-2335-1-git-send-email-mikelley@microsoft.com>
 <MN2PR21MB1295CE3BD15D4EB257A158DCCA569@MN2PR21MB1295.namprd21.prod.outlook.com>
 <20220123215606.fzycryooluavtar4@liuwe-devbox-debian-v2>
 <MWHPR21MB1593ED650DA82BC3009F66CED75D9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220123223030.ijdzrunduww76jiq@liuwe-devbox-debian-v2>
 <e396a22d-7e0e-73a4-d831-f69dc854bfa8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e396a22d-7e0e-73a4-d831-f69dc854bfa8@gmx.de>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 24, 2022 at 10:52:22AM +0100, Helge Deller wrote:
> On 1/23/22 23:30, Wei Liu wrote:
> > On Sun, Jan 23, 2022 at 10:27:56PM +0000, Michael Kelley (LINUX) wrote:
> >> From: Wei Liu <wei.liu@kernel.org> Sent: Sunday, January 23, 2022 1:56 PM
> >>>
> >>> On Sun, Jan 16, 2022 at 09:53:06PM +0000, Haiyang Zhang wrote:
> >>>>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> >>>>> Sent: Sunday, January 16, 2022 2:19 PM
> >>>>> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> >>> <haiyangz@microsoft.com>; Stephen
> >>>>> Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org; Wei Hu
> >>> <weh@microsoft.com>; Dexuan
> >>>>> Cui <decui@microsoft.com>; drawat.floss@gmail.com; hhei <hhei@redhat.com>;
> >>> linux-
> >>>>> kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> >>> fbdev@vger.kernel.org; dri-
> >>>>> devel@lists.freedesktop.org
> >>>>> Cc: Michael Kelley (LINUX) <mikelley@microsoft.com>
> >>>>> Subject: [PATCH 1/1] video: hyperv_fb: Fix validation of screen resolution
> >>>>>
> >>>>> In the WIN10 version of the Synthetic Video protocol with Hyper-V,
> >>>>> Hyper-V reports a list of supported resolutions as part of the protocol
> >>>>> negotiation. The driver calculates the maximum width and height from
> >>>>> the list of resolutions, and uses those maximums to validate any screen
> >>>>> resolution specified in the video= option on the kernel boot line.
> >>>>>
> >>>>> This method of validation is incorrect. For example, the list of
> >>>>> supported resolutions could contain 1600x1200 and 1920x1080, both of
> >>>>> which fit in an 8 Mbyte frame buffer.  But calculating the max width
> >>>>> and height yields 1920 and 1200, and 1920x1200 resolution does not fit
> >>>>> in an 8 Mbyte frame buffer.  Unfortunately, this resolution is accepted,
> >>>>> causing a kernel fault when the driver accesses memory outside the
> >>>>> frame buffer.
> >>>>>
> >>>>> Instead, validate the specified screen resolution by calculating
> >>>>> its size, and comparing against the frame buffer size.  Delete the
> >>>>> code for calculating the max width and height from the list of
> >>>>> resolutions, since these max values have no use.  Also add the
> >>>>> frame buffer size to the info message to aid in understanding why
> >>>>> a resolution might be rejected.
> >>>>>
> >>>>> Fixes: 67e7cdb4829d ("video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V
> >>>>> host")
> >>>>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> >>> [...]
> >>>>
> >>>> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> >>>>
> >>>
> >>> Applied to hyperv-fixes. Thanks.
> >>
> >> This fix got pulled into the fbdev/for-next tree by a new maintainer, Helge Deller.
> >> See https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?h=for-next&id=bcc48f8d980b12e66a3d59dfa1041667db971d86
> >
> > OK. I will drop it from hyperv-fixes. Thanks for letting me know!
> 
> Linus hasn't pulled my tree yet, and he will probably not before the
> next merge window. So, if this is an urgent bugfix for you, I can offer
> to drop it from the fbdev tree and that you take it through the hyperv-fixes tree.
> In that case you may add an Acked-by: Helge Deller <deller@gmx.de>.
> Just let me know what you prefer.

Hi Helge

Yes, I would like to upstream it as soon as possible so that it can
propagate to stable trees and be backported by downstream vendors.

I will pick it up in hyperv-fixes. Please drop it from your for-next
tree.

Thanks,
Wei.

> 
> Helge
