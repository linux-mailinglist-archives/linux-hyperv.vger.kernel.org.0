Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A06E0398
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 03:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDMBUC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 21:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMBUB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 21:20:01 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4490C93;
        Wed, 12 Apr 2023 18:19:59 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id he13so12573285wmb.2;
        Wed, 12 Apr 2023 18:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348798; x=1683940798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjyi1d2DaGOoVQP4dc4753hrjRyHdq/z0Ow2Tqmef2o=;
        b=lamdBnRpKIqA9thj/wyKfOPDC+KdhW8G3JftFqx4Jr3H3GO58VbgVFEqYxWtQ4oGuJ
         N1SrHGMdsnK1EN0UnMi6xDN5kbdH6Ic91/2fn9xZMVnddv1+p0Kxn8m9n+rXdmIpdm5V
         7+gqaAB2iwoed87jovpat5Gmr1EQDTer530pM1n5tM8S4W/T0Onz4MRMDRX9pSL46aAw
         rICvto5W31Ys/RvieM4z+IESktANKFGM//k+VYqr2e+Gcz7SzkgYCNbzK4TSJpITFDLy
         VZk3aUKUnRvkSKXhNPCrQIs8BwKelVjnFhH6EInn8+eW/VRsVA0bQ1149QDp5B8F0I+3
         oK+w==
X-Gm-Message-State: AAQBX9dCVG6B/Vr2acMawxXN2J2vzTlMBCwCzSnKPgZS4yN54IEOs+bZ
        nJUbZJBrSJJcJmBkfI3vfaE=
X-Google-Smtp-Source: AKy350bRMJVGnXEBnTZ9JDyLP/jEdb5ji2zYVjpiOOUI0mwBEf4cv+MngKLWTkb3YPDw/MvAyakoTA==
X-Received: by 2002:a1c:4c08:0:b0:3ea:d620:570a with SMTP id z8-20020a1c4c08000000b003ead620570amr424478wmf.38.1681348797608;
        Wed, 12 Apr 2023 18:19:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc34a000000b003eeb1d6a470sm423584wmj.13.2023.04.12.18.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:19:57 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:19:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: Re: [PATCH] Drivers: hv: vmbus: Remove the per-CPU post_msg_page
Message-ID: <ZDdYuYzKBdePXMiW@liuwe-devbox-debian-v2>
References: <20230408213441.15472-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408213441.15472-1-decui@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Apr 08, 2023 at 02:34:41PM -0700, Dexuan Cui wrote:
> The post_msg_page was introduced in 2014 in
> commit b29ef3546aec ("Drivers: hv: vmbus: Cleanup hv_post_message()")
> 
> Commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments") introduced
> the hyperv_pcpu_input_arg in 2018, which can be used in hv_post_message().
> 
> Remove post_msg_page to simplify the code a little bit.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied to hyperv-next.
