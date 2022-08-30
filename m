Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AC85A5CF4
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Aug 2022 09:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiH3HcW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Aug 2022 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiH3HcE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Aug 2022 03:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD048C96
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Aug 2022 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661844722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OOVt4IExjzgPDgf7VEi0MGTcB1ysxhPeqK70kuHJ9WU=;
        b=PgbZ21vyZAoNTKi8Sm/aK8OuoLL375xcukdxwB1q/CiSfBeNVCqARyni+ZMyhfcZ1tZU7Q
        CSu/SQgw0+T61cLCJpmiCDIN5mLNUEog7BbvZYiAE1A+1FyhlVxyGc2LoXavi5dEFTC+ec
        vbpkyFx4kdkzllo1JCNPQEOPB1HLE/k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-S0yu_fOGPHGYBda5VZMdfw-1; Tue, 30 Aug 2022 03:31:57 -0400
X-MC-Unique: S0yu_fOGPHGYBda5VZMdfw-1
Received: by mail-ej1-f69.google.com with SMTP id sg35-20020a170907a42300b007414343814bso2675614ejc.18
        for <linux-hyperv@vger.kernel.org>; Tue, 30 Aug 2022 00:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=OOVt4IExjzgPDgf7VEi0MGTcB1ysxhPeqK70kuHJ9WU=;
        b=yUph3Z+oCkojz3Q0PwUf0vaWke0sByJY15Qlp2yENBdh36lq0gjBphr3lZ5vMmbmd2
         2StQcvyKveSYnCVXGvv7MEmkv7RRnVhwEpx3m7JL6HkIX30pAJa2VP+LXtD30dko5Mtj
         Vk0wvNtyqPJhF/JBCbWkkOB4D5sbi5z1hVDCzgYFZlRm70/ltewWoL6M7Fjq2nSFx4bx
         evKItst3Wm2nJB4GLo5APaBDMDjlavwqC8C+vfLHs0PyAmEmubFyJfhEHSki+RH6KlVk
         eaMsrR9GSHV43RCgwOWajh8PCQXao1LFrdZCpjBKPgot5mU0GkELaA44sat+NydGAPOB
         ucFA==
X-Gm-Message-State: ACgBeo1nSnmM/oE94rxcsaoEAyg5tPs/ZDafvjrTALIYSpnbYZwC6quF
        467qm3aAojuJz67+QB8+x8nwKqCusNWqd2CMbQuKlnWbrUzCF8+YluGuehiwYsDLxpRtGZAUg9N
        WV4GosGz0MEVxAfv9m0xYqtQ+
X-Received: by 2002:a05:6402:40c3:b0:442:d798:48ad with SMTP id z3-20020a05640240c300b00442d79848admr19116998edb.154.1661844716126;
        Tue, 30 Aug 2022 00:31:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5geuesvzHhVoqBxInKeA8loMmBCSHKoxr3j6EnwNKzcho7wEaeR3bBW9svuet4LzxXa/fI2w==
X-Received: by 2002:a05:6402:40c3:b0:442:d798:48ad with SMTP id z3-20020a05640240c300b00442d79848admr19116988edb.154.1661844715957;
        Tue, 30 Aug 2022 00:31:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b00731745a7e62sm5367557ejg.28.2022.08.30.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 00:31:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3 1/3] PCI: Move
 PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO definitions to
 pci_ids.h
In-Reply-To: <20220829171508.GA8481@bhelgaas>
References: <20220829171508.GA8481@bhelgaas>
Date:   Tue, 30 Aug 2022 09:31:54 +0200
Message-ID: <875yiauqz9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Sat, Aug 27, 2022 at 03:03:43PM +0200, Vitaly Kuznetsov wrote:
>> There are already three places in kernel which define PCI_VENDOR_ID_MICROSOFT
>> and two for PCI_DEVICE_ID_HYPERV_VIDEO and there's a need to use these
>> from core Vmbus code. Move the defines where they belong.
>
> It's a minor annoyance that the above is 81 characters long when "git
> log" adds its 4-character indent, so it wraps in a default terminal.
>
> It'd be nice if we could settle on a conventional spelling of "Vmbus",
> too.  "Vmbus" looks to be in the minority:
>
>   $ git grep Vmbus | wc -l; git grep VMbus | wc -l; git grep VMBus | wc -l
>   4
>   82
>   62
>
> FWIW, one published microsoft.com doc uses "VMBus":
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/hyper-v-architecture

Makes sense,

Wei,

assuming there are no other concerns about these patches, would you be
able to tweak the commit message here when queueing or would you like me
to send v4 instead? 

Thanks!

-- 
Vitaly

