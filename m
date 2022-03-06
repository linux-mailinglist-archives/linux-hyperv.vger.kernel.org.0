Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F44CEA93
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Mar 2022 11:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiCFKwy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Mar 2022 05:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiCFKwx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Mar 2022 05:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C361A42EE7
        for <linux-hyperv@vger.kernel.org>; Sun,  6 Mar 2022 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646563920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVPsJI++8NxTvQuxgpBGAj3rYePyGMR0RrHuKmSxq8k=;
        b=XMELMaauiFbZkJ+VFo3O4MZpkDS8TJPaDtzS3Zc9AM7ajIUe9RMLwv//j1NaT/W3K9O9Ed
        5irV4PjmjkfPXSZlj3ktwd+0FuS3op6YqPfzV4SlTg/QShi4206DPyvt05FY7y+DQxfEgH
        k3MRQC6z4k7H/VBnHp0gNN3Sq7Espnw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-AtMtshlROGOtIriESlE86A-1; Sun, 06 Mar 2022 05:51:59 -0500
X-MC-Unique: AtMtshlROGOtIriESlE86A-1
Received: by mail-wm1-f72.google.com with SMTP id 14-20020a05600c028e00b003897a4056e8so3155271wmk.9
        for <linux-hyperv@vger.kernel.org>; Sun, 06 Mar 2022 02:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iVPsJI++8NxTvQuxgpBGAj3rYePyGMR0RrHuKmSxq8k=;
        b=LLJzH+oLO/zmkPQgw/W5eOidOuUc8wNEH0UkSeBJ0a0X7/02iIivWfMs2+k5XWX4MK
         r0WayeAvSzL9rsHb8+OZ0kqWuQplhTbGhwzezWwZBsEvirsFLhVnBdOH+ngJUZ1MG5PK
         DrFNzotuG3Wu3k3AYrgmKFTV6bdwWQ2/jDwLYiyhNPs8FABY2Vl26wi5ExkDM4nbpXiF
         6KvbZbfoI3D1IlSuxxxPGDPq4NJVGjdycATGeY1LZlF6slgdjiBK8ykjYIiRDRFj8djM
         V9Y3cyCIvAB2VOXalYzyO1DG27d27tt64IEgB7JbkBz9IqZUbj/z2evJve5c97yih8mi
         QUwA==
X-Gm-Message-State: AOAM530hy71HofQiuR9ZhR2DM2P2KBjnA65fTRZk9G18kSovhiCLArFd
        18d1FQfPZxzQsrMjE+TFAL2EApOyUjozgCE7fi6X67ovbEiOgygEIKgsfXgJZTCrlZAa3PBssCE
        NZRVD4NN+IQ6SAC2WVUMRJH7c
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr5362107wmc.130.1646563918151;
        Sun, 06 Mar 2022 02:51:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4kHksoHXBhkHSVL8W5sWONv/Xj5su2acSsqZQ8EHOl6htL6S1vVyXLg1NZgl/COehMlmxKQ==
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr5362087wmc.130.1646563917917;
        Sun, 06 Mar 2022 02:51:57 -0800 (PST)
Received: from fedora (ec2-3-80-233-239.compute-1.amazonaws.com. [3.80.233.239])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm15657788wmv.31.2022.03.06.02.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 02:51:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: hyperv: make the format of 'Hyper-V: Host Build'
 output match x86
In-Reply-To: <MN0PR21MB309826D5A9E262A65E0E07F9D7059@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220304122425.1638370-1-vkuznets@redhat.com>
 <MN0PR21MB309826D5A9E262A65E0E07F9D7059@MN0PR21MB3098.namprd21.prod.outlook.com>
Date:   Sun, 06 Mar 2022 11:51:51 +0100
Message-ID: <875yorbbg8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, March 4, 2022 4:24 AM
>> 
>> Currently, the following is observed on Hyper-V/ARM:
>> 
>>  Hyper-V: Host Build 10.0.22477.1061-1-0
>> 
>> This differs from similar output on x86:
>> 
>>  Hyper-V Host Build:20348-10.0-1-0.1138
>> 
>> and this is inconvenient. As x86 was the first to introduce the current
>> format and to not break existing tools parsing it, change the format on
>> ARM to match.
>
> Interesting.  I had explicitly output this line differently on ARM64 so
> that the output is in the standard form of a Windows version number,
> which is what the Host Build value actually is.  My intent is to fix the
> x86 side as well.  I had not anticipated there being automated parsing
> of these strings.
>
> I had also put the colon in the place to be consistent with most
> other Hyper-V messages.  I know:  picky, picky. :-)
>
> What's the impact of changing the tools that parse it so that
> either version could be handled?

I wish we knew what tools are out there parsing this line :-) The issue
got reported by QA as 'inconsistency'.

As the format of this string was never promissed to be an ABI I think we
can go the other way around: change x86 to match ARM. Some scripts may
need fixing but IMO this is acceptable. Let's just promiss to not change
it in the future :-)

-- 
Vitaly

