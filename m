Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC45A61326B
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Oct 2022 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJaJT0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Oct 2022 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJaJTV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Oct 2022 05:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C3DD2CD
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667207905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wEf8cRb4TLYPYASggaPulamyqh6fRxomZhqUsJe70lA=;
        b=JNju3m/nRBMX092vQ3W4go73D3qWawC3RkucJ7bVxDJJ0fgXOy7znZjTv86Mru2t/ITGSq
        46hEJqsjXaoPT+iMnc8hb4gNSvnT2xpd4JDIfxABg30ON8D2kueF4h6ioWjlckOYiCa98l
        sY7AhcjzC+fMKCC1iKMqmQtfq4Y81dE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-x0pjJesPOiOQV3zUAn61Rg-1; Mon, 31 Oct 2022 05:18:24 -0400
X-MC-Unique: x0pjJesPOiOQV3zUAn61Rg-1
Received: by mail-qt1-f198.google.com with SMTP id fb5-20020a05622a480500b003a525d52abcso1389128qtb.10
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 02:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEf8cRb4TLYPYASggaPulamyqh6fRxomZhqUsJe70lA=;
        b=DNjzaKqBoQd6S3XBG86EsSsTMKzOhh2j+6D9L9L/olbm42WErL91zDT0ziiLMUfY9D
         DL7qnquM2OwL5ECSdNczY0xb4OaaKxx5B1iGVjgT+XfPQ8X9AcA/7eum7mXOwdvScfg5
         TYsxEaEdBp/qb7SkABzuUVYK24CI1a2ktBbFbvyV3Ps/BlaqhiNAbrRDcusyPiF5JXv9
         tPQriQfkt+bbJhzdHjtCoHWCbJTbWwwnuzn6fot5HX+3cKmriaxe7D6cl05TQuR6xufh
         9XFcjtMltwdmKvU5ge7fENA3/ku6N29bHgEo0oR4sqZ8YGEyPfSi3+5TgKK7vBSoh0aA
         RtPA==
X-Gm-Message-State: ACrzQf15GSJb3x7sGG0DmKevK8o3Xc8qC/zY1XixWLiIVJmgBv4YybHH
        ouZCrR8dG/yQeCfb7jhZNoN1Vpk9a+DKf0Owmae8KkRvnAzzEUSWOxI+rMfUtCam8jd3jKbnSGj
        d3IIckXmTlYuStKtTiyQYFEn0
X-Received: by 2002:a05:620a:199f:b0:6ee:bbd2:4c50 with SMTP id bm31-20020a05620a199f00b006eebbd24c50mr8364042qkb.500.1667207903669;
        Mon, 31 Oct 2022 02:18:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4olZT6py2Dkvc62FgswOCrOLSA+9D1FbQFn4jFwUP7lTvfqZXuIVpxdtJRuQF/qYD1vFf9DA==
X-Received: by 2002:a05:620a:199f:b0:6ee:bbd2:4c50 with SMTP id bm31-20020a05620a199f00b006eebbd24c50mr8364026qkb.500.1667207903435;
        Mon, 31 Oct 2022 02:18:23 -0700 (PDT)
Received: from ovpn-194-149.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g1-20020a05620a40c100b006cebda00630sm603594qko.60.2022.10.31.02.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:18:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/46] KVM: x86: hyper-v: Fine-grained TLB flush +
 L2 TLB flush features
In-Reply-To: <Y1m1Jnpw5betG8CG@google.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
 <Y1m0ef+LdcAW0Bzh@google.com> <Y1m1Jnpw5betG8CG@google.com>
Date:   Mon, 31 Oct 2022 10:18:19 +0100
Message-ID: <87zgdcs65g.fsf@ovpn-194-149.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Oct 26, 2022, Sean Christopherson wrote:
>> On Fri, Oct 21, 2022, Vitaly Kuznetsov wrote:
>> >   KVM: selftests: evmcs_test: Introduce L2 TLB flush test
>> >   KVM: selftests: hyperv_svm_test: Introduce L2 TLB flush test
>> 
>> Except for these two (patches 44 and 45),
>> 
>> Reviewed-by: Sean Christopherson <seanjc@google.com>

Thanks! I'll take a look at 44/45 shortly.

>
> Actually, easiest thing is probably for Paolo to queue everything through 43
> (with a comment in patch 13 about the GPA translation), and then you can send a
> new version containing only the stragglers.

Paolo,

do you want to follow this path or do you expect the full 'v13' from me? 

-- 
Vitaly

