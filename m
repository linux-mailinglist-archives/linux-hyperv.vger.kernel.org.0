Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14945137D8
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348859AbiD1PMs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiD1PMs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 11:12:48 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982453191B;
        Thu, 28 Apr 2022 08:09:33 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id i5so7157616wrc.13;
        Thu, 28 Apr 2022 08:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bzK4fFZb9r7TnusFnuvATOoPxhklhDj3w+S8Z+Le5i0=;
        b=vI+zYGhTzl8X7HMhY8fsxm2mLaGVRF/J3qvuL1OrGZ/fEJLng8kDJb5PNeTg1gpOiA
         fLgqUyGYC1vX2e1L3rqPFx9ex1H9q1PjKSfXItQqnEzAJvKjhRFVTLo97sW+VnLb6CHO
         LpyTLBObSF8Yq4j/4lIlZSojmUC6oatp6hE1WUDddD/zU3AfLiz2RzeXw2vUupD4LPy6
         Jq1dhwrUfzBydBk7Tt7jCicM2fyHfBsP/ZvOVAd+H2Sr6AqEizHATISGs5Xzzq05xxma
         XmVTerBGH33DMUCUVJmvDxr5ba73DBo+GOEzAfSM1LdmB8wkTiT1l1ic8/3eiHyEosmh
         RGRQ==
X-Gm-Message-State: AOAM530J24lHfSOIrRCb0n+Y47zI7UTEQU/t5CQHW1mJQMji0AyJ9tit
        RiJhH1/PWsI5ZqW4WWUWK28=
X-Google-Smtp-Source: ABdhPJyAdWRUX1iFgv2Z7Wvpl8/5WVjF61XSL66wA5FFIJ0Dugj0wya8s69nQ8pUKy95zUqAmRHIyw==
X-Received: by 2002:a5d:49d0:0:b0:20a:de8b:8fc0 with SMTP id t16-20020a5d49d0000000b0020ade8b8fc0mr14939410wrs.79.1651158572145;
        Thu, 28 Apr 2022 08:09:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b00391447f7fd4sm232152wmq.24.2022.04.28.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:09:31 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:09:30 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
Message-ID: <20220428150930.olpctvihpgaqm4t7@liuwe-devbox-debian-v2>
References: <1651068453-29588-1-git-send-email-quic_jhugo@quicinc.com>
 <PH0PR21MB3025DB8EAB4714E059CAC326D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025DB8EAB4714E059CAC326D7FA9@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 27, 2022 at 05:11:39PM +0000, Michael Kelley (LINUX) wrote:
> From: Jeffrey Hugo <quic_jhugo@quicinc.com> Sent: Wednesday, April 27, 2022 7:08 AM
[...]
> >  			   (hbus->hdev->dev_instance.b[7] << 8) |
> > --
> > 2.7.4
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-next. Thanks.
