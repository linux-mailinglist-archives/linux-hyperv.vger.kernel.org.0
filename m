Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81F39B959
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 15:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFDNCE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 09:02:04 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54850 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFDNCE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 09:02:04 -0400
Received: by mail-wm1-f53.google.com with SMTP id o127so5326692wmo.4;
        Fri, 04 Jun 2021 06:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDvJ/P2CUwJS1UkHCdeZqkrV0wm/XZF87IhduHAN14A=;
        b=RBZor5KCG8k2VxOdSGGG9oZprsdpa1FM2ESJtcoGlzZ4+5gtOfai2nIJq53rC9fVeu
         MT8vCFA6UcRwM9GHwH4OMFDn69MkuOMbijBVJQ9Anwno027rhC1r4u4pUdGjwPrNyPPD
         e2NIEIGJ8N2dT2GuUooHVz4t3GV5joIZJGsuZZFkK3u/Mi0iaXNIWKDn8K5RAr63adQD
         T/Wryi/9NzI3l/p7L+5cSiVPBW+K5e1CbLGS7kzWiRynnn9/Io/fV2pPqDgxeS80T5bX
         sc3ZAH6xs7zO4vPc4lVXT0POnhkAVc46KxCN8J7KmCVBcneMKXkrsnKPgXDDX3cVbid/
         s3Gw==
X-Gm-Message-State: AOAM531ihE+767OX+yZsFtb5LZMloKDyU8lJzbEtD+jQYJpzGXHokwAN
        NcooDc4xjqSQYckrEudmBSOdJgvfXIw=
X-Google-Smtp-Source: ABdhPJyFEW9QabvckxrTXanJXK76Qm2nxTXcxOzdGCgtNeZIbg7MFr6vkW9qMHfgph8dhTL8s9wXuQ==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr3476024wmk.54.1622811617069;
        Fri, 04 Jun 2021 06:00:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f14sm6499240wry.40.2021.06.04.06.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:00:16 -0700 (PDT)
Date:   Fri, 4 Jun 2021 13:00:14 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, wei.liu@kernel.org,
        Dexuan Cui <decui@microsoft.com>, viremana@linux.microsoft.com
Subject: Re: [bug report] Commit ccf953d8f3d6 ("fb_defio: Remove custom
 address_space_operations") breaks Hyper-V FB driver
Message-ID: <20210604130014.tkeozyn4wxdsr6o2@liuwe-devbox-debian-v2>
References: <87v96tzujm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96tzujm.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 04, 2021 at 02:25:01PM +0200, Vitaly Kuznetsov wrote:
> Hi,
> 
> Commit ccf953d8f3d6 ("fb_defio: Remove custom address_space_operations")
> seems to be breaking Hyper-V framebuffer
> (drivers/video/fbdev/hyperv_fb.c) driver for me: Hyper-V guest boots
> well and plymouth even works but when I try starting Gnome, virtual
> screen just goes black. Reverting the above mentioned commit on top of
> 5.13-rc4 saves the day. The behavior is 100% reproducible. I'm using
> Gen2 guest runing on Hyper-V 2019. It was also reported that Gen1 guests
> are equally broken.
> 
> Is this something known?
> 

I've heard a similar report from Vineeth but we didn't get to the bottom
of this.

Wei.

> -- 
> Vitaly
> 
