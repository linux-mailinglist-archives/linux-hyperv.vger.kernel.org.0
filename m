Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02C5E6931
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIVRJW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiIVRJV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 13:09:21 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339ADFFA4A
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 10:09:20 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id d64so10197800oia.9
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Sep 2022 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SCH41PZHoDU628bdtYlErvnzmog8gkI9vkvu5Tjn52s=;
        b=ncNtd1PSg4kUznwkkXE+qWSY1m9YVzp63INmh6bBgJQkic26IxE037zM8bQxTL6I8X
         kD0ghv6o0UOt/bxoN+DaenaNoPAesHvwIyP3y2fPJ1tH1YX6fRYOc4THXcEfNMOlq7Kf
         1VvyaXorhfKSTaPyaJMbv73J3ZFDOxyCszTGD/MqxdsaPajpAa1GXKgoEAsIelQPj6t4
         xXWX4IlAXDOKOP37HtEZrOIwxzLmEwCzM5CUBjTidSUA1pBETqXur7wIKvFD+2wUYwUS
         CcN/64DD8idi/BHFdC2czjdp5Q2Sr0HwkMIZn+XLyiNAEwjTAQS7Ij3pQrgRy2gokILg
         nNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SCH41PZHoDU628bdtYlErvnzmog8gkI9vkvu5Tjn52s=;
        b=dTpDhu7jTNRmzrNYAnYEHFC1VDX+XtuC5NS5h5mExFcGi0Cbv8ieEGGd4zToqtnTBe
         +cpa+m3YEYgy2jU1If4+ZTSk9umUytV14z+Zhk9v7xQBQd4smvvlj0slM52LMwh7lOZK
         cE6jdVml53/5XhUfigUMRn8LXe59TTmhs19eIJdSVXUiIXHPoeuhTvgWuhMuZ2li74wg
         7kGs0zHFb7pYnj1qmkBP+aSHRL0+bmHZ6f1wfLntHzf3BSWZO+XKb3bt4ds83wFqByHu
         5FC/otirCUjGCekJQ2VymhDCvurPzq5nGbb0tHnAsGlpJF2Qx5svvot5kj+wLazteiV+
         XMzg==
X-Gm-Message-State: ACrzQf2XQwAgRVwamI77BLfq4e96fe5xuer7cJqpR4AzmhZ+Grzm60tR
        TFbo3r1Rq7qVJVfBty7uJzSdUDxb5AA1ltCzKGcJUg==
X-Google-Smtp-Source: AMsMyM4cudPwjpo5sIQdFq8qIK/InHXSVSkRir2eTxuIg3sDXCu48Ri/NTXF5br4Ip4LRDZM71GXejwYXBh+g+ZSfQk=
X-Received: by 2002:a05:6808:f8e:b0:351:a39:e7ca with SMTP id
 o14-20020a0568080f8e00b003510a39e7camr698564oiw.269.1663866559313; Thu, 22
 Sep 2022 10:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922143655.3721218-1-vkuznets@redhat.com> <20220922143655.3721218-3-vkuznets@redhat.com>
In-Reply-To: <20220922143655.3721218-3-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 22 Sep 2022 10:09:08 -0700
Message-ID: <CALMp9eSVQSMKbYKr0n-t3JP58hLGA8ZHJZAX34-E4YWUa+VYHA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] KVM: x86: Introduce CPUID_8000_0007_EDX
 'scattered' leaf
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Why do we need a new 'scattered' leaf? We are only using two bits in
the first one, right? And now we're only going to use one bit in the
second one?

I thought the point of the 'scattered' leaves was to collect a bunch
of feature bits from different CPUID leaves in a single feature word.

Allocating a new feature word for one or two bits seems extravagant.
