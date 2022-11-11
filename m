Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9656D6265A4
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKKXjn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 18:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiKKXji (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 18:39:38 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB582C78;
        Fri, 11 Nov 2022 15:39:35 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id j15so8264338wrq.3;
        Fri, 11 Nov 2022 15:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CceDJwu4ypXsDOy5RyvkArTdWmXqZ/+EiaX7nGSzCyg=;
        b=43bjiocMtz4C0a84+qr5TzS2P8fExLSFLyDe7caREsr9ZH7n97SaNLOk5ZnBNUwUeo
         spybXx57stZ1HNPQLsT9z0VeY1ezUCNs9/ZZEt0+D7PyDMNwHAgJgueMRBsJ64A+bjwI
         cg4Ukq7PalER+410C6laJv787Zj1kJqkmKUg4yqbMdxOmBkCFmHLfaUZFQG8NuVICBrZ
         Njk5BFLUbL1yW6de/JOPaTjLqhrM9Al/Qq+/dTqcNkas0DsILweUZ0xs4aedLjWFpi7f
         Az1Rsv0vN0ZAi434AxH7QRBXqXAyO7CFInswjKQCKGxRW/c1EvCXiqOvbZVx+wtBup95
         YouA==
X-Gm-Message-State: ANoB5pka5J62P6AUkuyp9sRQJgyOpiyWE7Be8o04Q4lWhW37z57/2P9D
        bXtlI3knomFgQAnQqnDb6MU=
X-Google-Smtp-Source: AA0mqf6IIZORNw/rib3BsT/6PdBds7L0qGsqAfuN0xdjNfRvBPIDCsKGXRTY3y+2pEmOilv4DlbclQ==
X-Received: by 2002:a05:6000:136e:b0:236:783e:5947 with SMTP id q14-20020a056000136e00b00236783e5947mr2382171wrz.168.1668209974157;
        Fri, 11 Nov 2022 15:39:34 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b002365730eae8sm2995917wrf.55.2022.11.11.15.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:39:33 -0800 (PST)
Date:   Fri, 11 Nov 2022 23:39:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2] x86/Hyper-V: Expand definition of struct
 hv_vp_assist_page
Message-ID: <Y27dM1z+QphRFgMi@liuwe-devbox-debian-v2>
References: <1667587123-31645-1-git-send-email-ssengar@linux.microsoft.com>
 <Y2je48OwQaRTkci+@anrayabh-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2je48OwQaRTkci+@anrayabh-desk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 07, 2022 at 04:03:07PM +0530, Anirudh Rayabharam wrote:
> On Fri, Nov 04, 2022 at 11:38:43AM -0700, Saurabh Sengar wrote:
> > The struct hv_vp_assist_page has 24 bytes which is defined as u64[3],
> > expand that to expose vtl_entry_reason, vtl_ret_x64rax and vtl_ret_x64rcx
> > field. vtl_entry_reason is updated by hypervisor for the entry reason as
> > to why the VTL was entered on the virtual processor.
> > Guest updates the vtl_ret_* fields to provide the register values to
> > restore on VTL return. The specific register values that are restored
> > which will be updated on vtl_ret_x64rax and vtl_ret_x64rcx.
> > Also added the missing fields for synthetic_time_unhalted_timer_expired,
> > virtualization_fault_information and intercept_message.

I did a bit of stylistic changes to the commit message and queued this
up to hyperv-next. Thanks.
