Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E5E250027
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Aug 2020 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHXOvh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Aug 2020 10:51:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOvg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Aug 2020 10:51:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id a65so5023497wme.5;
        Mon, 24 Aug 2020 07:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QMn36lEK3PWC13P8wKJfZOwdzKidi6t+GQ3+6i3moX8=;
        b=Zk4nMaQdAYQf+dBcV3esM9orPtDaZJ5Cnctad9on217znwkESjCtX0t/UbqNRX/JN7
         8rjvMY1crZ/amx59m5xVQt6iv5nuMd4NAsqoPviAWzLQ/x8NHPQHAwAVxr6WxauJI0nt
         Cj4PE9tD0OCYP8OQA/oBT8mTUCc6iZXzjg+2k+lhaACW7q7UINIJXewOIojkAUYxgoL5
         g8Fbpf82xhn8HDQ3vcqEB25rq4wtR/7tnEYoQqZCmkYurTiUQ4hLngqWGeDV4andooif
         mf4C0Z3A7DrZZwGBehgOwfSQeoMxlTVPCpvRcRQw2GPx+gawb2CIRfDnB+0xU25etH1h
         Ev5Q==
X-Gm-Message-State: AOAM531srcvxcLEqlbWAvjvVswIDlD3iQ8uk/Uyydgq1WnAgX/q19JBZ
        sQEQVLYTV2KdAJO/EjDVToc=
X-Google-Smtp-Source: ABdhPJxZ1OSy6QCFnjyZqM2fx5OU5eEoiT/asN1k/mnsEFGosOLOX8Dh0tAYNL7lAOY1J1VkXA6thA==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr6002258wmq.60.1598280694559;
        Mon, 24 Aug 2020 07:51:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 5sm13898438wmz.22.2020.08.24.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:51:33 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:51:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] hv_utils: return error if host timesysnc update is
 stale
Message-ID: <20200824145132.bn73cw7j6hzhb7ml@liuwe-devbox-debian-v2>
References: <20200821152523.99364-1-viremana@linux.microsoft.com>
 <SN6PR2101MB10564B2EA3BC8082D76C50E6D75B0@SN6PR2101MB1056.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB10564B2EA3BC8082D76C50E6D75B0@SN6PR2101MB1056.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 03:44:24PM +0000, Michael Kelley wrote:
> From: viremana@linux.microsoft.com Sent: Friday, August 21, 2020 8:25 AM
> > 
> > If for any reason, host timesync messages were not processed by
> > the guest, hv_ptp_gettime() returns a stale value and the
> > caller (clock_gettime, PTP ioctl etc) has no means to know this
> > now. Return an error so that the caller knows about this.
> > 
> > Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > ---
> > 
> >  v2:
> >     - Fix warnings reported by Kernel test robot <lkp@intel.com>
> >     - s/pr_warn/pr_warn_once/
> > 
> > ---
> >  drivers/hv/hv_util.c | 46 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
