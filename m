Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7486758FE13
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Aug 2022 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiHKOJ1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Aug 2022 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHKOJ0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Aug 2022 10:09:26 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992768E0F9
        for <linux-hyperv@vger.kernel.org>; Thu, 11 Aug 2022 07:09:25 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id q30so21453695wra.11
        for <linux-hyperv@vger.kernel.org>; Thu, 11 Aug 2022 07:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Sqs2PvRmwGPdOyywQqRBTkyzeTM9l/iL0KxaH7r24ps=;
        b=yH973ce8GI3eWYFqgIwEnpxUtYx7CyQshkE5XyIxnKcT6RnQQrBMtCzfxx8NyfjyK0
         x7bHh9pj/sJK/ihz0JwWoT3RhqgjBy8SyZgOU3H4DU3mZU00ENzcAK8Z1ToXDmfLF5bY
         L2ol/h/o5XgxiuLdnjc0rSXvva9U8T/OuZrQ3AA1h2Dfk0qOcp73lb950UXoUtkynTBA
         PvVBZqFh50aKcuBxyME/piz9Db3NaZEHHpGm25Wlyj3aZFCCRpupr1wgpQX1NUsjuaAZ
         GSXxqsuZhWR1KEWxdTWpobIgzB9KMrUhgWatqr2w/2IZKM8WN8ypmHEcCzC5Dirh8BhJ
         R+Qw==
X-Gm-Message-State: ACgBeo37qzg5NNsHmWy4M6mIU+Zh4zNuK4Pg0HGwBYCE2k48CPyaXDgo
        PbTf4o42D7JsuGsIcoHOl48=
X-Google-Smtp-Source: AA6agR7tlAjSYEpdm6WgkBG7uIU6b7o+2gMte55/JL6yo3e6L1eZm8En+O/qKzGNOijiV3RQptwd/A==
X-Received: by 2002:a5d:5957:0:b0:220:6004:18c2 with SMTP id e23-20020a5d5957000000b00220600418c2mr20146692wri.568.1660226963714;
        Thu, 11 Aug 2022 07:09:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003a38606385esm13738429wms.3.2022.08.11.07.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 07:09:23 -0700 (PDT)
Date:   Thu, 11 Aug 2022 14:09:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Anish Gupta <anish@exotanium.io>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: Booting Xen dom0 on Hyper-V
Message-ID: <20220811140921.efcxjqzgkuqi2jlk@liuwe-devbox-debian-v2>
References: <43091FDA-F0E9-42CE-8B15-A57F3B0C5B4A@exotanium.io>
 <20220810111917.f4wunm24engy2sia@liuwe-devbox-debian-v2>
 <9D5C70C3-A0BB-4B3B-902C-0C9C58AAF105@exotanium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D5C70C3-A0BB-4B3B-902C-0C9C58AAF105@exotanium.io>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Anish

Please use reply-all in the future. And please use bottom-posting style
and wrap your lines to about 72 characters wide.

I added the list back.

On Thu, Aug 11, 2022 at 06:45:27AM +0530, Anish Gupta wrote:
> Hi Wei,
> 
> Thanks again for your reply.
> 
> >The initial development work was done on a Gen1 VM locally with emulated
> > 
> > hard drive and network adapter. Azure Gen2 VMs don't have emulated
> > devices.
> 
> 
> Do you remember the Gen1 VM type with emulated device that you used? I
> am new to Azure and still trying to figure out things. If I know the
> instance type, I can work with Azure support team to get my hand on to
> one of those old VMs and use that as base to start digging for vmbus.

No. The VM I used was on my local machine. I did not do my development
with an Azure VM, because that would be impossible to debug (at least at
the time for me).

Probably when you pick a Gen1 image on Azure you will get a Gen1 VM. Or
you can ask directly the support team how you can get a Gen1 VM.

Thanks,
Wei.

> 
> Regards,
> Anish
