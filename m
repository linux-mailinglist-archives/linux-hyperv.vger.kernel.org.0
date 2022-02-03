Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E364A8404
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Feb 2022 13:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350594AbiBCMof (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 07:44:35 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43880 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbiBCMoe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 07:44:34 -0500
Received: by mail-wr1-f53.google.com with SMTP id v13so4783291wrv.10;
        Thu, 03 Feb 2022 04:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZlDANBg8wtpYScLYNXpiG1g2vosLAsPJz+6F0F4e/aM=;
        b=AhLkQ/gBYJp8TXJY5NBd/OHGCkdinSoI+9wLAnt8u3Ad8wbeCb8ToiavL04Wcrywcl
         VLkKd9+u9WCD1QFPPGTCGAFyVnyp/xqljfxutNvhibVk0+DAPTqOSrtKcodL+wBFO+4R
         efVHk99v+TkyEPpZ/9CyB/FROgEr1vKxA6Bki8bihsOZd1BdmoAeOQip3cLztt1cnOq/
         B8zYtTSjgD+zonLeMK+OEa7TLnjGsnJZ+Nh4c8OigJmwWCiMApW0BoZv7aTnDoq3FaNP
         dh27D7zjCYJgaWZcwX9HbO3Op1cErnskUNoVViBLlQ6des12M+MDq1PG1IweeuM25qMK
         5hWQ==
X-Gm-Message-State: AOAM5338dYdIBuCmzGIQUuEJ9hF6yJYF77sMNWfPyoisG9PIX+DRs2/Z
        LCWiSl2lWbiOVXAS9n2MJINPCyC4hlI=
X-Google-Smtp-Source: ABdhPJzkLESlMMmTGPXnRe8kDR1YpflsCdfVruJ1JJrS+ZzU+xhhRyf73fd6Xs5lvJjY5f3YOrcGgA==
X-Received: by 2002:a05:6000:109:: with SMTP id o9mr28379301wrx.567.1643892273839;
        Thu, 03 Feb 2022 04:44:33 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v8sm6782133wmd.44.2022.02.03.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 04:44:33 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:44:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Juan Vazquez <juvazq@linux.microsoft.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix memory leak in
 vmbus_add_channel_kobj
Message-ID: <20220203124432.ckvfzgyyg6fqe2pm@liuwe-devbox-debian-v2>
References: <20220126055247.8125-1-linmq006@gmail.com>
 <20220128215604.xuqdpnnn4yjqfaoy@surface>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220128215604.xuqdpnnn4yjqfaoy@surface>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jan 28, 2022 at 01:56:04PM -0800, Juan Vazquez wrote:
> On Wed, Jan 26, 2022 at 05:52:46AM +0000, Miaoqian Lin wrote:
> > kobject_init_and_add() takes reference even when it fails.
> > According to the doc of kobject_init_and_add()：
> > 
> >    If this function returns an error, kobject_put() must be called to
> >    properly clean up the memory associated with the object.
> > 
> > Fix memory leak by calling kobject_put().
> > 
> > Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 17bf55fe3169..9e055697783b 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -2028,8 +2028,10 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
> >  	kobj->kset = dev->channels_kset;
> >  	ret = kobject_init_and_add(kobj, &vmbus_chan_ktype, NULL,
> >  				   "%u", relid);
> > -	if (ret)
> > +	if (ret) {
> > +		kobject_put(kobj);
> >  		return ret;
> > +	}
> >  
> >  	ret = sysfs_create_group(kobj, &vmbus_chan_group);
> If sysfs_create_group() fails same cleanup I think is required.
> 
> Later kobject_uevent() may fail according to doc, but there is no error
> handling, maybe a good moment to consider adding it and do same cleanup.

Miaoqian, are you going to post a new version to address Juan's comment
here?

Thanks,
Wei.

> >  
> > -- 
> > 2.17.1
