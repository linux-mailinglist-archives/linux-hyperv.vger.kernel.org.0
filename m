Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768324975D3
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jan 2022 22:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiAWV4J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jan 2022 16:56:09 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35772 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAWV4J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jan 2022 16:56:09 -0500
Received: by mail-wr1-f52.google.com with SMTP id r14so10161166wrp.2;
        Sun, 23 Jan 2022 13:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkJFe+YpdQY4B8W9DqTO7FJ3H0EJ0x5TwT+iBVw2iXM=;
        b=KSeKjlhBhcm2ff2wysuzkBEqVY0FfqG8GkotEE7okGFte66MxjyOXgm/D0fvQzN4qY
         4SozoVwcadIspEPOyjPUyhcGdHIZ0q5K7h02/SRUQE8Omj3h16N+MwwVAEPXSwpVDa3v
         CHTmclWv0/WnpjdSayihNTU91xb/33v2Hwl8BMJqJulaKA/IfLyyXw+OuYyrqi4FSU9Z
         oKSwln06As8xO1SwDVGxwq405yBtMaF/XSZAXLZjIfwClxSfMbkA3yeZIYNV1Rs85h16
         uUuVF/wr8Mh6yPyv6VBhMCAjVoR9KVq9cUJOgb1Qj8akmcNilfuTN+ctWXvSHrnHbCdV
         kG0Q==
X-Gm-Message-State: AOAM532ESay871oXaBdJBnNjVm/rlWdl8KWw6NW6gFJNwr9QXqE64UVt
        vCz97N3FaUixnSfdxGLuxY0=
X-Google-Smtp-Source: ABdhPJwhnlwrjUsCsa0+KILQxWz6IQlGaxe4OdxYSDfPAdjw5uuWKbL38sD7/aPt9aqlGF50rVLWKA==
X-Received: by 2002:a05:6000:1a8e:: with SMTP id f14mr12188363wry.518.1642974967958;
        Sun, 23 Jan 2022 13:56:07 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i2sm2779615wmq.23.2022.01.23.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 13:56:07 -0800 (PST)
Date:   Sun, 23 Jan 2022 21:56:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Wei Hu <weh@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
        "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
        hhei <hhei@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] video: hyperv_fb: Fix validation of screen resolution
Message-ID: <20220123215606.fzycryooluavtar4@liuwe-devbox-debian-v2>
References: <1642360711-2335-1-git-send-email-mikelley@microsoft.com>
 <MN2PR21MB1295CE3BD15D4EB257A158DCCA569@MN2PR21MB1295.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR21MB1295CE3BD15D4EB257A158DCCA569@MN2PR21MB1295.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Jan 16, 2022 at 09:53:06PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Sunday, January 16, 2022 2:19 PM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> > Hemminger <sthemmin@microsoft.com>; wei.liu@kernel.org; Wei Hu <weh@microsoft.com>; Dexuan
> > Cui <decui@microsoft.com>; drawat.floss@gmail.com; hhei <hhei@redhat.com>; linux-
> > kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-fbdev@vger.kernel.org; dri-
> > devel@lists.freedesktop.org
> > Cc: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Subject: [PATCH 1/1] video: hyperv_fb: Fix validation of screen resolution
> > 
> > In the WIN10 version of the Synthetic Video protocol with Hyper-V,
> > Hyper-V reports a list of supported resolutions as part of the protocol
> > negotiation. The driver calculates the maximum width and height from
> > the list of resolutions, and uses those maximums to validate any screen
> > resolution specified in the video= option on the kernel boot line.
> > 
> > This method of validation is incorrect. For example, the list of
> > supported resolutions could contain 1600x1200 and 1920x1080, both of
> > which fit in an 8 Mbyte frame buffer.  But calculating the max width
> > and height yields 1920 and 1200, and 1920x1200 resolution does not fit
> > in an 8 Mbyte frame buffer.  Unfortunately, this resolution is accepted,
> > causing a kernel fault when the driver accesses memory outside the
> > frame buffer.
> > 
> > Instead, validate the specified screen resolution by calculating
> > its size, and comparing against the frame buffer size.  Delete the
> > code for calculating the max width and height from the list of
> > resolutions, since these max values have no use.  Also add the
> > frame buffer size to the info message to aid in understanding why
> > a resolution might be rejected.
> > 
> > Fixes: 67e7cdb4829d ("video: hyperv: hyperv_fb: Obtain screen resolution from Hyper-V
> > host")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
[...]
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
