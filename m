Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833D26281C0
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Nov 2022 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKNN7I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Nov 2022 08:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKNN7H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Nov 2022 08:59:07 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87C6333;
        Mon, 14 Nov 2022 05:59:06 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id a14so18423223wru.5;
        Mon, 14 Nov 2022 05:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqBw4uJGnVX3z4DPc2jSDRa31QQsaamARtV+B+AB37w=;
        b=TNCqiaBnJBJpI/0LXoXjEmi9uIHidQu7F3KZHxleNVdbhe4rpv93KtbyJx85HQj9MN
         6KY6ofjpz0o7lSbjelubjxbdHSP6jlSauUENwQjJTsTCRrvx5M7LaFGsADCKWtxjyksX
         YbH4ytiybXgGZ8962iJGGQgV8KAXV1XmaNVDxybyxwRJN9ovYOeuWDeSOZKgO8yaHg55
         ScgtUn40Hp+bBaoUsBcpngBZ8DXinCTQ9f0723ZidjP47JLDB53RM0YygTX2gnXfTQT/
         u2EmP/HDEBIcEX6wTW1ZYqB34FebpNrhv9SLgLx6802Ze9aiPvpXJ2Xh0dUUSSCwM2Of
         hY5w==
X-Gm-Message-State: ANoB5pkqkDmJc++yBvrmf/Kq8VsOlJyCNuuOrFggXMB+olD8GYtqlCvf
        HXHaZU2oWRAa7PDHq00n+pg=
X-Google-Smtp-Source: AA0mqf6sWl3Y3ybLQX3gzt/fpnJa5lC5OeEgLBiKOLq94WSSK5qCRn5EQdT6WADCZXcRKVREv3mgyQ==
X-Received: by 2002:adf:fc8c:0:b0:235:9aae:35a6 with SMTP id g12-20020adffc8c000000b002359aae35a6mr7279816wrr.686.1668434345461;
        Mon, 14 Nov 2022 05:59:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b0022cd0c8c696sm9447356wrx.103.2022.11.14.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:59:04 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:59:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Message-ID: <Y3JJpyvCcrRZfJkV@liuwe-devbox-debian-v2>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
 <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 11, 2022 at 02:53:59PM -0800, Nuno Das Neves wrote:
> On 11/11/2022 9:58 AM, Michael Kelley (LINUX) wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 9:27 AM
[...]
> 
> I've tested this patch on these Azure SKUs:
> - Standard_D2S_v2 (intel xapic)
> - Standard_D4ds_v4 (intel xapic)
> - Standard_D4ds_v5 (intel x2apic)
> - Standard_D4ads_v5 (amd xapic)
> 
> I've tested with linux Dom0 (nested hyperv root partition) and as a
> regular L1 guest.
> 

Okay. I think your tests are good.

Michael, do you have any further concern?

Thanks,
Wei.
