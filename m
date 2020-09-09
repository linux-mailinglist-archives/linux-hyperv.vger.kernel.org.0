Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA24B262E21
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Sep 2020 13:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIILqF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Sep 2020 07:46:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33002 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgIILpZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Sep 2020 07:45:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id e11so1658418wme.0;
        Wed, 09 Sep 2020 04:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXoG8q5ed4XfWQ3Dzmu5hYVDZuDpMKCum26BXIBxJ60=;
        b=Dxgh49/fpUtpYueRVoJ53/eHoZkjHiSdzsoIwFf6J2MLCAoBQTM8tE/keaLpaXqYNQ
         SHzXHY7sso7M4FVK23KmUAUggnYJZxIEvIyGe1iZaE5znKgK5+6NcBlZT/kxnn6bkN+i
         YPb7ht3We1KNPrusjcIzf0f0OCFNEsu38Sdotms7OAy0HylMjztbfx3+nEkGfEbw9jkI
         QU81ObXohN3WoMaB3lko3t/zl4VE7W2ynAepFBuleI3iHqasnPSUnk7tnOmnKGiKvAgb
         SxmelVs1Rf3hMb3bmdNHgz2bmn1r0pD1N6KafhUC0aFA8mqNxt5FBRmyrD00E8OoD6KH
         u+fQ==
X-Gm-Message-State: AOAM532zgbw4p1ea0K5acka9ETS3Vn+ieneEd5BVfuHeYzclsafgM8Rc
        ZJjM3RVD6FtnibfcQ386D2Yi3hULWkE=
X-Google-Smtp-Source: ABdhPJwRwoXoUtaCWApFPVRqDFMXzGia8naxYrrD7VA8gMVZpqLFW7kaX7pbsSAAErAck1wAGhUKhQ==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr3029102wmk.153.1599651480007;
        Wed, 09 Sep 2020 04:38:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d3sm3720722wrr.84.2020.09.09.04.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 04:37:59 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:37:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: hibernation: do not hang forever in
 vmbus_bus_resume()
Message-ID: <20200909113758.7ucufasongrttxdw@liuwe-devbox-debian-v2>
References: <20200905025555.45614-1-decui@microsoft.com>
 <MW2PR2101MB1052BE3C25E87FE1CA5BA0F8D7290@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052BE3C25E87FE1CA5BA0F8D7290@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 08, 2020 at 09:05:34PM +0000, Michael Kelley wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Friday, September 4, 2020 7:56 PM
> > 
> > After we Stop and later Start a VM that uses Accelerated Networking (NIC
> > SR-IOV), currently the VF vmbus device's Instance GUID can change, so after
> > vmbus_bus_resume() -> vmbus_request_offers(), vmbus_onoffer() can not find
> > the original vmbus channel of the VF, and hence we can't complete()
> > vmbus_connection.ready_for_resume_event in check_ready_for_resume_event(),
> > and the VM hangs in vmbus_bus_resume() forever.
> > 
> > Fix the issue by adding a timeout, so the resuming can still succeed, and
> > the saved state is not lost, and according to my test, the user can disable
> > Accelerated Networking and then will be able to SSH into the VM for
> > further recovery. Also prevent the VM in question from suspending again.
> > 
> > The host will be fixed so in future the Instance GUID will stay the same
> > across hibernation.
> > 
> > Fixes: d8bd2d442bb2 ("Drivers: hv: vmbus: Resume after fixing up old primary channels")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
