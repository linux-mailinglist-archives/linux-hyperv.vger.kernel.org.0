Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2F465C09
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Dec 2021 03:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbhLBCQu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Dec 2021 21:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbhLBCQu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Dec 2021 21:16:50 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C2C061756
        for <linux-hyperv@vger.kernel.org>; Wed,  1 Dec 2021 18:13:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so19118979plr.11
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Dec 2021 18:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xqdq69bklkVGPaiuC/hhcniUDsb69a5Tsomp+eMdT8Y=;
        b=kLe2Jr2E6gqbImzVXFbWuWelxOvMTjUr3eE3r6UXGeXlSFHQJujz3lKGG1L8GrT/jA
         tZc+qlJVZ58JjH0g5XNMGk6jNl01J+5YdmbMgSs4RYG+rZnunYfoVS5CVwrghZldDJyO
         QsL/vfDrNDDfrswvVpKh4G3/Rp546pliFVtuK/l3YPREcTeI5wXswL8GsLhOo8t+L3zO
         eEWvcu/xAKtGB5MCBINyHO9v189tvqdZBzA343XYcBSiMvbmvZ5h5HhvMN1neTO3sFuf
         4KjN5JhpI1gvBnhZ1ekaA2hzk6QsMmK5uzhPhUAXOQETZO338FaIlVCWBJjU9Mdq9WON
         fmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xqdq69bklkVGPaiuC/hhcniUDsb69a5Tsomp+eMdT8Y=;
        b=LbRhWvR4AewkuTV+2lAPQWj3ckj01c7gacLmSf9Eu7EbgggUQG3Qx5mkrTBocgcna8
         hFYhzjMV+Qs4wUHXPC7enJKTgnWPkTOruaSYh5EnDY2fMTAlZJi5MB9knOIYk7FpGOhd
         f+0X36Si6gYJkbk/STyF6CNTsYPZkTb3SMHlTCaFxjzI9jpOJfIfYuYXgsAsHXslSq2p
         m9E5hY4vK52zqEd9ksSrUpqViZe6Q/6fi8+Gst58mJ4nlME+Q4x7pqa5PJN0arnBnoTi
         pnHo6RKk7Ny7RbSa/SLxuvPXfXlyVln3waaIyEm5PtzlEuLm71L4AhKIVIQw1h3N4jOf
         h+0g==
X-Gm-Message-State: AOAM530u+ZRdAO7ZKPsiSeq7PAvxifVaYXcbchr857cjdmMW89iYr/eb
        FpNQu9z69Ikja9HHdH4+JxUJbfH8y2pGTQ==
X-Google-Smtp-Source: ABdhPJwI9/kW+841BCq3bJVjpyet3MmhhrawiCLnHAmmZ9PuYqso3ZTZlCgmtcoT/lCxdVVnUZYA0g==
X-Received: by 2002:a17:90b:92:: with SMTP id bb18mr2454366pjb.133.1638411208204;
        Wed, 01 Dec 2021 18:13:28 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j7sm1152501pfc.74.2021.12.01.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 18:13:27 -0800 (PST)
Date:   Thu, 2 Dec 2021 02:13:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 8/8] KVM: x86: Add checks for reserved-to-zero Hyper-V
 hypercall fields
Message-ID: <YagrxIknF9DX8l8L@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-9-seanjc@google.com>
 <87v91cjhch.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v91cjhch.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 01, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Add checks for the three fields in Hyper-V's hypercall params that must
> > be zero.  Per the TLFS, HV_STATUS_INVALID_HYPERCALL_INPUT is returned if
> > "A reserved bit in the specified hypercall input value is non-zero."
> >
> > Note, the TLFS has an off-by-one bug for the last reserved field, which
> > it defines as being bits 64:60.  The same section states "The input field
> > 64-bit value called a hypercall input value.", i.e. bit 64 doesn't
> > exist.
> 
> This version are you looking at? I can't see this issue in 6.0b

It's the web-based documentation, the 6.0b PDF indeed does not have the same bug.

https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface#hypercall-inputs
