Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9470E292869
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Oct 2020 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgJSNmM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Oct 2020 09:42:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34931 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgJSNmM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Oct 2020 09:42:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id q5so12936128wmq.0;
        Mon, 19 Oct 2020 06:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wSpB2OFgBLfQuSAeovcxEvz3XNecpxTvXJc2PkeLsE4=;
        b=GpyzoYYtQ52mAoPEgrG0fPsWbNCyRvY7DHPipAQnU721AIA9dHOlE3GArA4eoiZDYE
         WRdQ5WXNZA4Q6cPp/Di09z9pzbctN53erhBV95p+gesSS2w7KFMrxPtjSZ9kVskDk3AM
         Ujme+GqdDzo/vSGBFOmTNVYSASYjPH0XsxkBB7w8dIIMZvxEHAFSJmu14aDwHQruMCA0
         8QjsbeHiPSo94AhkMZRO5G91B3/l2yD/eGl7eZea2XhrV+YCQ6ZTEcsumFM2afpxwlVf
         WNaKcQqCXi68LpscNrOQhY/2M5lKCzkaYo/ZAFk7lamuMeYaYCLrtOCy0pL1J9iYLfyP
         NmxQ==
X-Gm-Message-State: AOAM5338Ev1CMscXok3d8YlwAGCCDm2689IC9zDoxDmYIDBkTkiBCnze
        k3zwNYtvPxl/1dnYS79yPl02lgVqKwg=
X-Google-Smtp-Source: ABdhPJyCvWUlYnVSgUusnxlmxtwtPBKYm9FsVfRurKRmwiPCqlhvjRkR3X4+gaFV0+37kiywaHzTtg==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr18528123wmb.9.1603114931205;
        Mon, 19 Oct 2020 06:42:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g83sm81381wmf.15.2020.10.19.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 06:42:10 -0700 (PDT)
Date:   Mon, 19 Oct 2020 13:42:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Olaf Hering <olaf@aepfle.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1] hv_balloon: disable warning when floor reached
Message-ID: <20201019134209.fgjlip52k5xayr2w@liuwe-devbox-debian-v2>
References: <20201008071216.16554-1-olaf@aepfle.de>
 <MW2PR2101MB1052BA9AB5DB8C11D7F9CE33D71E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052BA9AB5DB8C11D7F9CE33D71E0@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 19, 2020 at 03:02:22AM +0000, Michael Kelley wrote:
> From: Olaf Hering <olaf@aepfle.de> Sent: Thursday, October 8, 2020 12:12 AM
> > 
> > It is not an error if a the host requests to balloon down, but the VM
> 
> Spurious word "a"
> 
> > refuses to do so. Without this change a warning is logged in dmesg
> > every five minutes.
> > 
> > Fixes commit b3bb97b8a49f3
> 
> This "Fixes" line isn't formatted correctly.  Should be:
> 
> Fixes:  b3bb97b8a49f3 ("Drivers: hv: balloon: Add logging for dynamic memory operations")
> 
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > ---
> >  drivers/hv/hv_balloon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index 32e3bc0aa665..0f50295d0214 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -1275,7 +1275,7 @@ static void balloon_up(struct work_struct *dummy)
> > 
> >  	/* Refuse to balloon below the floor. */
> >  	if (avail_pages < num_pages || avail_pages - num_pages < floor) {
> > -		pr_warn("Balloon request will be partially fulfilled. %s\n",
> > +		pr_info("Balloon request will be partially fulfilled. %s\n",
> >  			avail_pages < num_pages ? "Not enough memory." :
> >  			"Balloon floor reached.");
> > 
> 
> Above nits notwithstanding,
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks. I see one for and no against so far.

I've applied this patch to hyperv-fixes. I also fixed those nits
while at it.

Wei.
