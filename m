Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12E26147DD
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKAKpT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAKpS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 06:45:18 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE415733;
        Tue,  1 Nov 2022 03:45:18 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so9633954wmb.3;
        Tue, 01 Nov 2022 03:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwwjXDojYpfAe9pWWX8Ysi5XeTkAjvd2ATF6N/1wGPU=;
        b=NahdesqsLHr7+wi56zRaWBqCEWzA2xPKCqRFZQVtFozC/59gAYk7HxBsT+hQMeJV+c
         YTIsLURDCp7YHNq/J4egrl4OuKMLekR3kLJI+EV6Sujv7p6RpWHJZHcyH1aNYW1+98l/
         zZRpoPNE7UQ7u2NkpAFum2q+20qgfXvhI0Qyw+lkuXl4iZuqNyceTLTR8pu0MI25ir4J
         dHDktygSlUZoYvUxHuI04CmjCi6eQV5Msd7Q24T1XWrH0vRRB4O1Edi6QCaG+1/gR/HR
         cDtMrHU6mAIo1xCxeLwOnUEyaZfGOtM9ig0xS/dqUZkiJ3VwmFguGkjSiy0zJ0gg5gWf
         pytw==
X-Gm-Message-State: ACrzQf29/bERmBqrkhV2FYpiCF2qTkpDMvv5xDuYXJ/gnUwGmShXrTcA
        5bg5s9MoPUSAPetKXlTSzfYCkcH25dY=
X-Google-Smtp-Source: AMsMyM4QVo1hkD6PZp/72zLlcjK1kd7Up4LxynAOQ+/xozzUVFv50W1pWtxajjYts2Ncd6DfOpuQGg==
X-Received: by 2002:a05:600c:3506:b0:3cf:70ac:7039 with SMTP id h6-20020a05600c350600b003cf70ac7039mr6890113wmq.145.1667299516499;
        Tue, 01 Nov 2022 03:45:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d404b000000b002258235bda3sm9609057wrp.61.2022.11.01.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:45:15 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:45:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, jkosina@suse.cz
Subject: Re: [PATCH] HID: hyperv: fix possible memory leak in mousevsc_probe()
Message-ID: <Y2D4ts1quAg3VZQU@liuwe-devbox-debian-v2>
References: <20221028134043.1152629-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028134043.1152629-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 28, 2022 at 09:40:43PM +0800, Yang Yingliang wrote:
> If hid_add_device() returns error, it should call hid_destroy_device()
> to free hid_dev which is allocated in hid_allocate_device().
> 
> Fixes: 74c4fb058083 ("HID: hv_mouse: Properly add the hid device")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
