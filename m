Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B485631EE6
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Nov 2022 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKUK7F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Nov 2022 05:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKUK7E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Nov 2022 05:59:04 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161551182B
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Nov 2022 02:59:02 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id cl5so19267848wrb.9
        for <linux-hyperv@vger.kernel.org>; Mon, 21 Nov 2022 02:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn0pageb3vMrOV2S4uIIrNzlMkur7z/nGeY1Nx6Ekdk=;
        b=ZZvfVoH/wK2FsLPO/wyWAnePvZ8yQVqJ0GqU1oTY/u1zrNZ2G8hRLOEjcBYz9n9lqa
         2wu/qIwdZMAjEopaLwEDTXa6ZhqX6QxrnKw83RW9UAWr28+m6yOWh3r4BSVCFBs0i9sP
         rR//V64Q9nygbnUivukTkHorxONGlTLtAUSBt71k22S4hAs85PN7XPwK09ShcabYU4db
         rpdtFwkSLs4b/HXCFbgm+YWI8gWoH2j03PvWfan7FRL12270tXBaWTyG19kHtM5bFLsn
         p6t02Uf8I3T9NGW0JmgRlqckidMKP8kheRXj7ySZTDgmo8vfyl12McW4p1+riOjvC1Eq
         eiOA==
X-Gm-Message-State: ANoB5pmU/4aaYoVweP0JBnqm8eWaYuI/kXp10fBjP8LSuYky+o2EH8p4
        EmxYWexVuzz/+hCQSnv2gKc=
X-Google-Smtp-Source: AA0mqf6m8/9WQHqcs4YPSBXppS9F4P1jqgrEzsDKHbDpP0GesACW2wHYOA8TYuBE5rch/XBMo+H+FA==
X-Received: by 2002:a5d:4d0d:0:b0:228:c1a8:6ef0 with SMTP id z13-20020a5d4d0d000000b00228c1a86ef0mr4848856wrt.584.1669028340528;
        Mon, 21 Nov 2022 02:59:00 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c182600b003c6deb5c1edsm12748988wmp.45.2022.11.21.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:58:59 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:58:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Subject: Re: [PATCH v3 0/2] Drivers: hv: vmbus: fix two issues
Message-ID: <Y3tZ6euYqCmiSAXT@liuwe-devbox-debian-v2>
References: <20221119081135.1564691-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119081135.1564691-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Nov 19, 2022 at 04:11:33PM +0800, Yang Yingliang wrote:
> This patchset fixes a double free and a memory leak problems.
> 
> v2 -> v3:
>   Update commit message and comment suggested by Michael.
> 
> v1 -> v2:
>   Add a comment before vmbus_device_register().
> 
> Yang Yingliang (2):
>   Drivers: hv: vmbus: fix double free in the error path of
>     vmbus_add_channel_work()
>   Drivers: hv: vmbus: fix possible memory leak in
>     vmbus_device_register()

I added a new line between the old and new paragraphs in the second
commit.

Applied to hyperv-fixes. Thanks.
