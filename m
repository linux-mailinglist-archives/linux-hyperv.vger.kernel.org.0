Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267250E475
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Apr 2022 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbiDYPfG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Apr 2022 11:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiDYPfF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Apr 2022 11:35:05 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279562C64A;
        Mon, 25 Apr 2022 08:32:01 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id q20so9523434wmq.1;
        Mon, 25 Apr 2022 08:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=je5KBwLCA0n7Fdyp87BQSaIvasDV+YQCrBaibWsBwrY=;
        b=BlNcVqBrNgcmhyKhqnfDgxbjX3H1Alw13pA0JZjebn7ZVBmiUUQWWA1S8XagefTEG4
         GPNLekq57D/AzryhupM8BHyjGGEe9OLWPWJMmxhylTnWn24ywbHVtnQKbpFC+l1TylVB
         UL2485qc21CGoLq/B5tF6E5H7Gj5Ag1c9R58854HjChHu9kDT8eizjfDvRYoFfvr1MHg
         C5lPBcVmaLCJbtvuFuTwBqRRRGs4FTrZxP6wjYkkX0EDOqxyYxYJKZxvqGBZ73wIXgdx
         pBfTMlW9j0enbBRuZ5+hWazr6vT2lCa88Tjq4JZsVqXG3Br/fTbHGOINuLKd6lHWGtCA
         BjMw==
X-Gm-Message-State: AOAM533k5BPfifWYKmzTcMRN8dF2y6mR8pFHPIb463He7GEoaPaxMQjF
        bM8Jhc+NFoswrya80FlgoOODjYlDaj8=
X-Google-Smtp-Source: ABdhPJwi2Vvs2gMgP/FfcVHlL16DyEYfORPMzO93gTtvYQxyAfrzl2uI8MUZb78lmdDtaPf/0k9svA==
X-Received: by 2002:a1c:f20d:0:b0:38e:ab1c:3f70 with SMTP id s13-20020a1cf20d000000b0038eab1c3f70mr26540031wmc.27.1650900719624;
        Mon, 25 Apr 2022 08:31:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d4b0d000000b00207a8815063sm8885534wrq.2.2022.04.25.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:31:59 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:31:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Add VMbus IMC device to
 unsupported list
Message-ID: <20220425153157.q23v3ij6bjcke35f@liuwe-devbox-debian-v2>
References: <1649818140-100953-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649818140-100953-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 12, 2022 at 07:49:00PM -0700, Michael Kelley wrote:
> Hyper-V may offer an Initial Machine Configuration (IMC) synthetic
> device to guest VMs. The device may be used by Windows guests to get
> specialization information, such as the hostname.  But the device
> is not used in Linux and there is no Linux driver, so it is
> unsupported.
> 
> Currently, the IMC device GUID is not recognized by the VMbus driver,
> which results in an "Unknown GUID" error message during boot. Add
> the GUID to the list of known but unsupported devices so that the
> error message is not generated. Other than avoiding the error message,
> there is no change in guest behavior.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
