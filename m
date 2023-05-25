Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B5C71106A
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 May 2023 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjEYQHK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 May 2023 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjEYQHG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 May 2023 12:07:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E59E4A
        for <linux-hyperv@vger.kernel.org>; Thu, 25 May 2023 09:07:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a5861so1677172276.0
        for <linux-hyperv@vger.kernel.org>; Thu, 25 May 2023 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685030822; x=1687622822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8fhdJsa5NorDsEqTWIJQ5b4Ve27T8A/3D8mN23h+AM=;
        b=FEqq2WYT2bpFD+1TtSHkaFzNdRiEuyI2g6NACjIvhMwGd2nTXz/TFAkSgH9Ujas6q/
         vhfG2wZKYTJDUOpnLW2+ofbeXlQQzMc4kCX+fmSU72PlK4P1Bu6ChRJwig3K6o+kmK9V
         pCl4CF26O5Po2Isyv/JlTTvFCsfs3ZUrFwA7UHCTWbISgu9JRVShkNuOUaec2GLwo+qR
         9KOOx1CsOYaN5w2VTeTg1ACrMvUsp1nWuR5WaKwUiyP0rqYNcgG1cqc/7vdfOhawEkwt
         dDqOiNZlzeyBYZO39XTCtpGesfMZs3DSR4tffu8EiIq8HLxLRNoWCQV/DwcUzn5RT3NK
         ujWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030822; x=1687622822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8fhdJsa5NorDsEqTWIJQ5b4Ve27T8A/3D8mN23h+AM=;
        b=CNmUU7xTu2OJys6ImS9ZXIJJMUgXXfO1hh3sCQMFBOh59a7ExQf5/47wTxxJThNadI
         rsC6XhKPdFDi0/IWfdxu6X33aldkFbqFTpB5KRBOadhUVk6fOyFQCqL631I8jKPX9ojk
         31KbR6PmW3KKtMjWJFaxo41Y0cWvRKavFBGFBGFGi6X6V7+ELvDsNG5lph/85RAxgoTR
         5ByLlUc7gytTJCaXd5K7Zrllgk9fnAXmTPK3h2C2V7A6v1OgJPvWhqJtZ5f/HtUYYXxu
         FBHn5HMuRH3pHm82tS2OgIec5muRK1DkaFfRcyhpkRqKAE/ndnk41VQbIbOoOvj6KYdi
         oEDg==
X-Gm-Message-State: AC+VfDztndJucGSTMIqTxzvmtmhyDnydHlsWijRYBOxbcfXwLuJe244w
        B89LgkGQ71QB55nm/5u96aGaityjLF8=
X-Google-Smtp-Source: ACHHUZ6yBYNFZuYhfNGO52o3ys/I0sQ5pEx4h3FPL/IsVNBvdz1hiS3BsLpfaNj0iWMqAGXV//6VIasdS2w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6584:0:b0:ba8:381b:f764 with SMTP id
 z126-20020a256584000000b00ba8381bf764mr2233557ybb.3.1685030821985; Thu, 25
 May 2023 09:07:01 -0700 (PDT)
Date:   Thu, 25 May 2023 09:07:00 -0700
In-Reply-To: <7cb6c4c28c077bb9f866c2d795e918610e77d49f.camel@intel.com>
Mime-Version: 1.0
References: <20230505152046.6575-1-mic@digikod.net> <93726a7b9498ec66db21c5792079996d5fed5453.camel@intel.com>
 <facfd178-3157-80b4-243b-a5c8dabadbfb@digikod.net> <7cb6c4c28c077bb9f866c2d795e918610e77d49f.camel@intel.com>
Message-ID: <ZG+HpFjIuSWvyo+B@google.com>
Subject: Re: [RFC PATCH v1 0/9] Hypervisor-Enforced Kernel Integrity
From:   Sean Christopherson <seanjc@google.com>
To:     Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     "mic@digikod.net" <mic@digikod.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "marian.c.rotariu@gmail.com" <marian.c.rotariu@gmail.com>,
        Alexander Graf <graf@amazon.com>,
        John S Andersen <john.s.andersen@intel.com>,
        "madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
        "ssicleru@bitdefender.com" <ssicleru@bitdefender.com>,
        "yuanyu@google.com" <yuanyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tgopinath@microsoft.com" <tgopinath@microsoft.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "will@kernel.org" <will@kernel.org>,
        "dev@lists.cloudhypervisor.org" <dev@lists.cloudhypervisor.org>,
        "mdontu@bitdefender.com" <mdontu@bitdefender.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "nicu.citu@icloud.com" <nicu.citu@icloud.com>,
        "ztarkhani@microsoft.com" <ztarkhani@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 25, 2023, Rick P Edgecombe wrote:
> I wonder if it might be a good idea to POC the guest side before
> settling on the KVM interface. Then you can also look at the whole
> thing and judge how much usage it would get for the different options
> of restrictions.

As I said earlier[*], IMO the control plane logic needs to live in host userspace.
I think any attempt to have KVM providen anything but the low level plumbing will
suffer the same fate as CR4 pinning and XO memory.  Iterating on an imperfect
solution to incremently improve security is far, far easier to do in userspace,
and far more likely to get merged.

[*] https://lore.kernel.org/all/ZFUyhPuhtMbYdJ76@google.com
