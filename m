Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D315142CA5
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 14:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgATN6I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jan 2020 08:58:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26973 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbgATN6I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 08:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579528687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSGrES7SvQ9BENTP8tuIq46XiUVWki3/yCQVC8wDv3E=;
        b=eQfAWLPB7WbkYcvw7akvc5muzko66Ln5Mc6sP4yeFKT9yYiCMK4TmtN5XtYPlSiBBnKC5N
        NY9AxCRY766vV1Yo0ycTpyXLw6GQKiFIYJyxoRErW++OZPrIiZMdON/+tu3aRws6A4aYHs
        GyOHFHeN9hJPmTBdGm7zaM56H1NRzHs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-TEP0xI-7PO2FJuE4OvtanQ-1; Mon, 20 Jan 2020 08:58:06 -0500
X-MC-Unique: TEP0xI-7PO2FJuE4OvtanQ-1
Received: by mail-wm1-f70.google.com with SMTP id t17so2094883wmi.7
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jan 2020 05:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JSGrES7SvQ9BENTP8tuIq46XiUVWki3/yCQVC8wDv3E=;
        b=U6/e+WFTFz/F0QToN+12flbgqS4ZYDfne3rQtTpnxilpRa3IOs7Vr7275OAhJvt3jg
         3B5AMDCjoh2gqd0mUzLCN+gpZKfMR1RiweuGsPDIj9Kz+FslSYcLsvXCQPQmMsu4sSbh
         I7cefmVpjxrA5WgMhAyVdIMO31h6Pjq1o/DEHzczMVPIFxMQwQ7IsYgfBhCLtDugi70L
         5hxqLYyY+HRmu1ZURBvkYE9+T4P0s662NNfUJFE4wn1wr0DUkeJ6+W1a32NAQQhgWmMv
         /LwpVaA14cDZWFaORq4+nc9mK3ff/v506Ndwj6i6GD8aENOvybCpRzc7oXg2drx61PVh
         Zd2Q==
X-Gm-Message-State: APjAAAXzTDMNV7M2UWFMqZfeLCpT3p6Byr5caxr5YO5HAhlsHtBm6erY
        UrLlVm7G58bo0P+6uHCNnqvzj7Cc6eQ9q0hqXIAkSjz9Os9ILVxdXk0qwlRm1SGk0+SUCzNYFfl
        2niarp12m2Ra8UscZ1BSW/saC
X-Received: by 2002:a1c:a914:: with SMTP id s20mr19813070wme.189.1579528685024;
        Mon, 20 Jan 2020 05:58:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6wszqOYoCEpagKH53ZUl7pwL2W60rXYY3qi8C3MZSqVyDhyOnZjTORoRt3i9V4qU4repffg==
X-Received: by 2002:a1c:a914:: with SMTP id s20mr19813038wme.189.1579528684814;
        Mon, 20 Jan 2020 05:58:04 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id s8sm46404753wrt.57.2020.01.20.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:58:04 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:58:01 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120060601-mutt-send-email-mst@kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > >
> > > > This patch adds 'netns' module param to enable this new feature
> > > > (disabled by default), because it changes vsock's behavior with
> > > > network namespaces and could break existing applications.
> > >
> > > Sorry, no.
> > >
> > > I wonder if you can even design a legitimate, reasonable, use case
> > > where these netns changes could break things.
> >
> > I forgot to mention the use case.
> > I tried the RFC with Kata containers and we found that Kata shim-v1
> > doesn't work (Kata shim-v2 works as is) because there are the following
> > processes involved:
> > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> >   passes it to qemu
> > - kata-shim (runs in a container) wants to talk with the guest but the
> >   vsock device is assigned to the init_netns and kata-shim runs in a
> >   different netns, so the communication is not allowed
> > But, as you said, this could be a wrong design, indeed they already
> > found a fix, but I was not sure if others could have the same issue.
> >
> > In this case, do you think it is acceptable to make this change in
> > the vsock's behavior with netns and ask the user to change the design?
>
> David's question is what would be a usecase that's broken
> (as opposed to fixed) by enabling this by default.

Yes, I got that. Thanks for clarifying.
I just reported a broken example that can be fixed with a different
design (due to the fact that before this series, vsock devices were
accessible to all netns).

>
> If it does exist, you need a way for userspace to opt-in,
> module parameter isn't that.

Okay, but I honestly can't find a case that can't be solved.
So I don't know whether to add an option (ioctl, sysfs ?) or wait for
a real case to come up.

I'll try to see better if there's any particular case where we need
to disable netns in vsock.

Thanks,
Stefano

