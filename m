Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1F638DFF
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Nov 2022 17:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKYQA5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Nov 2022 11:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiKYQA5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Nov 2022 11:00:57 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C111D64C
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Nov 2022 08:00:56 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id q7so6514525wrr.8
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Nov 2022 08:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiHLQtCqip1QmDLYL9GH+lamJXbTIVag2QjFqxxokkc=;
        b=pA30rPAYFmtdl7RMaUECnxJFLMFSJfe6x7cg4VUTBz74c5VBWUWR6HQjhFiC7CIpoY
         GOOwSp+JBo+8/UHq449vQEA2N5vHJlF5QJOxNyWiBxN5/Hpl9o+AXyBrVG2kKDA0LcJV
         oX8dpHGuXU1oc2CLHvpjKFt0oIOoBU73T9GWxnaZnMX3e7dSPIvZHE6UAzLR5lE3ZfN0
         lRrVTB/gmNLfX5Kq4ElRqX7ao7VTTw5p7M3vNlosqqE3CZ78/40pDScWCDIf1X7vaGnq
         5zh9bqihQcQ3mTnB4R6gQPF1eqhgvKhm0TL/ALwMnonNGQHtdFeZQxpwBVqhCFEvwWNK
         8buQ==
X-Gm-Message-State: ANoB5pkX2Ok5WdjWjBHYaAybzwseX61CH/sfVgew+aK+Lurgy9IrnAkt
        oaxAaBbSdohbLPlGzGTG0ys=
X-Google-Smtp-Source: AA0mqf7YWKDYUQf+KE8HOAebpAvbw89GXeNJWRkcWPUJ5iSehEB+kO4MELVsTJkmTi9Ebjp5WTGxZQ==
X-Received: by 2002:a5d:46d0:0:b0:242:91c:a12f with SMTP id g16-20020a5d46d0000000b00242091ca12fmr1299107wrs.524.1669392054955;
        Fri, 25 Nov 2022 08:00:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f6-20020adff8c6000000b002258235bda3sm3499285wrq.61.2022.11.25.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:00:54 -0800 (PST)
Date:   Fri, 25 Nov 2022 16:00:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Gaurav Kohli <gauravkohli@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        decui@microsoft.com, haiyangz@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org, bp@alien8.de, mikelley@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Remove unregister syscore call from hyperv
 cleanup
Message-ID: <Y4DmtKikFh5PqjtL@liuwe-devbox-debian-v2>
References: <1669267391-9809-1-git-send-email-gauravkohli@linux.microsoft.com>
 <Y4DfOq94C4sPWM5+@liuwe-devbox-debian-v2>
 <a7689a77-ff0d-97c2-3938-9e6422ec069b@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7689a77-ff0d-97c2-3938-9e6422ec069b@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 25, 2022 at 09:09:52PM +0530, Gaurav Kohli wrote:
> 
> On 11/25/2022 8:58 PM, Wei Liu wrote:
> > On Wed, Nov 23, 2022 at 09:23:11PM -0800, Gaurav Kohli wrote:
> > > Hyperv cleanup codes comes under panic path where preemption and irq
> > Please use "Hyper-V" throughout.
> Thanks for the comment, sure will do on v2.
> > 
> > > is already disabled. So calling of unregister_syscore_ops which has mutex
> > > from hyperv cleanup might schedule out the thread and never comes back.
> > > 
> > While on paper this looks problematic -- have you seen this issue
> > triggered in real life?
> > 
> > This looks to be only triggered when there is another thread already
> > holding the mutex, which seems rather rare in the life cycle of the
> > machine?
> 
> 
> Earlier we also suspected the same that someone was holding the lock, but
> actually there
> 
> was no owner of lock and it got scheduled out due to might sleep code in
> mutex_lock.
> 
> Looks like where voluntary preemption config is on, there it is getting
> scheduled out in might sleep.

If there is only one CPU online and the mutex is free, then
rescheduling will not have any adverse effect, right? Does it not get
scheduled on the only available CPU and make further progress?

> 
> But there is no need of unregister_syscore_ops as this is in crash path
> only, So removing the same.

I'm not against removing it, but the reasoning left in the commit
message and comment should reflect what happens.

Thanks,
Wei.
