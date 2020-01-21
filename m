Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15050143DBC
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2020 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAUNNU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jan 2020 08:13:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgAUNNU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jan 2020 08:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579612398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bm6ddKCO7VQlppCqWI0nKfN86LSegXbIAkNREeCapWU=;
        b=Hgboj3ghyGNRoU78FsW9CEe+oqSWuh4CInXhJIz/y2+HhRp4A2i4VOUf8FKi+fcSS3kGoV
        5gfJPAGj0puvOjjJ1pvjCiOFyTn6HwZq40khXyFMMazVnUGNkjnst/Ki1irOSWdrI9Ljmm
        pfmRJlXjNbp88G5scnmNzKYN+OPfyvU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-cRBF6Te3MtqVM0lF1yktNQ-1; Tue, 21 Jan 2020 08:13:17 -0500
X-MC-Unique: cRBF6Te3MtqVM0lF1yktNQ-1
Received: by mail-wr1-f72.google.com with SMTP id j4so1293749wrs.13
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jan 2020 05:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bm6ddKCO7VQlppCqWI0nKfN86LSegXbIAkNREeCapWU=;
        b=kGQUO4t6Xr369+bfMKVkn0Fp6PHwDg7WT3p+Jsibk2+dS2CCAKpuiqOocRopJAFunb
         o5/3eHAl7ebXhChyxRhTbGOSwaGv/0mn5zs3RKg9e6xEaW2nzbPWzfJMWxZIYbK95IjS
         /xf0kJP4Hzgzfww8hJQY+ch5QABy3x1ASuI+BlKwJbDq5QzKxhwOU4iWutbp8nXriVAr
         kxg68SLFXZtvfcBtIABiRRL4XYlXIppnpZOuNBpnvzPjGaAXicldPsoskLJXe0EIyTTP
         NQBJuPrcLjqfdVVdM9lTdZZzGz8tydvzUUIfxypPRnhtctyCgfmTj3L2zTB5qmRalhbi
         2WAQ==
X-Gm-Message-State: APjAAAV8Qkcp3LG5Rs5KcdE7JrC0ZXQtlPdRC4LAc5ARYh2awDvQn6MF
        M8g2pWc2ZQOdzwJVb5VxEdbs5KoWvPcAXJ4K88QKqC+K79bFn5mqIPMDHdk+3qXM7dPXtweCMSF
        J+rstp+0HHt/vn0OmdapyxzK+
X-Received: by 2002:a5d:5403:: with SMTP id g3mr5445459wrv.302.1579612396252;
        Tue, 21 Jan 2020 05:13:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwymXXQZOjbORIMA0cxvCm/5PHfeqOk5X4LFnVOkEvDpjGvEEDvp8HpuokWl0ML8Wkw3YfvnA==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr5445417wrv.302.1579612395941;
        Tue, 21 Jan 2020 05:13:15 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id o4sm50707386wrx.25.2020.01.21.05.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:13:15 -0800 (PST)
Date:   Tue, 21 Jan 2020 14:13:12 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20200121131312.wcwlsfljunzqopph@steredhat>
References: <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
 <20200120110319-mutt-send-email-mst@kernel.org>
 <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
 <20200120170120-mutt-send-email-mst@kernel.org>
 <CAGxU2F4uW7FNe5xC0sb3Xxr_GABSXuu1Z9n5M=Ntq==T7MaaVw@mail.gmail.com>
 <20200121055403-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121055403-mutt-send-email-mst@kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 21, 2020 at 06:14:48AM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 21, 2020 at 10:07:06AM +0100, Stefano Garzarella wrote:
> > On Mon, Jan 20, 2020 at 11:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Mon, Jan 20, 2020 at 05:53:39PM +0100, Stefano Garzarella wrote:
> > > > On Mon, Jan 20, 2020 at 5:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wrote:
> > > > > > On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > > > > > > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > > > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > > > > > > >
> > > > > > > > > > This patch adds 'netns' module param to enable this new feature
> > > > > > > > > > (disabled by default), because it changes vsock's behavior with
> > > > > > > > > > network namespaces and could break existing applications.
> > > > > > > > >
> > > > > > > > > Sorry, no.
> > > > > > > > >
> > > > > > > > > I wonder if you can even design a legitimate, reasonable, use case
> > > > > > > > > where these netns changes could break things.
> > > > > > > >
> > > > > > > > I forgot to mention the use case.
> > > > > > > > I tried the RFC with Kata containers and we found that Kata shim-v1
> > > > > > > > doesn't work (Kata shim-v2 works as is) because there are the following
> > > > > > > > processes involved:
> > > > > > > > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> > > > > > > >   passes it to qemu
> > > > > > > > - kata-shim (runs in a container) wants to talk with the guest but the
> > > > > > > >   vsock device is assigned to the init_netns and kata-shim runs in a
> > > > > > > >   different netns, so the communication is not allowed
> > > > > > > > But, as you said, this could be a wrong design, indeed they already
> > > > > > > > found a fix, but I was not sure if others could have the same issue.
> > > > > > > >
> > > > > > > > In this case, do you think it is acceptable to make this change in
> > > > > > > > the vsock's behavior with netns and ask the user to change the design?
> > > > > > >
> > > > > > > David's question is what would be a usecase that's broken
> > > > > > > (as opposed to fixed) by enabling this by default.
> > > > > >
> > > > > > Yes, I got that. Thanks for clarifying.
> > > > > > I just reported a broken example that can be fixed with a different
> > > > > > design (due to the fact that before this series, vsock devices were
> > > > > > accessible to all netns).
> > > > > >
> > > > > > >
> > > > > > > If it does exist, you need a way for userspace to opt-in,
> > > > > > > module parameter isn't that.
> > > > > >
> > > > > > Okay, but I honestly can't find a case that can't be solved.
> > > > > > So I don't know whether to add an option (ioctl, sysfs ?) or wait for
> > > > > > a real case to come up.
> > > > > >
> > > > > > I'll try to see better if there's any particular case where we need
> > > > > > to disable netns in vsock.
> > > > > >
> > > > > > Thanks,
> > > > > > Stefano
> > > > >
> > > > > Me neither. so what did you have in mind when you wrote:
> > > > > "could break existing applications"?
> > > >
> > > > I had in mind:
> > > > 1. the Kata case. It is fixable (the fix is not merged on kata), but
> > > >    older versions will not work with newer Linux.
> > >
> > > meaning they will keep not working, right?
> > 
> > Right, I mean without this series they work, with this series they work
> > only if the netns support is disabled or with a patch proposed but not
> > merged in kata.
> > 
> > >
> > > > 2. a single process running on init_netns that wants to communicate with
> > > >    VMs handled by VMMs running in different netns, but this case can be
> > > >    solved opening the /dev/vhost-vsock in the same netns of the process
> > > >    that wants to communicate with the VMs (init_netns in this case), and
> > > >    passig it to the VMM.
> > >
> > > again right now they just don't work, right?
> > 
> > Right, as above.
> > 
> > What do you recommend I do?
> > 
> > Thanks,
> > Stefano
> 
> If this breaks userspace, then we need to maintain compatibility.
> For example, have two devices, /dev/vhost-vsock and /dev/vhost-vsock-netns?

Interesting!

So, VMs handled with /dev/vhost-vsock will be reachable from any netns (as
it happens now) and VMs handled with /dev/vhost-vsock-netns will be
reachable only from the same netns of the process that opens it.

It requires more changes, but we will preserve the previous behavior,
adding the new feature!

Thanks a lot for this idea! I'll try to implement it!
Stefano

