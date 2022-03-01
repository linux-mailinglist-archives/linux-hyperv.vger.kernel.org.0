Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368B94C8EBF
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiCAPQu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 10:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiCAPQu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 10:16:50 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747B442A25;
        Tue,  1 Mar 2022 07:16:09 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id ay10so3203029wrb.6;
        Tue, 01 Mar 2022 07:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BvtC0gtJjFUWH0cUPU8+itqu2Xz/0icFEi9nJd4dxj0=;
        b=ZMU4dZteagywb0X11gf0O4d7xfEEWUSwOdW6b1c4jompLAJy4D1HHivUkDzspjlODm
         NB0wIkVVSEkPqZKMfTvgnf5O+OZ5urasnCCXqJfuV/RMlXv+umSZ6jRHBy476wh0Yc6h
         rH508A+moeH4Vr9ldMtnitxwjBribNUA3sQervaWZW6m5rc00kYT7NiN2ft82Y3XYjU/
         9KiZBsw4gweisjmJySXfTGWwtmN4WpKltlZ2huVJqw+Bw60MybU2gE9/s09oJYFhu3Ll
         N1VGkuiPitIJ+aFDBAC1YPAif/Eqt1AJ6ceZ7gOeiQ3dW9MiOHBbXEfA59wDonOCiL6n
         dxPg==
X-Gm-Message-State: AOAM531MS6ySu0Ywmu0hp9Y3g/0njtYJNz82p8nje2dwCEO77ZfmoVeW
        mqTP3JbV5e0KYzH5FXxlcmZJMs4IY9s=
X-Google-Smtp-Source: ABdhPJzSrkz1SKdnk0MKW9s1h+j4KxjEFeozL66I9jSHlv61jLchqTMgKweLy1/JLMHGNqJBjPTC7Q==
X-Received: by 2002:a5d:550d:0:b0:1ed:c155:6c2a with SMTP id b13-20020a5d550d000000b001edc1556c2amr19809657wrv.470.1646147767945;
        Tue, 01 Mar 2022 07:16:07 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c418200b00380e4fa28b8sm2543387wmh.23.2022.03.01.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:16:07 -0800 (PST)
Date:   Tue, 1 Mar 2022 15:16:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Anssi Hannula <anssi.hannula@bitwise.fi>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv_balloon: rate-limit "Unhandled message" warning
Message-ID: <20220301151605.j5zymunttpylphyn@liuwe-devbox-debian-v2>
References: <20220222141400.98160-1-anssi.hannula@bitwise.fi>
 <MN0PR21MB3098049BCEFAAEE5C61F589AD73E9@MN0PR21MB3098.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB3098049BCEFAAEE5C61F589AD73E9@MN0PR21MB3098.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 25, 2022 at 06:59:18PM +0000, Michael Kelley (LINUX) wrote:
> From: Anssi Hannula <anssi.hannula@bitwise.fi> Sent: Tuesday, February 22, 2022 6:14 AM
> > 
> > For a couple of times I have encountered a situation where
> > 
> >   hv_balloon: Unhandled message: type: 12447
> > 
> > is being flooded over 1 million times per second with various values,
> > filling the log and consuming cycles, making debugging difficult.
> > 
> > Add rate limiting to the message.
> > 
> > Most other Hyper-V drivers already have similar rate limiting in their
> > message callbacks.
> > 
> > The cause of the floods in my case was probably fixed by 96d9d1fa5cd5
> > ("Drivers: hv: balloon: account for vmbus packet header in
> > max_pkt_size").
> > 
> > Fixes: 9aa8b50b2b3d ("Drivers: hv: Add Hyper-V balloon driver")
> > Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
