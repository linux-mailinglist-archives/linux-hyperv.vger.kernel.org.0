Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE8CB729
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2019 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfJDJQK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Oct 2019 05:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731289AbfJDJQK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Oct 2019 05:16:10 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C2EE796E9
        for <linux-hyperv@vger.kernel.org>; Fri,  4 Oct 2019 09:16:10 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id m14so2412769wru.17
        for <linux-hyperv@vger.kernel.org>; Fri, 04 Oct 2019 02:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hhPEpgLhkjexE7wGXfmiyqeRzNcW/U3S79ip8ewXhIg=;
        b=a/Qoh3m8jeLd8Zhxlz1H2i5tWgZRFZIg2SAJ39k4NxHibIrVXFtS2xTPOHs/TdFkGS
         moYs0JC2MdtZ7x+6E709QJ4OCG6p19BJ2BtdIdT10YtPjZc8Zcsz/uN+i9blctsrsfV0
         U///crmcYCF6R5OG2VKCF6hwOfYC7Pb5YTLB08PyNIE4rkz30DNFJrU/vgW0DBuHVbxo
         1OvGYwE3shelFT8Wjx8CqGOnmwyypp9axbdR3/XTLR9EaoLfGCRM+4LGrVYB+vCqu4v5
         tqdHx3O0RHyuzh8ihYqdVmedWn9O7Mjw/7gnhw9ukHSnFzlv21dWHcwACdtwr5sXCrJ/
         Qc7g==
X-Gm-Message-State: APjAAAUBIVk3y1EWSrbxbg0UaIBPxbYZSOQ06cMvrs71PhFqEc3XYyfv
        NfQHtGa7Ymohcpe732uQe2XJ6VsKJ/H0wbx5FBGxE82MQAJhHE9OAbYihGZbxeKZcat9DnJj1HK
        VluKGT19fqzPc7Wpq/xHQb2Kv
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr10287390wme.96.1570180568815;
        Fri, 04 Oct 2019 02:16:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYyFXc0psA9cM79xGyuf3QCE7kgh2CziA2e0KZxOqK4U+Rh82+kx6tnfpcYC/+KSgegIYtMA==
X-Received: by 2002:a1c:9d15:: with SMTP id g21mr10287358wme.96.1570180568530;
        Fri, 04 Oct 2019 02:16:08 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id q192sm7660110wme.23.2019.10.04.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:16:07 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:16:05 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 00/13] vsock: add multi-transports support
Message-ID: <20191004091605.ayed7iqjhurzrdap@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <PU1P153MB0169970A7DD4383F06CDAB60BF9E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169970A7DD4383F06CDAB60BF9E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 04, 2019 at 12:04:46AM +0000, Dexuan Cui wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Sent: Friday, September 27, 2019 4:27 AM
> >  ...
> > Patch 9 changes the hvs_remote_addr_init(). setting the
> > VMADDR_CID_HOST as remote CID instead of VMADDR_CID_ANY to make
> > the choice of transport to be used work properly.
> > @Dexuan Could this change break anything?
> 
> This patch looks good to me.
> 

Thank you very much for your reviews!

> > @Dexuan please can you test on HyperV that I didn't break anything
> > even without nested VMs?
> 
> I did some quick tests with the 13 patches in a Linux VM (this is not
> a nested VM) on Hyper-V and it looks nothing is broken. :-)
> 

Great :-)

> > I'll try to setup a Windows host where to test the nested VMs
> 
> I suppose you're going to run a Linux VM on a Hyper-V host,
> and the Linux VM itself runs KVM/VmWare so it can create its own child 
> VMs. IMO this is similar to the test "nested KVM ( ..., virtio-transport[L1,L2]"
> you have done.

Yes, I think so. If the Hyper-V transport works well without nested VM,
it should work the same with a nested KVM/VMware.

Thanks,
Stefano
