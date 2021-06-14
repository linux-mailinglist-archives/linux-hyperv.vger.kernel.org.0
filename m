Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574533A5DE0
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Jun 2021 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhFNHuH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Jun 2021 03:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232524AbhFNHuG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Jun 2021 03:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623656883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVVQDAqE2mNu93zrjVnb7Wt06L1/09jtCkVYdV1XAfc=;
        b=YkWQLAGs4500hMYddsrdqMOqX2wgsZO1Qbz7DTWm7u7/0mrEdXZ7NKBrFzhdX3isi5JD7r
        uA1TKyZSpVPbfl66vUu8xMvW51gpYiLdI2xwpWC2leibv5I+oRUkZcvyPRaqbC089mnVlR
        5dYYkepuyC1YAnLj9rRvXXsJAcGZJfo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-5NYuluYHPjK-Hv9MgaMIXw-1; Mon, 14 Jun 2021 03:48:02 -0400
X-MC-Unique: 5NYuluYHPjK-Hv9MgaMIXw-1
Received: by mail-ed1-f69.google.com with SMTP id z16-20020aa7d4100000b029038feb83da57so19738584edq.4
        for <linux-hyperv@vger.kernel.org>; Mon, 14 Jun 2021 00:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uVVQDAqE2mNu93zrjVnb7Wt06L1/09jtCkVYdV1XAfc=;
        b=UBElKkzqooVtqwtuu1TEjvR5kis1+laZmq+cvpL0fC1M+lxSLqNnGbjuQEcVr/3j8a
         eMdm24BBcpp6pH6JNvNCJZLaWAwK/l+Iu7jqbdeeSONZwD7CT3TYs67s5NP2ZQVU/9zN
         oBkOjsfG/yTNCBW3VqDYNRSONWMN2tAcw6BzHzId89ZK1DYtPpRdgurxNrY6tIjyG3iS
         0CCJstFohlL1KZeRDfulQ5I/aDi1oWuPEbdojYHvh4I+WqTBeNfYnBg8TomfWFo7m0Ls
         zKiyoJ8yqOIv/746ZWdKpsxGrhh48vAPSjhyeA2s+TwV6Dy19osSbrXufdhM2TiOcPWI
         3lkA==
X-Gm-Message-State: AOAM531662D0YZIS0ju/fO4h+S93dU0AP19GDiCbsz3+JKyhwbqjUp/T
        ghY0VCmk+lrDgcy5SLnqgvj6eBPd6C2OOyCKfZeoHJOQdqqHV/n1VEGbCc17smVt5+u59qWWDOF
        Apw44lh/EEYEGlRMY9Gn/5kKM
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr15927078edt.194.1623656881435;
        Mon, 14 Jun 2021 00:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR5ViPXNZ/W1P6S7MeGqL1karb6GMvkiVX7a6Cj3XRWtU7Ght+0fiIaUQS7VaSMZPx0qyfEA==
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr15927063edt.194.1623656881266;
        Mon, 14 Jun 2021 00:48:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h8sm6839060ejj.22.2021.06.14.00.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 00:48:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH v5 0/7] Hyper-V nested virt enlightenments for SVM
In-Reply-To: <50dea657-ef03-4bde-b9c7-75d9e18157ea@redhat.com>
References: <cover.1622730232.git.viremana@linux.microsoft.com>
 <5af1ccce-a07d-5a13-107b-fc4c4553dd4d@redhat.com>
 <683fa50765b29f203cb4b0953542dc43226a7a2f.camel@redhat.com>
 <878s3gybuk.fsf@vitty.brq.redhat.com>
 <50dea657-ef03-4bde-b9c7-75d9e18157ea@redhat.com>
Date:   Mon, 14 Jun 2021 09:47:59 +0200
Message-ID: <87wnqwx4y8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> CONFIG_HYPERV=m is possible.

We've stubmled upon this multiple times already. Initially, the whole
Hyper-V support code was a module (what's now in drivers/hv/) but then
some core functionallity was moved out to arch/x86/ but we didn't add a
new config back then. Still suffering :-)

Ideally, we would want to have 

CONFIG_HYPERV_GUEST=y/n for what's in arch/x86/ (just like CONFIG_KVM_GUEST)
CONFIG_HYPERV_VMBUS=y/n/m for what's in drivers/hv

-- 
Vitaly

