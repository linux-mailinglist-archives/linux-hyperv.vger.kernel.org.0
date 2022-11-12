Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6845626974
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 13:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiKLMng (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 12 Nov 2022 07:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiKLMnf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 12 Nov 2022 07:43:35 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033C1570C;
        Sat, 12 Nov 2022 04:43:34 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id g12so9679196wrs.10;
        Sat, 12 Nov 2022 04:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Bc2gTV0O0wWaaiJt+7TbO5Q/u6dV/Zvu16eLjh5vU=;
        b=hQtZVEPbvHQCdBCkXtM3vO+HtlC/yP//imVaZxmxiJe7eOIFnXw52ma8HNUhFgJLrP
         2b03dnBGA4cZj9cMrZqq4btAxU3awSk/LnV+Ekp42RLNHF016l0aieVuneUuw1m/Ijxk
         TEMUAkhoJCZ2+Do73Bt8HOGJi0MTSAvgboIlRsTdx9PItFUD6TjXeHA96quCn1e/icwI
         tFIJPy8VI6JcGwb8doYDj3rj13RkwM9lQDHFhAO9HWPSextGnH/slbUEMSgm/IJ+62D4
         izMzvFp6B4P995eRlyI118BCx/V/0Ui75oi4cOYgEniNA0FL8peqFZvXRNPUGZXrMoBD
         oKGw==
X-Gm-Message-State: ANoB5plzZBmaGdYKQMWjoqVqhmqX+2iY5pEN2vN4oNFNjmKougjNEpgC
        6Z8Cp/uRsXS++VteXgX8rMQ=
X-Google-Smtp-Source: AA0mqf4zlURPuVIhgKKj3JDFMpvmT0oiHzFdFH11U2vmHog8ITHC4je/qkQWvwpyUBL+wqTB5nJEmQ==
X-Received: by 2002:adf:cf12:0:b0:236:611d:b6b9 with SMTP id o18-20020adfcf12000000b00236611db6b9mr3619896wrj.190.1668257013247;
        Sat, 12 Nov 2022 04:43:33 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b0023660f6cecfsm4343306wrv.80.2022.11.12.04.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 04:43:32 -0800 (PST)
Date:   Sat, 12 Nov 2022 12:43:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "quic_carlv@quicinc.com" <quic_carlv@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: Re: [PATCH v3] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Message-ID: <Y2+U8tNI+tuQPlXR@liuwe-devbox-debian-v2>
References: <20221104222953.11356-1-decui@microsoft.com>
 <Y24cTE9+bqXtHics@lpieralisi>
 <SA1PR21MB133572B296D53A64A1A6792FBF039@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB133572B296D53A64A1A6792FBF039@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Nov 12, 2022 at 12:58:33AM +0000, Dexuan Cui wrote:
[...]
> 
> I discussed the issue with Hyper-V team. I believe I understood it and
> this patch is the right thing to have.
> 
> @Wei, Bjorn spotted two typos in the commit message, and Lorenzo
> suggested a change to the above "current". Can you please help
> fix these and merge the patch? Or, let me know if it'd be easier if
> I should send v4.

All fixed and patch applied to hyperv-fixes.

Thanks,
Wei.

> 
> Thanks,
> Dexuan
> 
