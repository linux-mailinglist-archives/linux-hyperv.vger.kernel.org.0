Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B294D2B8B
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Mar 2022 10:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiCIJOn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Mar 2022 04:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiCIJOm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Mar 2022 04:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4FAD3FD9E
        for <linux-hyperv@vger.kernel.org>; Wed,  9 Mar 2022 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646817223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOG/PAqse9zSZ2yDOcQfN7jOgLfXTKKr0q59fyoMcwk=;
        b=Rf2aFb8SNf0bJjeucVxkEXu927ovWl/84Hk28WieJd2PD08h5Nz4BVkRJvF9RbBGwAt4Gi
        crfj2mWmZSanvn8X1TlhCVbdlfpIOZ/C3GtxdJGbR37yc5Xy6oBvTaLP2/J/leqs0ofukt
        qOkkd1QhF2b0bdcLmstnEHyGsyaTZsk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-3dZfVjH-McuCGNbELEkQAg-1; Wed, 09 Mar 2022 04:13:42 -0500
X-MC-Unique: 3dZfVjH-McuCGNbELEkQAg-1
Received: by mail-wm1-f70.google.com with SMTP id c19-20020a05600c0ad300b00385bb3db625so2341640wmr.4
        for <linux-hyperv@vger.kernel.org>; Wed, 09 Mar 2022 01:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mOG/PAqse9zSZ2yDOcQfN7jOgLfXTKKr0q59fyoMcwk=;
        b=n87Ev9Qp2JOdLFrhAW3wny86M2ywq7VOta2N6yza3rYedMFagTycI0rZVEVLSbkUS/
         keuc1jIono2MoE0pRRM0AMf6G64aVvZ4k0n02SCF90Jf2rBIQ00jvwuLwv++N49hKF4Y
         w0g/lX0uFmN9LYOylzhSB0c0bsMAwta8Na/CzL4SutFnEk+8Ni1eDLOHfTm7Vypg7CrZ
         i3RmtyZ/Q+Izv/OPkKUlSC7VNFgqMAb377GjA8VNDJF5Z8k8kb5sdSpi7D9TUwBC2Qbx
         R0vC2TU8E5YnmcUbA7tABgPP6Ite5ykQ6vPNvwY2HTDFB1ApoBGT1b23pvAZppqf593b
         ahcw==
X-Gm-Message-State: AOAM532BlDU9PEJC8W0KaU3EUJSoE/siLDLgFa+PEQY05gT58Ln6jYjK
        XiYNpXhtVfWixozNHV3/fCQ5neG+KQmxIBrOKUvaqjp/tj8x69Sz5lkO+QtRAlVMpOn/onqI/DW
        8mxV2PL8x9O5N5PmUfmxVEp8H75mcRx2HNWNf4oieY+RbhcfkaNTBwZ0HGC5SLgs1VU1DVx2gEk
        ZA
X-Received: by 2002:a05:6000:168e:b0:1f1:faf1:23b7 with SMTP id y14-20020a056000168e00b001f1faf123b7mr9640388wrd.150.1646817221690;
        Wed, 09 Mar 2022 01:13:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweaBimAyyZrv7VWly/q07XyzC7p7a2C8mkUhFK+5TKB0vl3lp2QMtC0tGVt1RE5UTRPIOE3w==
X-Received: by 2002:a05:6000:168e:b0:1f1:faf1:23b7 with SMTP id y14-20020a056000168e00b001f1faf123b7mr9640353wrd.150.1646817221338;
        Wed, 09 Mar 2022 01:13:41 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i8-20020a7bc948000000b003898dfd7990sm1227337wml.29.2022.03.09.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:13:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Output host build info as normal
 Windows version number
In-Reply-To: <20220308204657.v2xdbtx6qsx6n44s@liuwe-devbox-debian-v2>
References: <1646767364-2234-1-git-send-email-mikelley@microsoft.com>
 <20220308204657.v2xdbtx6qsx6n44s@liuwe-devbox-debian-v2>
Date:   Wed, 09 Mar 2022 10:13:39 +0100
Message-ID: <87ee3ba3p8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> (Cc Vitaly)
>
> On Tue, Mar 08, 2022 at 11:22:44AM -0800, Michael Kelley wrote:
>> Hyper-V provides host version number information that is output in
>> text form by a Linux guest when it boots. For whatever reason, the
>> formatting has historically been non-standard. Change it to output
>> in normal Windows version format for better readability.
>> 
>> Similar code for ARM64 guests already outputs in normal Windows
>> version format.
>> 
>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Works for me, thanks!

>
> Applied to hyperv-next. Thanks.

-- 
Vitaly

