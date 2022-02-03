Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02F04A840E
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Feb 2022 13:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiBCMtE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 07:49:04 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38665 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiBCMtD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 07:49:03 -0500
Received: by mail-wr1-f48.google.com with SMTP id s10so2274461wra.5;
        Thu, 03 Feb 2022 04:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgOz15GiL1CkuUHrLhFS1yIV2UrJIYsqMV6jtWTXCug=;
        b=SDWMl2gmlK0bdpflfSfljPSSZIV0f6syOKR8C13rdzN9KHhM8vuRm1OfeR0D7/4v2z
         xwIfQytFHXNfzX+yNbgluIxrlow+evzZQK+inWkLQ3PeTSEr5bWbct3IZJtm3V8GKeYp
         JzhP46ckvGbJuramcL1D2x239BAmnxmh1sl31ZE5Fj3+eZMtpCOlaeKAjZOswTG/4xE3
         Fx+iMYgp2kNBYdHEWgKswFNDyG1LXvoeOYonLHRnBEI09bPMOa5rVcPWBXvGMwgRpOMd
         H1EYsGfFyeiRS8YPWnOp9+1hp+imK9mqX8W66jMvG4ElGPkH9edqUZIJ1M0aMua21Zhl
         PpMg==
X-Gm-Message-State: AOAM5332OBkh6abdZDMVwHdWdmqBx9ME9NWsoKd6qzDfaoRT7X8/U12R
        y2XpK5uGRpKRhbehar2YZTc=
X-Google-Smtp-Source: ABdhPJxWHaLISVc08mxy3JG39Bd6KRLInrpGP+d3UJ43tCP5BEMbwfD9TecR2xs7oZaTVYfDzSPexA==
X-Received: by 2002:adf:90ec:: with SMTP id i99mr30258180wri.484.1643892542539;
        Thu, 03 Feb 2022 04:49:02 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u7sm7076680wmc.11.2022.02.03.04.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 04:49:02 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:49:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 0/2] Drivers: hv: Minor cleanup around init_vp_index()
Message-ID: <20220203124900.b65wpssjgoxvkva3@liuwe-devbox-debian-v2>
References: <20220128103412.3033736-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128103412.3033736-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jan 28, 2022 at 11:34:10AM +0100, Vitaly Kuznetsov wrote:
> Two minor changes with no functional change intended:
> - s,alloced,allocated
> - compare cpumasks and not their weights
> 
> Vitaly Kuznetsov (2):
>   Drivers: hv: Rename 'alloced' to 'allocated'
>   Drivers: hv: Compare cpumasks and not their weights in init_vp_index()

Series applied to hyperv-next. Thanks.

> 
>  drivers/hv/channel_mgmt.c | 19 +++++++++----------
>  drivers/hv/hyperv_vmbus.h | 14 +++++++-------
>  drivers/hv/vmbus_drv.c    |  2 +-
>  3 files changed, 17 insertions(+), 18 deletions(-)
> 
> -- 
> 2.34.1
> 
