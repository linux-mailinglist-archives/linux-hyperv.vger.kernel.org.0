Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B62356DA1
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Apr 2021 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhDGNnR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Apr 2021 09:43:17 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52887 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhDGNnQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 09:43:16 -0400
Received: by mail-wm1-f51.google.com with SMTP id d191so9051011wmd.2;
        Wed, 07 Apr 2021 06:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vR4mDxGt91A1iZJ3m9Xp8pGC/hn66IQueR2Hm49tWV4=;
        b=X+HWT0J2m9jqwEqrjKCVxTe68u3ycIR8y9kJ7tWnzEyq9l+deYaJ19kqZevT+wHjPr
         bleSBTJ8yr4O5dukUcqqYagOH1H3SmWFmx1Ssf6cNkWAMCv1/d7hzDQdbWr7MD0vCw3t
         8Xj9KAiVN9TzoZ7Azir6XwtbF67pv4V7IMo18+Si5KpUgpcm5YQmyHaNGU+a1X2U/dqy
         mnK0/bhwPZb/1Q8PgClGyWbK3bETIuGHDD72NYEt7QEMAp4N/sHJDp4Izl1aXVaLyouh
         XCcWP4dbaBApo9Yf1lReRVXFYTw+P4TVmbhiTFw039vzDvokVshSzQiKhrjG44EUSZNC
         jTYw==
X-Gm-Message-State: AOAM5339n3iCx7Kjbhw5TDRdbfJd/eQi+n0FZP5Pdd6XrTia5QEpl73I
        lBPakoK7hso7HS0BLgqa4ko=
X-Google-Smtp-Source: ABdhPJyA50jxfeuIzW1ZU6TkygxsLmYeb5ixjkXDu/mhsXOts1JAl9GCaRWUtbSCx2Asqe3rAjo9LQ==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr3175156wmc.132.1617802984571;
        Wed, 07 Apr 2021 06:43:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w3sm8087669wmi.9.2021.04.07.06.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:43:03 -0700 (PDT)
Date:   Wed, 7 Apr 2021 13:43:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
Message-ID: <20210407134302.ng6n4el2km7sujfp@liuwe-devbox-debian-v2>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
 <87eeguc61d.fsf@vitty.brq.redhat.com>
 <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
 <87eefmczo2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eefmczo2.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 07, 2021 at 09:38:21AM +0200, Vitaly Kuznetsov wrote:
> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
> 
> > On 3/5/2021 1:18 AM, Vitaly Kuznetsov wrote:
> >> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
> >> 
> >>> On 2/9/2021 5:11 AM, Vitaly Kuznetsov wrote:
> >>>> Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:
> >>>>
> >> ...
> >>>>> +
> >>>>> +3.1 MSHV_REQUEST_VERSION
> >>>>> +------------------------
> >>>>> +:Type: /dev/mshv ioctl
> >>>>> +:Parameters: pointer to a u32
> >>>>> +:Returns: 0 on success
> >>>>> +
> >>>>> +Before issuing any other ioctls, a MSHV_REQUEST_VERSION ioctl must be called to
> >>>>> +establish the interface version with the kernel module.
> >>>>> +
> >>>>> +The caller should pass the MSHV_VERSION as an argument.
> >>>>> +
> >>>>> +The kernel module will check which interface versions it supports and return 0
> >>>>> +if one of them matches.
> >>>>> +
> >>>>> +This /dev/mshv file descriptor will remain 'locked' to that version as long as
> >>>>> +it is open - this ioctl can only be called once per open.
> >>>>> +
> >>>>
> >>>> KVM used to have KVM_GET_API_VERSION too but this turned out to be not
> >>>> very convenient so we use capabilities (KVM_CHECK_EXTENSION/KVM_ENABLE_CAP)
> >>>> instead.
> >>>>
> >>>
> >>> The goal of MSHV_REQUEST_VERSION is to support changes to APIs in the core set.
> >>> When we add new features/ioctls beyond the core we can use an extension/capability
> >>> approach like KVM.
> >>>
> >> 
> >> Driver versions is a very bad idea from distribution/stable kernel point
> >> of view as it presumes that the history is linear. It is not.
> >> 
> >> Imagine you have the following history upstream:
> >> 
> >> MSHV_REQUEST_VERSION = 1
> >> <100 commits with features/fixes>
> >> MSHV_REQUEST_VERSION = 2
> >> <another 100 commits with features/fixes>
> >> MSHV_REQUEST_VERSION = 2
> >> 
> >> Now I'm a linux distribution / stable kernel maintainer. My kernel is at
> >> MSHV_REQUEST_VERSION = 1. Now I want to backport 1 feature from between
> >> VER=1 and VER=2 and another feature from between VER=2 and VER=3. My
> >> history now looks like
> >> 
> >> MSHV_REQUEST_VERSION = 1
> >> <5 commits from between VER=1 and VER=2>
> >>    Which version should I declare here???? 
> >> <5 commits from between VER=2 and VER=3>
> >>    Which version should I declare here???? 
> >> 
> >> If I keep VER=1 then userspace will think that I don't have any extra
> >> features added and just won't use them. If I change VER to 2/3, it'll
> >> think I have *all* features from between these versions.
> >> 
> >> The only reasonable way to manage this is to attach a "capability" to
> >> every ABI change and expose this capability *in the same commit which
> >> introduces the change to the ABI*. This way userspace will now exactly
> >> which ioctls are available and what are their interfaces.
> >> 
> >> Also, trying to define "core set" is hard but you don't really need
> >> to.
> >> 
> >
> > We've had some internal discussion on this.
> >
> > There is bound to be some iteration before this ABI is stable, since even the
> > underlying Microsoft hypervisor interfaces aren't stable just yet.
> >
> > It might make more sense to just have an IOCTL to check if the API is stable yet.
> > This would be analogous to checking if kVM_GET_API_VERSION returns 12.
> >
> > How does this sound as a proposal?
> > An MSHV_CHECK_EXTENSION ioctl to query extensions to the core /dev/mshv API.
> >
> > It takes a single argument, an integer named MSHV_CAP_* corresponding to
> > the extension to check the existence of.
> >
> > The ioctl will return 0 if the extension is unsupported, or a positive integer
> > if supported.
> >
> > We can initially include a capability called MSHV_CAP_CORE_API_STABLE.
> > If supported, the core APIs are stable.
> 
> This sounds reasonable, I'd suggest you reserve MSHV_CAP_CORE_API_STABLE
> right away but don't expose it yet so it's clear the API is not yet
> stable. Test userspace you have may always assume it's running with the
> latest kernel.
> 
> Also, please be clear about the fact that /dev/mshv doesn't
> provide a stable API yet so nobody builds an application on top of
> it.
> 

Very good discussion and suggestions. Thank you Vitaly.

> One more though: it is probably a good idea to introduce selftests for
> /dev/mshv (similar to KVM's selftests in
> /tools/testing/selftests/kvm). Selftests don't really need a stable ABI
> as they live in the same linux.git and can be updated in the same patch
> series which changes /dev/mshv behavior. Selftests are very useful for
> checking there are no regressions, especially in the situation when
> there's no publicly available userspace for /dev/mshv.

I think this can wait until we merge the first implementation in tree.
There are still a lot of moving parts. Our (currently limited) internal
test cases need more cleaning up before they are ready. I certainly
don't want to distract Nuno from getting the foundation right.

Wei.
