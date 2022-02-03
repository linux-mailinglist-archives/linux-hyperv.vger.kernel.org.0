Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1E4A83FB
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Feb 2022 13:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350576AbiBCMm6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 07:42:58 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:41815 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbiBCMm5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 07:42:57 -0500
Received: by mail-wm1-f44.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1761885wmb.0;
        Thu, 03 Feb 2022 04:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x5SP6wBXIEPK1p3rvS9+DT/uhtMpldQ/pITLaalWzLw=;
        b=BkpFmJqwJz2ysee2aWBOvg5aYAdb4B2kyqZ75ITDC0pELnyr0Inc0/Ad5oThqyQa3V
         Zpx1PBm9uPNogd30kux2cg3+SOvc/fenVulaad2ED8imb80jEDkS0TAykntmobrVxZ4b
         s/ret2/ISqUvnRtPl2ca+7hdY4u8DagxJgXRr3B/biggRy//JgKnuvE3T/r1uD43iwJ3
         q3/if4dTHIxgGFxZAeBQHQchGSeQZPrKMCUl+VY9d1HsyWSu+wvmvjJpSVkufSPPOGWa
         OYXmUqimvQeD/gYqMT75ySKAVrnRKCke/cmbTN8mUUeiZDY+BUj9OS5sA6YzTW4ufyNC
         5fUA==
X-Gm-Message-State: AOAM532l+edQ3sP4y2pYpmxoIhqx6S+ynqzAtGgAEhRptP8Nml7M9W/h
        shVcmauGXbRmUJ/nwNmIKGE=
X-Google-Smtp-Source: ABdhPJz6LM9E71WKtyNJnIR89p9hnohZGRBLXkhtiQ/1bQjjJgJxbCdLm/0Q9s1HlB9OkyJNf1CChA==
X-Received: by 2002:a05:600c:2741:: with SMTP id 1mr10407655wmw.50.1643892176074;
        Thu, 03 Feb 2022 04:42:56 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p7sm7421259wmq.20.2022.02.03.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 04:42:54 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:42:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] Drivers: hv: vmbus: Use struct_size() helper in
 kmalloc()
Message-ID: <20220203124253.h33oehbhninoadca@liuwe-devbox-debian-v2>
References: <20220125180131.GA67746@embeddedor>
 <MWHPR21MB1593A23CA620CEE3557023F8D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593A23CA620CEE3557023F8D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 27, 2022 at 04:01:28PM +0000, Michael Kelley (LINUX) wrote:
> From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Tuesday, January 25, 2022 10:02 AM
> > 
> > Make use of the struct_size() helper instead of an open-coded version,
> > in order to avoid any potential type mistakes or integer overflows that,
> > in the worst scenario, could lead to heap overflows.
> > 
> > Also, address the following sparse warnings:
> > drivers/hv/vmbus_drv.c:1132:31: warning: using sizeof on a flexible structure
> > 
> > Link: https://github.com/KSPP/linux/issues/174
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 17bf55fe3169..cd193456cd84 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1129,7 +1129,7 @@ void vmbus_on_msg_dpc(unsigned long data)
> >  	}
> > 
> >  	if (entry->handler_type	== VMHT_BLOCKING) {
> > -		ctx = kmalloc(sizeof(*ctx) + payload_size, GFP_ATOMIC);
> > +		ctx = kmalloc(struct_size(ctx, msg.payload, payload_size), GFP_ATOMIC);
> >  		if (ctx == NULL)
> >  			return;
> > 
> > --
> > 2.27.0
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next. Thanks.
