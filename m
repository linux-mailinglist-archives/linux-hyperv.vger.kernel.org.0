Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A267BD3BA2
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Oct 2019 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfJKIwD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Oct 2019 04:52:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfJKIwD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Oct 2019 04:52:03 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 108EC3D962
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Oct 2019 08:52:03 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r21so2502139wme.5
        for <linux-hyperv@vger.kernel.org>; Fri, 11 Oct 2019 01:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bm3aGONhK4qHoU5UjTbFZHuFrC1vqMKeEY0f1MpcuKs=;
        b=RGeQzF3NWBHLg5uU2LGrlxc9ZROjEn2/+j6Vsa7qO9seCx7uyup+/0CR0WgDPoyctn
         HzfGrT/Jzf3LnLshUU4j+NhtfsEeS1ub9OFw5W2nnXknTeDb63IOIRluczYAx5jjhz4L
         i0KAwvn49yR4pF20RZ6BOH+YekBhYXxQfF5l2d25jppu9WE2hOco8cTFtkTc3ksaFBey
         tqi/eQqOLH90pd/yKJ1TQuSWm2SeFNJFMC4j48x1zRPC6aUFBChgDvUN/Ss2ysRmb3wB
         QvFrxHVruKrqtVhJgxw/SR/SzrZ7RotXjBzxII5JHk/2g3sVwGIjrhliX68EB2eI5Fr/
         KZ1w==
X-Gm-Message-State: APjAAAXLSuJN83uQTBJgfuc3Msl5Wi8X//Mdbc6pC5ufNec4oKPGNSFf
        DD4hX2pBPQGswtqSIOrWK7BwNCfgP/RLpGO4/WtdbjHSrqbkaeZJ4CKQDiplv7usF/8SAFb/daW
        oFFvHK/d70Ceke57WTHyj/EF9
X-Received: by 2002:adf:f50b:: with SMTP id q11mr8542909wro.310.1570783921673;
        Fri, 11 Oct 2019 01:52:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1tPYaVEApdDIIQuAyje0VVr9AdUGsps1WDvoQMdr3X8xYr+LiIbxou3tR8pwnY/h86mPFNQ==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr8542895wro.310.1570783921424;
        Fri, 11 Oct 2019 01:52:01 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id z189sm13295813wmc.25.2019.10.11.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:52:00 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:51:58 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 07/13] vsock: handle buffer_size sockopts in the core
Message-ID: <20191011085158.wiiv4av5fgipm4k7@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20190927112703.17745-8-sgarzare@redhat.com>
 <20191009123026.GH5747@stefanha-x1.localdomain>
 <20191010093254.aluys4hpsfcepb42@steredhat>
 <20191011082714.GF12360@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011082714.GF12360@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 11, 2019 at 09:27:14AM +0100, Stefan Hajnoczi wrote:
> On Thu, Oct 10, 2019 at 11:32:54AM +0200, Stefano Garzarella wrote:
> > On Wed, Oct 09, 2019 at 01:30:26PM +0100, Stefan Hajnoczi wrote:
> > > On Fri, Sep 27, 2019 at 01:26:57PM +0200, Stefano Garzarella wrote:
> > > Another issue is that this patch drops the VIRTIO_VSOCK_MAX_BUF_SIZE
> > > limit that used to be enforced by virtio_transport_set_buffer_size().
> > > Now the limit is only applied at socket init time.  If the buffer size
> > > is changed later then VIRTIO_VSOCK_MAX_BUF_SIZE can be exceeded.  If
> > > that doesn't matter, why even bother with VIRTIO_VSOCK_MAX_BUF_SIZE
> > > here?
> > > 
> > 
> > The .notify_buffer_size() should avoid this issue, since it allows the
> > transport to limit the buffer size requested after the initialization.
> > 
> > But again the min set by the user can not be respected and in the
> > previous implementation we forced it to VIRTIO_VSOCK_MAX_BUF_SIZE.
> > 
> > Now we don't limit the min, but we guarantee only that vsk->buffer_size
> > is lower than VIRTIO_VSOCK_MAX_BUF_SIZE.
> > 
> > Can that be an acceptable compromise?
> 
> I think so.
> 
> Setting buffer sizes was never tested or used much by userspace
> applications that I'm aware of.  We should probably include tests for
> changing buffer sizes in the test suite.

Good idea! We should add a test to check if min/max are respected,
playing a bit with these sockopt.

I'll do it in the test series!

Thanks,
Stefano
