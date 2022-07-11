Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A97570A28
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 20:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiGKSyZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKSyY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 14:54:24 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8C7286C2;
        Mon, 11 Jul 2022 11:54:22 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id v14so8195447wra.5;
        Mon, 11 Jul 2022 11:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4TxPXEbDng0zPcNaFjZQIJsUTvNsX8wiFVkIkSJFZBQ=;
        b=NfKklrVn6lkfFSW9Yhz6XchJC2FywFKcJGVMRwVd4iB6HKU2IE8be8Z8ZU8MSObPh+
         Qzv2ViXccysz5FnFzLuxxBHUUsg81goHuXP5PLX++2a8N2tJzBTW+fRmz+FvkmOem2hs
         O+qI/oKOmpWkhQFCUvCQzhqQMHtKVrc+OtIvULT9AXZnafpnQ0bJqq3A0W7b8smotujN
         h1DeOrUF05rvVw/JlbiHwgfbqUP4aPsqUKVinVq0jsUjWBWKaDI0DenaLQDY7k8fJMvy
         NFkGuInOpvdXeXS+EF+4HQFh4fyLN9V2niixRtr9xnQ+4xsxvdmOoawOzojzvp3PAGl4
         gaXw==
X-Gm-Message-State: AJIora9EwlF6mOoBtIoTXT1s1jRSyVENNXs8t98yBX2UhdAFVNWoC1xy
        h/8Dbv/YHjSbT7Bk4Ca8aY0=
X-Google-Smtp-Source: AGRyM1tl1Bz2uCqc5K/giCKJIInASHkR8sWtuYj2B2XsYlYAf2xGMmtkkfQEED/suxOUesIA6QZXHw==
X-Received: by 2002:a5d:51c6:0:b0:21d:7ec4:7ecb with SMTP id n6-20020a5d51c6000000b0021d7ec47ecbmr18282508wrv.645.1657565661312;
        Mon, 11 Jul 2022 11:54:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b0021dac657337sm1498053wrt.75.2022.07.11.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:54:19 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:54:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>,
        Praveen Kumar <kumarpraveen@microsoft.com>
Subject: Re: [PATCH v3] Drivers: hv: vm_bus: Handle vmbus rescind calls after
 vmbus is suspended
Message-ID: <20220711185407.nr4fythfoup7lk27@liuwe-devbox-debian-v2>
References: <20220711041147.GA5569@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <PH0PR21MB3025AC6A419A5BB7B408DD20D7879@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025AC6A419A5BB7B408DD20D7879@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 11, 2022 at 05:50:43PM +0000, Michael Kelley (LINUX) wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Sunday, July 10, 2022 9:12 PM
> > 
> > Add a flag to indicate that the vmbus is suspended so we should ignore
> > any offer message. Add a new work_queue for rescind msg, so we could drain
> > it along with other offer work_queues upon suspension.
> > It was observed that in some hibernation related scenario testing, after
> > vmbus_bus_suspend() we get rescind offer message for the vmbus. This would
> > lead to processing of a rescind message for a channel that has already been
> > suspended.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next. Thanks.
