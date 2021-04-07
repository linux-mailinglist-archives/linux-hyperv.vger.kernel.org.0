Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5AE356E61
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Apr 2021 16:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348331AbhDGOTh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Apr 2021 10:19:37 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:36493 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352824AbhDGOTg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 10:19:36 -0400
Received: by mail-wm1-f45.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso1248065wmq.1;
        Wed, 07 Apr 2021 07:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9m75QxnXJIDFvd04jFuU+jAebNsaXnrFEZtwPGGiQ6I=;
        b=hy/UShkRuKlEBnY4DnlQ5swvDeszqHFjvepcCLZAmOihTZkegZI05vJTSra9Cl7LXt
         ALunM83N4x4J9NerkawCXuvhAA+dZj0Pje+RurRmY8Q6ljgLy+W5GAdkBcdADC6zcmdC
         YeFc/pfJCGOLckZ/qnhoCvWYV/+O+DPwTlraBBosr9xdYFyATWNCYxKkRcrrUaTASmmH
         ZkG05209AgIPH9d2iAAgtIAcbXEu4teuD/4rliA7np815eCbby1jgQ2YoRXwNB1DEkaW
         amHcv4mdwA8xtO94Z2sWiWmTMhxVPHggRXzKU3CaY3de6AQSw/wf9jgCfLdADlXbUA8h
         vGdg==
X-Gm-Message-State: AOAM533mX35qyfE/b266WwubGqknzdnTD5v12466rAvSpICmPGGAo7zc
        jYdjkTWCzyI73mEVY8ibpVU=
X-Google-Smtp-Source: ABdhPJwBnX0Ez4uvqR15d2CNOLfxYcbZiHDxpYoR+YreH8iCinoqqpy3ifThs9C2Em96oABEhH6V4Q==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr3420630wmi.84.1617805164174;
        Wed, 07 Apr 2021 07:19:24 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w10sm11862981wrv.95.2021.04.07.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:19:23 -0700 (PDT)
Date:   Wed, 7 Apr 2021 14:19:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 04/18] virt/mshv: request version ioctl
Message-ID: <20210407141922.ksxdngftdaruhnki@liuwe-devbox-debian-v2>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-5-git-send-email-nunodasneves@linux.microsoft.com>
 <87y2fxmlmb.fsf@vitty.brq.redhat.com>
 <194e0dad-495e-ae94-3f51-d2c95da52139@linux.microsoft.com>
 <87eeguc61d.fsf@vitty.brq.redhat.com>
 <fc88ba72-83ab-025e-682d-4981762ed4f6@linux.microsoft.com>
 <87eefmczo2.fsf@vitty.brq.redhat.com>
 <20210407134302.ng6n4el2km7sujfp@liuwe-devbox-debian-v2>
 <875z0ychv3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z0ychv3.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 07, 2021 at 04:02:56PM +0200, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > On Wed, Apr 07, 2021 at 09:38:21AM +0200, Vitaly Kuznetsov wrote:
> >
> >> One more though: it is probably a good idea to introduce selftests for
> >> /dev/mshv (similar to KVM's selftests in
> >> /tools/testing/selftests/kvm). Selftests don't really need a stable ABI
> >> as they live in the same linux.git and can be updated in the same patch
> >> series which changes /dev/mshv behavior. Selftests are very useful for
> >> checking there are no regressions, especially in the situation when
> >> there's no publicly available userspace for /dev/mshv.
> >
> > I think this can wait until we merge the first implementation in tree.
> > There are still a lot of moving parts. Our (currently limited) internal
> > test cases need more cleaning up before they are ready. I certainly
> > don't want to distract Nuno from getting the foundation right.
> >
> 
> I'm absolutely fine with this approach, selftests are a nice add-on, not
> a requirement for the initial implementation. Also, to make them more
> useful to mere mortals, a doc on how to run Linux as root Hyper-V
> partition would come handy)

Making this system easier for others to use and consume is on our radar.
Currently you need Windows bootloader and a not-yet-released loader to
load the hypervisor. We're making progress in bringing in GRUB.

Needless to say there are technical and non-technical challenges for
this work, so don't expect it to happen very soon. :-)

Wei.

> 
> -- 
> Vitaly
> 
