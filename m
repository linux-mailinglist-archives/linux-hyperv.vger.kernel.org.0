Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899BF6E6C25
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjDRSe4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjDRSey (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 14:34:54 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECDE5FEB;
        Tue, 18 Apr 2023 11:34:53 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id n43-20020a05600c502b00b003f17466a9c1so329276wmr.2;
        Tue, 18 Apr 2023 11:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842892; x=1684434892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm4ZY1i9Dh6gYkNxKtAHV+VT8qVk5zXV7kjjZ2dWbbc=;
        b=inlV1UZNjGzLwdvkVYspz00/fgBNC/HgmECKW8DMTDz/pASPGFJ10vXWsNZJagcZbf
         1unixmRXkNu21ME7DDP7bMqzdgtJfoILZbXz7mUWlsaOXPoi4qqyG5uoACXFhAw4P+oP
         bNgNHynOt4WhOnsoxIPFsIukB2EAiixx0Sz/ku6/rhQp+9X58RzDPw6eFqxqW1eDe4CV
         uhTbIle2OyEARsUKnYTtTcfbNuRVxmt/1BV7g+gg8xHykjIveq6ioyeCFGzSbKjaQQo2
         LONibxMtPKxB/JGbNIwRM2yECyQNeX0wYk/XIilcXaRpj+vAmLz5GIs97Ux09UcfOyb+
         8Jzg==
X-Gm-Message-State: AAQBX9fXz+0u9eNKvRJZ95CQRMt2XcIwXbjSMjmImZIN0QgcBf0ud5Z0
        gxxXqOSfqd06oSIJoXhoieU=
X-Google-Smtp-Source: AKy350bHlssa6DuT3MY94kLm7rWccLcuvRtMBc56od1YbGIgIpSIvi7awTSaLifcA4m0MK5BSYngAw==
X-Received: by 2002:a05:600c:c3:b0:3f1:76a2:33a8 with SMTP id u3-20020a05600c00c300b003f176a233a8mr4105861wmm.5.1681842891914;
        Tue, 18 Apr 2023 11:34:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003ee20b4b2dasm15588429wmc.46.2023.04.18.11.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:34:51 -0700 (PDT)
Date:   Tue, 18 Apr 2023 18:34:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     broonie@kernel.org
Cc:     Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-hyperv@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the hyperv tree
Message-ID: <ZD7iyCf2WdnTMurW@liuwe-devbox-debian-v2>
References: <20230418173157.92827-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418173157.92827-1-broonie@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 18, 2023 at 06:31:57PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the hyperv tree, today's linux-next build (x86 allmodconfig)
> failed like this:
> 
> /tmp/next/build/drivers/hv/connection.c: In function 'vmbus_connect':
> /tmp/next/build/drivers/hv/connection.c:228:53: error: implicit
> declaration of function 'hv_alloc_hyperv_page'; did you mean 'hv_free_hyperv_page'? [-Werror=implicit-function-declaration]
>   228 |         vmbus_connection.monitor_pages[0] = (void *)hv_alloc_hyperv_page();
>       |                                                     ^~~~~~~~~~~~~~~~~~~~
>       |                                                     hv_free_hyperv_page
> /tmp/next/build/drivers/hv/connection.c:228:45: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   228 |         vmbus_connection.monitor_pages[0] = (void *)hv_alloc_hyperv_page();
>       |                                             ^
> /tmp/next/build/drivers/hv/connection.c:229:45: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   229 |         vmbus_connection.monitor_pages[1] = (void *)hv_alloc_hyperv_page();
>       |                                             ^
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   4dbdcfe1c5db80edca ("Drivers: hv: move panic report code from vmbus to hv early init code")
> 
> I will use the hyperv tree from yesterday instead.

This has been fixed by removing the problematic commit.

Thanks,
Wei.
