Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC95C0445
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 18:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIUQfj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiIUQfM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 12:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98091A7AAA
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663777058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FfcSWDyvK8gG5N4a1A9EOaJbBSk6wOatfd9ejRCTkqM=;
        b=i3SG3/n9U5uqIDJg1Ytb/pVHWxKNguZ8x+NcF4DRC9WI+zXy5hLyIyV3fKY+9FW0twezt4
        sdFX1Kv1pQs1RKyRAe7lavbpogq8Wlt2cjp45Kh3QN1Op4mppozpe05Yek6KPXd9wSdj3z
        qjDNlrWcNJddIFi4rnfQhAImTdqXKlo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-dDR6vmRwPEOQvHvPYBhxsw-1; Wed, 21 Sep 2022 12:17:36 -0400
X-MC-Unique: dDR6vmRwPEOQvHvPYBhxsw-1
Received: by mail-ed1-f72.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so4782722edz.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Sep 2022 09:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=FfcSWDyvK8gG5N4a1A9EOaJbBSk6wOatfd9ejRCTkqM=;
        b=xyW2XXHANDmMh0nesEG7NKWmqdGTO7X1CQKqyJpjRyzj7IdxeNXhYPo9YDVsLbYOFw
         U+mrd+3CgnYY0N+sGMcnQG/nnDTyzT86/Pw3tEAD7Sr0Ks1QFknF/cfWkIoeFHCgnlJT
         TAnf49yAU94bGsWXbHVvDKYPsG2LjdhFIknqWs+okUwHVdRy239mtSMaEqqpk4Ru04uB
         cM2Img+qVss1p/zhNSrgXH+cuAXnJKsiYXigSp3zxH9Imb3HeWOKf6KS+RPC/KGl4AnA
         I7C7MoyuK7RIuFEsJ2r/XQu0PRjRxphShgeEhiwAtdP+p7DHcmtvLZfsehMtTPzBINUS
         ox1g==
X-Gm-Message-State: ACrzQf2CX3mfFEEdCEs9q3QBZWp6I9BkzwdxxUmWGMuQp6kYQ/ZtQWPu
        uP1aHpo9T20HSbUk00tJHzPabHbbnZBOcsZfMFTDYTq3NMt9dTq/bz0UrnecjLBk84wnB08zO7r
        cNZMJnTKToNQFk9g6S5A78eM3
X-Received: by 2002:aa7:d617:0:b0:44e:d2de:3fe1 with SMTP id c23-20020aa7d617000000b0044ed2de3fe1mr26164135edr.104.1663777055783;
        Wed, 21 Sep 2022 09:17:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM58VTewJJPKmz/ZoiZ0+8xhb98FXISDzqGdAWAP+DQt5crsRNfxwSLeqyF4RjyCWlLrJmoQTA==
X-Received: by 2002:aa7:d617:0:b0:44e:d2de:3fe1 with SMTP id c23-20020aa7d617000000b0044ed2de3fe1mr26164112edr.104.1663777055583;
        Wed, 21 Sep 2022 09:17:35 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906255a00b0073dde62713asm1428988ejb.89.2022.09.21.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:17:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.19 01/16] Drivers: hv: Never allocate anything
 besides framebuffer from framebuffer memory region
In-Reply-To: <20220921155332.234913-1-sashal@kernel.org>
References: <20220921155332.234913-1-sashal@kernel.org>
Date:   Wed, 21 Sep 2022 18:17:34 +0200
Message-ID: <87illgog69.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> [ Upstream commit f0880e2cb7e1f8039a048fdd01ce45ab77247221 ]
>

(this comment applies to all stable branches)

While this change seems to be worthy on its own, the underlying issue
with Gen1 Hyper-V VMs won't be resolved without 

commit 2a8a8afba0c3053d0ea8686182f6b2104293037e
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Sat Aug 27 15:03:44 2022 +0200

    Drivers: hv: Always reserve framebuffer region for Gen1 VMs

as 'fb_mmio' is still going to be unset in some cases without it.

-- 
Vitaly

