Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6964E70E4F3
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbjEWSyJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 14:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbjEWSyJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 14:54:09 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B9129;
        Tue, 23 May 2023 11:54:08 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ae557aaf1dso67099595ad.2;
        Tue, 23 May 2023 11:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684868047; x=1687460047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUA21N0hHC2VaWcQMN0RDUGGIEBD3KgawUXhLEDD8CI=;
        b=Jp0WZCbSzX7F0FCip0Ge4FYYNh/tCmdsoZY4RBQogbJkka/vZRbAW1Q3QLpV4xO03r
         9N715JpJcJQghFpUl+JZCYsdjDpSa9yjgdQXJz/GOkCuq1XV1cUtuZdjhPPJx4HcZCiP
         cDyMLx2tiYhxN58FuyR0Sryc7Q0RtcYEva8XYYvkxlA2EV8mVEDMkqYhwLP+F3PejdkM
         NffsLb3USrhAePzL5VvoIvp2maqMaIPP9qwHyUneR1TU2vjCO1i0KYi72aXzYeSGYpR8
         5NjZDuGKsfaXAU6S/l6He0u2kutTY4EF7nUsH4SpYesnMN7/UtODrlRtV00ZCrgYwQ1g
         bF8Q==
X-Gm-Message-State: AC+VfDz5W9CbQv5iB5cBsX7+Vuw09n/Q/OhOJzRvGWvl0/K4ukYhl18p
        k+fNoKE9rf5bBorE4jbeIMc=
X-Google-Smtp-Source: ACHHUZ6AaSOtzUuO4DbMkB79ChmO5nrJuoRCYEcdDlP5JdjOiKCVnNfaFv9XLIHa22+T8qw9vXzjAw==
X-Received: by 2002:a17:902:f2cc:b0:1ac:72ff:9853 with SMTP id h12-20020a170902f2cc00b001ac72ff9853mr12131652plc.30.1684868047394;
        Tue, 23 May 2023 11:54:07 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709028f8200b001ab0159b9edsm7076759plo.250.2023.05.23.11.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 11:54:06 -0700 (PDT)
Date:   Tue, 23 May 2023 18:54:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com, decui@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload()
 to scan present CPUs
Message-ID: <ZG0LzUkFlwWh1GIf@liuwe-devbox-debian-v2>
References: <1684422832-38476-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684422832-38476-1-git-send-email-mikelley@microsoft.com>
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

On Thu, May 18, 2023 at 08:13:52AM -0700, Michael Kelley wrote:
> vmbus_wait_for_unload() may be called in the panic path after other
> CPUs are stopped. vmbus_wait_for_unload() currently loops through
> online CPUs looking for the UNLOAD response message. But the values of
> CONFIG_KEXEC_CORE and crash_kexec_post_notifiers affect the path used
> to stop the other CPUs, and in one of the paths the stopped CPUs
> are removed from cpu_online_mask. This removal happens in both
> x86/x64 and arm64 architectures. In such a case, vmbus_wait_for_unload()
> only checks the panic'ing CPU, and misses the UNLOAD response message
> except when the panic'ing CPU is CPU 0. vmbus_wait_for_unload()
> eventually times out, but only after waiting 100 seconds.
> 
> Fix this by looping through *present* CPUs in vmbus_wait_for_unload().
> The cpu_present_mask is not modified by stopping the other CPUs in the
> panic path, nor should it be.
> 
> Also, in a CoCo VM the synic_message_page is not allocated in
> hv_synic_alloc(), but is set and cleared in hv_synic_enable_regs()
> and hv_synic_disable_regs() such that it is set only when the CPU is
> online.  If not all present CPUs are online when vmbus_wait_for_unload()
> is called, the synic_message_page might be NULL. Add a check for this.
> 
> Fixes: cd95aad55793 ("Drivers: hv: vmbus: handle various crash scenarios")
> Cc: stable@vger.kernel.org
> Reported-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to hyperv-fixes. Thanks.
