Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948B9204D97
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2020 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgFWJML (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 Jun 2020 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbgFWJMK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 Jun 2020 05:12:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8325C061573
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Jun 2020 02:12:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h22so1281230pjf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Jun 2020 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Kz9xCuMfQVP8nB4fJb2cy6sQoAcFe32EC7VXfNzfbBo=;
        b=GmOJj0S22ctiemlOSVI1mu09vrvzTcMTOVbSfvHqpVUqYGi8Rl/n4+HYz4i0KsJ16K
         Gno6hAprmJPOqGa5FjXe5eY4lx53+o4j6nDnmoZs5PGfl3GaXNwANwmhHaIQwvFWoUxy
         Kbfs6w5fulPRHzgMoCMa3rpVRGyND9kUIz9+KwW2JmXS65PsJlOHfYCmO0e7KNAIA0ML
         5jF+BFZ+gyJIkHA1lQ389pf0MJ3EwbLsC6vzRvAcM+2i6RXF5EvBSmjNbCjKNfmPYqOv
         xsBBUub/H8YO790+32pIDtp6qCZ4yHGKRsv06XealLSKAnoYkAz+Nm8OgdurLgXDYe+/
         Cm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Kz9xCuMfQVP8nB4fJb2cy6sQoAcFe32EC7VXfNzfbBo=;
        b=nXLKYv6iM2OZze6aKjSjpwpUOOvwCF5FFvjctoJbOYSx0YfT5aACRohe+FxCoUQS1Z
         ozM1ALo3sLvfS/SHacoVH2gC0Edm/uzCE0gjCy4V66R9sGiIpH3J1DWvFtDkPm7XoXEq
         gnK6dAA8uc5qPMEgUWxcGka5vhF0SKak40IGEVSY6tfz+n7n5bhN7zeTItDFE4RpmMPm
         MVh7l3NWJQ3gs1rRJi1KHMo3jOMWIJ2l/GfcLoivBvmPIXQ6G9yQ+lQn0mKjg1VHylyj
         W5H8JSIY8kNm0vpeQCD/glm78lRZGd8zjNWq+DrxDY/jjU8PG3h3MZljh5iJeHDFJlE6
         6SIQ==
X-Gm-Message-State: AOAM533WG+FWeXQnZCfkaybK7voqWVQEpyhrnq1gAq1W2dteZKU7/N38
        EQINpqwPtXbd7A+Hcekk/4I=
X-Google-Smtp-Source: ABdhPJylBD/b7fqsA2zzHIbwr8UEOxTZkL37GEcCozzLqn0bt20VLNTUvoD3HAft0y+BZdcBzWjXLw==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr23374362pjy.37.1592903530289;
        Tue, 23 Jun 2020 02:12:10 -0700 (PDT)
Received: from arch ([2601:600:9500:4390::aa23])
        by smtp.gmail.com with ESMTPSA id z9sm1811156pjr.39.2020.06.23.02.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:12:09 -0700 (PDT)
Message-ID: <2699290fb7ab566987da8f648a9234c6a4fbc24e.camel@gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Airlie <airlied@linux.ie>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, dri-devel@lists.freedesktop.org,
        Michael Kelley <mikelley@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Wei Hu <weh@microsoft.com>, K Y Srinivasan <kys@microsoft.com>
Date:   Tue, 23 Jun 2020 02:12:09 -0700
In-Reply-To: <ea38c268-01e6-e43e-343d-a413142d450f@suse.de>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
         <20200622110623.113546-2-drawat.floss@gmail.com>
         <20200622151913.GA655276@ravnborg.org>
         <ea38c268-01e6-e43e-343d-a413142d450f@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 2020-06-23 at 09:59 +0200, Thomas Zimmermann wrote:
> Hi Deepak
> 
> I did not receive you pat series, so I can only comment on Sam's
> reply.
> See below for some points.

Hi Thomas, Thanks for the review. I wanted to add you in cc list but
messed it up with final git send-email. Sorry about that. I am not sure
why you didn't received it via dri-devel. The patch series do show up
in dri-devel archive. I wonder if other people also have similar
issues.


> > > 
> > > +	struct hv_device *hdev;
> > > +};
> > > +
> > > +#define to_hv(_dev) container_of(_dev, struct hyperv_device,
> > > dev)
> 
> Could this be a function?

Is there a reason to use a function here?

> 
> > > +
> > > +/* -----------------------------------------------------------
> > > ----------- */
> > > +/* Hyper-V Synthetic Video
> > > Protocol                                       */
> 
> The comments look awkward. Unless this style has been used within
> DRM,
> maybe just use
> 
>  /*
>   * ...
>   */
> 

This style is copy-paste from cirrus, and bochs also have same style.
Perhaps historical. Anyway I agree to I should get rid of this.


