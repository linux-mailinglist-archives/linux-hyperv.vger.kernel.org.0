Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11398143BDD
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2020 12:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAULPG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jan 2020 06:15:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728826AbgAULPD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jan 2020 06:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579605301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sas8QSfTms5SHYNUYcSN2fpX+ktGIKgMkg1A/nzCkbg=;
        b=TVr/x9VTQxxaRZNOrHwkjjloYXttORC0fuSzPn8cvznGr+7QAZSS+99urPsX24C7OCqfUw
        fQt/HsKi1lM2WXfigUA/qpSY8eQ4lfRyv+A/ZdV06HlWpRi8+Shs64QarNfa10ichhycZN
        E21sjH8kD1B7NtMxQxO4VxaZ4gfaKNU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-FHY3fTq2OU-OXdGJc6f-1w-1; Tue, 21 Jan 2020 06:14:56 -0500
X-MC-Unique: FHY3fTq2OU-OXdGJc6f-1w-1
Received: by mail-qk1-f197.google.com with SMTP id a6so1525695qkl.7
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jan 2020 03:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sas8QSfTms5SHYNUYcSN2fpX+ktGIKgMkg1A/nzCkbg=;
        b=YmoS13fbLWlA7Ct78yjgHnlTRqhlvzPms2eybmbdNdb4lqxET8p4BBy0J3wXVbAVT9
         DGJEdHBO0FQnmZ9kW9YXhniAM525SB33jLA/N1UeR21TNFbphslnrpkNUzwoY6i0esEx
         Z59O6PL5wI+QkrxDV02pJaWNqMVcFvHJdJm6lTLUrmRpS01t8mK+bskeLM7/UPy8ygEA
         T8tnyT785YHpadKjD0J4pZghac8IUDjayY4fV1X0ZngYwmH035NAKefZciPCtseU/VSg
         50dineaw8xj5F8wQVtoeYsnE9nOedsAhyAEURC+ynqwsHea5V1vefToDnawCIAQvyRFJ
         dGhA==
X-Gm-Message-State: APjAAAWyTq7y/+r/SIP5fmihM2goRaPebTrIPSTHTuyyFDpfpHK9TD2M
        DkcRPTo2t3ukHjFKC0R+Mm4HD0vTDehJohP3K4b4hMwWQall8kvCpsQT661yyi1bL0L9qsJHIS+
        eSD9vsA2FIUMOjPDOV4b5v6MN
X-Received: by 2002:aed:2a12:: with SMTP id c18mr3777313qtd.200.1579605296052;
        Tue, 21 Jan 2020 03:14:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBa53GZjQgDfeEt/mKYlPCXxhcFat/NW2g7/j2dAOcNMjdacdZ6bp3qye4cVZNWRDKUgo3aw==
X-Received: by 2002:aed:2a12:: with SMTP id c18mr3777280qtd.200.1579605295708;
        Tue, 21 Jan 2020 03:14:55 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id k133sm428981qke.134.2020.01.21.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 03:14:54 -0800 (PST)
Date:   Tue, 21 Jan 2020 06:14:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20200121055403-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
 <20200120110319-mutt-send-email-mst@kernel.org>
 <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
 <20200120170120-mutt-send-email-mst@kernel.org>
 <CAGxU2F4uW7FNe5xC0sb3Xxr_GABSXuu1Z9n5M=Ntq==T7MaaVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F4uW7FNe5xC0sb3Xxr_GABSXuu1Z9n5M=Ntq==T7MaaVw@mail.gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 21, 2020 at 10:07:06AM +0100, Stefano Garzarella wrote:
> On Mon, Jan 20, 2020 at 11:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Jan 20, 2020 at 05:53:39PM +0100, Stefano Garzarella wrote:
> > > On Mon, Jan 20, 2020 at 5:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wrote:
> > > > > On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > > > > > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > > > > > >
> > > > > > > > > This patch adds 'netns' module param to enable this new feature
> > > > > > > > > (disabled by default), because it changes vsock's behavior with
> > > > > > > > > network namespaces and could break existing applications.
> > > > > > > >
> > > > > > > > Sorry, no.
> > > > > > > >
> > > > > > > > I wonder if you can even design a legitimate, reasonable, use case
> > > > > > > > where these netns changes could break things.
> > > > > > >
> > > > > > > I forgot to mention the use case.
> > > > > > > I tried the RFC with Kata containers and we found that Kata shim-v1
> > > > > > > doesn't work (Kata shim-v2 works as is) because there are the following
> > > > > > > processes involved:
> > > > > > > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> > > > > > >   passes it to qemu
> > > > > > > - kata-shim (runs in a container) wants to talk with the guest but the
> > > > > > >   vsock device is assigned to the init_netns and kata-shim runs in a
> > > > > > >   different netns, so the communication is not allowed
> > > > > > > But, as you said, this could be a wrong design, indeed they already
> > > > > > > found a fix, but I was not sure if others could have the same issue.
> > > > > > >
> > > > > > > In this case, do you think it is acceptable to make this change in
> > > > > > > the vsock's behavior with netns and ask the user to change the design?
> > > > > >
> > > > > > David's question is what would be a usecase that's broken
> > > > > > (as opposed to fixed) by enabling this by default.
> > > > >
> > > > > Yes, I got that. Thanks for clarifying.
> > > > > I just reported a broken example that can be fixed with a different
> > > > > design (due to the fact that before this series, vsock devices were
> > > > > accessible to all netns).
> > > > >
> > > > > >
> > > > > > If it does exist, you need a way for userspace to opt-in,
> > > > > > module parameter isn't that.
> > > > >
> > > > > Okay, but I honestly can't find a case that can't be solved.
> > > > > So I don't know whether to add an option (ioctl, sysfs ?) or wait for
> > > > > a real case to come up.
> > > > >
> > > > > I'll try to see better if there's any particular case where we need
> > > > > to disable netns in vsock.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Me neither. so what did you have in mind when you wrote:
> > > > "could break existing applications"?
> > >
> > > I had in mind:
> > > 1. the Kata case. It is fixable (the fix is not merged on kata), but
> > >    older versions will not work with newer Linux.
> >
> > meaning they will keep not working, right?
> 
> Right, I mean without this series they work, with this series they work
> only if the netns support is disabled or with a patch proposed but not
> merged in kata.
> 
> >
> > > 2. a single process running on init_netns that wants to communicate with
> > >    VMs handled by VMMs running in different netns, but this case can be
> > >    solved opening the /dev/vhost-vsock in the same netns of the process
> > >    that wants to communicate with the VMs (init_netns in this case), and
> > >    passig it to the VMM.
> >
> > again right now they just don't work, right?
> 
> Right, as above.
> 
> What do you recommend I do?
> 
> Thanks,
> Stefano

If this breaks userspace, then we need to maintain compatibility.
For example, have two devices, /dev/vhost-vsock and /dev/vhost-vsock-netns?

-- 
MST

