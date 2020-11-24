Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1465B2C3179
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 20:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgKXTyS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 14:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgKXTyR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 14:54:17 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6736DC0613D6;
        Tue, 24 Nov 2020 11:54:17 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id d18so61395edt.7;
        Tue, 24 Nov 2020 11:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YUqJtEzZnkyjVYlbVQeD/8IDUWyftG823MVWyY04nkY=;
        b=exJ9xfL/8TdXx4LAThv/BeOWEoUifAPCb2zqd1Lg+hQT+KFBHoTZJIhl5Mp+ZI8sby
         Ddqn63Xh1m2UkHVQVqSQqpSORGnq2dkVa1BGIWwUG2etfo01hcgwzifO/pu49y/mTDFk
         R8+nlOFqU/3J/waf4M4VtFg/lw9w7RSTyxBpyaAkErF4u9OrpVfgeSMiGdHtcJcGzaa8
         y9ZO+lgRR2GVDzjQeah61y5QHqZUKbxU61F0+qCsWQkO9AYqPmRbd2PZ/O8jQ/4fsjX0
         +etkumg3aiuXZZvsKgU9+E1bH+mIDBx4CD2zZUfNyrxO36IUWYgqcUtd6FUZe0BRfcYn
         6Ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YUqJtEzZnkyjVYlbVQeD/8IDUWyftG823MVWyY04nkY=;
        b=gvuS7rQPk8UO7aOJcgclqRnr3hMGp7Ly29owNwrzKkd11qtJVmxqjBqoxtfpZZVtj+
         hw/7vNJ2J2gjhUjNPHiLIUY+6n2G2jibtYsyorgTWszXqQwOZZSpt8Lt1MRuu0IiUNYs
         hA9AqKxXjYTYkbbtVTiGWo0k5c5mpCaNNFfxrDII6Dg/EyUsmOuLCxHU072nZhUv3rNx
         AAXNnScpL0/IfweBDn78lKmux5h13Fkxvf4sWlPrmbSONdEOsVuXQYyF5yLf2UHIN9DQ
         yWyG7h23yzVoAPai03F8sIfmdWNWVCqne9D1Of0Pw1W2yTe+xbFBAm84dGHjLk6s/UM/
         GUAQ==
X-Gm-Message-State: AOAM531rdR464yudZ5i17hEuUI/Hx6dmf94VnAtQvCOC4KvAFVgzpK9/
        4tSdFrVC8BQynPq8oy5eD5E=
X-Google-Smtp-Source: ABdhPJyVDp/f3ARNUlAFZD6zRmCIOTbB6QxLFeONkICMZnjar+6iP+iZma5tBGXcaCa7SvGCog4Edw==
X-Received: by 2002:a05:6402:cbb:: with SMTP id cn27mr93733edb.275.1606247655959;
        Tue, 24 Nov 2020 11:54:15 -0800 (PST)
Received: from andrea (host-82-51-6-75.retail.telecomitalia.it. [82.51.6.75])
        by smtp.gmail.com with ESMTPSA id f19sm7527614edm.70.2020.11.24.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:54:13 -0800 (PST)
Date:   Tue, 24 Nov 2020 20:54:07 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH 4/6] Drivers: hv: vmbus: Avoid use-after-free in
 vmbus_onoffer_rescind()
Message-ID: <20201124195407.GA16042@andrea>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-5-parri.andrea@gmail.com>
 <20201124162633.n7zlpte6f7zfhn6z@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124162633.n7zlpte6f7zfhn6z@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 24, 2020 at 04:26:33PM +0000, Wei Liu wrote:
> On Wed, Nov 18, 2020 at 03:36:47PM +0100, Andrea Parri (Microsoft) wrote:
> > When channel->device_obj is non-NULL, vmbus_onoffer_rescind() could
> > invoke put_device(), that will eventually release the device and free
> > the channel object (cf. vmbus_device_release()).  However, a pointer
> > to the object is dereferenced again later to load the primary_channel.
> > The use-after-free can be avoided by noticing that this load/check is
> > redundant if device_obk is non-NULL: primary_channel must be NULL if
> 
> device_obk -> device_obj

Fixed.


> 
> > device_obj is non-NULL, cf. vmbus_add_channel_work().
> > 
> 
> Missing a Fixes tag?

Yes, I've added the tag.

Thanks,
  Andrea
