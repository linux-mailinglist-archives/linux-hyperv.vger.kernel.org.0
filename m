Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0C587CD7
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Aug 2022 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHBNDx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Aug 2022 09:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiHBNDv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Aug 2022 09:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFE871B7BF
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Aug 2022 06:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659445430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9G2G8Gu5RKJUdwRd8+XrMp7icbYEK8BR98QSXem+dE=;
        b=TMDX5rlJI50Fx9abWglZbphTmZTWg/xv/1D6O7EyE4aId4xcLxTao18bnjUJVdS24VvaYI
        aNfn9xywEtxCMvlWuULAaj5B7KAn0CKU6eigqBsIaN6zxYr0Yu+ndKjsSXYvHMgv9IVhiq
        Zq8qg6t8qdJi8tbwhrRX22/CwYo0Sjc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-w4FAm-_jNjqVMeZRF9z5AQ-1; Tue, 02 Aug 2022 09:03:41 -0400
X-MC-Unique: w4FAm-_jNjqVMeZRF9z5AQ-1
Received: by mail-wr1-f69.google.com with SMTP id t12-20020adfa2cc000000b0021e564cde06so3509728wra.17
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Aug 2022 06:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q9G2G8Gu5RKJUdwRd8+XrMp7icbYEK8BR98QSXem+dE=;
        b=FvMWkUhnajSdylqv4I5cRo/UEuaEEfraD3+NuxhSRetjKrKjyeYDgteMutqZU43iiD
         IJoAGVHU/MEN+GSG0oc0P/QpSu7C3VJc6u/z1bTwv74bAPyS5cGVxY8p2zgrpC5Xq9GF
         bSwdhPvN/sIJ1gOD0FtBXan11HcoHOtsD64qULJpcGKC1sCJ83LTO9QYzCJeSCayjYOa
         0lGLs+AKBkqju+dNOgcDkoDM1ty51YGz/oAcZe0ibOvDdzL0Z4JkM5Cag7dQc+Ni9RwJ
         2D2bBfB4d6hPFw+71r9+T5O2/uG9AYp+tGnXp2O7fA+5i3DVpfvQlKcS9eEHCjhDag5q
         a/lg==
X-Gm-Message-State: ACgBeo0N9nWngdYgNX7cAGKQohBGntQuE9kfvicCjxJ9Hk2Nt0kEBI8m
        Q0RbuuAw6CcCJRCR2PA4gnSTd4LmWKF1YXyh02S6Yijgz4hKdCaqd2lTHMbc42sgrL8XjX/ONo9
        M95NAnTP803SvQLhL4Dz8oar9
X-Received: by 2002:a5d:64e2:0:b0:21d:38e8:2497 with SMTP id g2-20020a5d64e2000000b0021d38e82497mr12253759wri.142.1659445420265;
        Tue, 02 Aug 2022 06:03:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DOS3SQRla4MpJdwzB2g2Z3+URqWp8A6RPEqmiNSoJz93I9qLSiQKDBTUSjxU0zCoo/8ZISQ==
X-Received: by 2002:a5d:64e2:0:b0:21d:38e8:2497 with SMTP id g2-20020a5d64e2000000b0021d38e82497mr12253733wri.142.1659445419933;
        Tue, 02 Aug 2022 06:03:39 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003a31673515bsm26399540wmq.7.2022.08.02.06.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 06:03:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/25] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
In-Reply-To: <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-10-vkuznets@redhat.com>
 <YtnMIkFI469Ub9vB@google.com>
 <48de7ea7-fc1a-6a83-3d6f-e04d26ea2f05@redhat.com>
 <Yt7ehL0HfR3b97FQ@google.com>
 <870d507d-a516-5601-4d21-2bfd571cf008@redhat.com>
 <YuMKBzeB2cE/NZ2K@google.com>
 <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
Date:   Tue, 02 Aug 2022 15:03:35 +0200
Message-ID: <87les623x4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 7/29/22 00:13, Sean Christopherson wrote:
>> The only flaw in this is if KVM gets handed a CPUID model that enumerates support
>> for 2025 (or whenever the next update comes) but not 2022.  Hmm, though if Microsoft
>> defines each new "version" as a full superset, then even that theoretical bug goes
>> away.  I'm happy to be optimistic for once and give this a shot.  I definitely like
>> that it makes it easier to see the deltas between versions.
>
> Okay, I have queued the series but I still haven't gone through all the 
> comments.

The biggest problem with this version is the EFER.LMA problem on i386
discovered (and, thankfully, fixed in the suggested patch) by
Sean. To address this and all other comment I'm going to put together a
v5 on top of the current kvm/queue (as I don't yet see any of this stuff
there).

>  So this will _not_ be in the 5.21 pull request.

At first I thought you meant 5.20 but then I got the pun: 5.20 will
likely become 6.0 and so 5.21 pull request will just never happen :-)

-- 
Vitaly

