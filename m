Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC96FB57B
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 May 2023 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEHQr6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 May 2023 12:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHQr5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 May 2023 12:47:57 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAEC40D8;
        Mon,  8 May 2023 09:47:56 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64115e652eeso35990330b3a.0;
        Mon, 08 May 2023 09:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564476; x=1686156476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOL1utdO5j1lMdZYNTIJCCOYDCyfOjACc9iJVaVjBMA=;
        b=BD/h7pkVtLAb6SBqqaHzkPU3BCWNPV5ozWF/lNK8IcviFQ9ZNGaOg7UNuhFKvMjDWL
         t2ECe4H8KhXumBeEM5yaD5saV8pvl1QMh52yStoB3xUYcrlqgQGU6bqk8qbzxBgQxyBc
         iZwvXkNdqpBCEYYWqYCqwHcCiVxmrVuBDxFRfxJRLSrNvbkbCktewBPcvKzbqAwkNPSN
         sYU4euwsC/4WxZ8ljJMEM37/EWc6XHe6JDDQMAxn6SsIbwnE9t1doKA1oxlz6CZixRLU
         R5cqQ98/Wz7XJQO8Bp+AKqbMkrqzqcfVkZ+Oc8Yxzuet9MLpS+oxe4l3ceiaaf0GOQ1z
         8/Vg==
X-Gm-Message-State: AC+VfDxBrHeEtqKgjHvrVq2tm82N+vOnPLWQt6K0coQwlndXjwT9bA60
        em+ggQGD9eYREIFoYNxRARuJrBroS3o=
X-Google-Smtp-Source: ACHHUZ5OJ/W2NgyH9QvgVZ6xghgdfqXjas94AFKxf8T1v0CWQ8iCjwH9lBfYrBBPr1CXq+0cOQxQIA==
X-Received: by 2002:a17:903:1c6:b0:1a9:581b:fbb1 with SMTP id e6-20020a17090301c600b001a9581bfbb1mr12090332plh.32.1683564476148;
        Mon, 08 May 2023 09:47:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id m14-20020a170902db0e00b001ac5896e96esm4987570plx.207.2023.05.08.09.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:47:55 -0700 (PDT)
Date:   Mon, 8 May 2023 16:47:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508095340.2ca1630f.olaf@aepfle.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 08, 2023 at 09:53:40AM +0200, Olaf Hering wrote:
> Thu,  4 May 2023 22:51:15 -0700 Shradha Gupta <shradhagupta@linux.microsoft.com>:
> 
> > Ifcfg config file support in NetworkManger is deprecated. This patch
> > provides support for the new keyfile config format for connection
> > profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
> > to generate the new network configuration in keyfile
> > format(.ini-style format) along with a ifcfg format configuration.
> 
> Thanks, this approach is compatible with current expectations inside the VM.

Olaf, is this a reviewed-by from you? :-)

Thanks,
Wei.

> 
> 
> Olaf


