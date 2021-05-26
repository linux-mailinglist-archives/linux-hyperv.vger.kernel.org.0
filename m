Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8C39146E
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 May 2021 12:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhEZKJH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 May 2021 06:09:07 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37608 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhEZKJF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 May 2021 06:09:05 -0400
Received: by mail-wm1-f47.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so141185wmq.2;
        Wed, 26 May 2021 03:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zn2ffr8JYxoteRgfDN2DPfLGmOa7PHRalgcesR+84wk=;
        b=FBQswfXEvhcIPu6qtq1G30fehiRhU7qTR7FioWQKRPcItSITZlXr9VmE9StIWrL1uY
         XA35HflYt3m/Un4l1hJ/gyqpLYVUvPxENyTRph0T71Ok2tP4+i6s4g6Lzrf79uyZ2vQn
         1QGPAHk7HfSHqvktCTN/WRrGZwEvTJmhagbWOgomxEU9Ga9nKgdAo11qVNcIIjN7e4UA
         y+/fRlm//yV072iHGa7Z7QlZKue/uReT2DTe6sOMHkQmNSnNqZRhrUO+l9QSrx/vu1FS
         q9F0lVuvh39Fg9hIBUCNoUPiZ+ZwXIQXw6L7e8Xij4FFADk5M1AMu7EfOuk0aCGArRj/
         StPg==
X-Gm-Message-State: AOAM530GIoujEw1CaE4BB2tu9O1B8xQo0umP+VVF5QCVn/UOI8cJnjY1
        WxjcAv0q/r51oTfx+akdHlM=
X-Google-Smtp-Source: ABdhPJxPaM7KVevhYV2qeLsfVfVCCezJ/Fd6bhCABfmcYvL1i91n62q4G0bpOukUTdpNvhpJMehZTQ==
X-Received: by 2002:a05:600c:1551:: with SMTP id f17mr2489743wmg.17.1622023653000;
        Wed, 26 May 2021 03:07:33 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v3sm19745861wrr.19.2021.05.26.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:07:32 -0700 (PDT)
Date:   Wed, 26 May 2021 10:07:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: hv: Fix missing error code in vmbus_connect()
Message-ID: <20210526100730.fsk3khdqmpbbuljf@liuwe-devbox-debian-v2>
References: <1621940321-72353-1-git-send-email-jiapeng.chong@linux.alibaba.com>
 <MWHPR21MB1593D8362CD8FBA6E0E3612CD7259@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593D8362CD8FBA6E0E3612CD7259@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 25, 2021 at 03:30:22PM +0000, Michael Kelley wrote:
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com> Sent: Tuesday, May 25, 2021 3:59 AM
> > 
> > Eliminate the follow smatch warning:
> > 
> > drivers/hv/connection.c:236 vmbus_connect() warn: missing error code
> > 'ret'.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >  drivers/hv/connection.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > index 311cd00..5e479d5 100644
> > --- a/drivers/hv/connection.c
> > +++ b/drivers/hv/connection.c
> > @@ -232,8 +232,10 @@ int vmbus_connect(void)
> >  	 */
> > 
> >  	for (i = 0; ; i++) {
> > -		if (i == ARRAY_SIZE(vmbus_versions))
> > +		if (i == ARRAY_SIZE(vmbus_versions)) {
> > +			ret = -EDOM;
> >  			goto cleanup;
> > +		}
> > 
> >  		version = vmbus_versions[i];
> >  		if (version > max_version)
> > --
> > 1.8.3.1
> 
> I might have used -EINVAL instead of -EDOM as the error
> return value, but it really doesn't matter, and having a 
> return value that is unique in the function might be helpful.
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
