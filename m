Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F561BC454
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2020 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgD1QBB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Apr 2020 12:01:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbgD1QBB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Apr 2020 12:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588089659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/nHrnAWjFYDEx+ooars7FfriVR6n5mahvVNAOlPkCA=;
        b=T+G7JyE7CA49AvV1biNb5AOP7jqobjGb6AaCtB9L2E0TEjhJtICZrd7K2CFC9KsYP4XQsd
        LvrdLNDO2O2Jh5vql2rEZMKtUwoDi0lxa7DWHMBYLDvKX3cKe/y+yp8Ukl7x+UCsFoguv2
        XA3iPctyvNr8gPlnfUNOvyhTDOuzHbc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-di-4GguCPlmCz6UZSdLkcQ-1; Tue, 28 Apr 2020 12:00:57 -0400
X-MC-Unique: di-4GguCPlmCz6UZSdLkcQ-1
Received: by mail-wm1-f69.google.com with SMTP id n17so1054579wmi.3
        for <linux-hyperv@vger.kernel.org>; Tue, 28 Apr 2020 09:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V/nHrnAWjFYDEx+ooars7FfriVR6n5mahvVNAOlPkCA=;
        b=qSGdUHnyLHsDIJD7U7wf87zHOk6jxagceNVdLpvlxbkJ8lawwk1Rr3WGEnVavAWqZL
         8j7qOoqybZZrtXKEAym0QCg61F5wDKc2YDShfkaZ2PnmPR84gPnZp+NrPj1ujL230l4b
         3AL4Atr3biZVYQRZPj5K/HS2WdGT/DMifFya1QNPFwrB1uHbkqSPxyyjeyVZfLvAA/FU
         YXCTzAv9N2c/tHeXW/X1RFbPFIRHfuXzs/zPPI+3CTPTZLiGAMprpA/o536woF/VMF1B
         zpUQywALpRZMx7WGN27TLK6jBwoHVi2Rkfed5MmXF8+Xbeb1GmGm5q0EKDWPRSfuO5mw
         Lyaw==
X-Gm-Message-State: AGi0PuYzdF1hfN6F7KUkjem/bkH5jmBNO3FMHlM/A/0bzhR9XqLhfq45
        BcIcZ23XUWQs/ozxpJoJ6szYxlgV75HSabG0CnRXwuD5p39zFbYOGLdE+EYZdEXhhUFHyW4spIm
        Hmn9L0geD4HEpMt3yOLEGOaAA
X-Received: by 2002:adf:bb94:: with SMTP id q20mr36673135wrg.105.1588089656823;
        Tue, 28 Apr 2020 09:00:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIbCy5WLfJsOD2H4tVuk3XU3G9si8HV/hIhC9ID521e8b71TD3eq8vjhdxcrAKzwjnXgEZ/g==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr36673001wrg.105.1588089655649;
        Tue, 28 Apr 2020 09:00:55 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id i129sm4064632wmi.20.2020.04.28.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:00:54 -0700 (PDT)
Date:   Tue, 28 Apr 2020 18:00:52 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20200428160052.o3ihui4262xogyg4@steredhat>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> 
> On 2020/4/27 下午10:25, Stefano Garzarella wrote:
> > Hi David, Michael, Stefan,
> > I'm restarting to work on this topic since Kata guys are interested to
> > have that, especially on the guest side.
> > 
> > While working on the v2 I had few doubts, and I'd like to have your
> > suggestions:
> > 
> >   1. netns assigned to the device inside the guest
> > 
> >     Currently I assigned this device to 'init_net'. Maybe it is better
> >     if we allow the user to decide which netns assign to the device
> >     or to disable this new feature to have the same behavior as before
> >     (host reachable from any netns).
> >     I think we can handle this in the vsock core and not in the single
> >     transports.
> > 
> >     The simplest way that I found, is to add a new
> >     IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS to /dev/vsock to enable the feature
> >     and assign the device to the same netns of the process that do the
> >     ioctl(), but I'm not sure it is clean enough.
> > 
> >     Maybe it is better to add new rtnetlink messages, but I'm not sure if
> >     it is feasible since we don't have a netdev device.
> > 
> >     What do you suggest?
> 
> 
> As we've discussed, it should be a netdev probably in either guest or host
> side. And it would be much simpler if we want do implement namespace then.
> No new API is needed.
> 

Thanks Jason!

It would be cool, but I don't have much experience on netdev.
Do you see any particular obstacles?

I'll take a look to understand how to do it, surely in the guest would
be very useful to have the vsock device as a netdev and maybe also in the host.

Stefano

