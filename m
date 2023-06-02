Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD372073E
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Jun 2023 18:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjFBQSE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Jun 2023 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjFBQSD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Jun 2023 12:18:03 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAE197;
        Fri,  2 Jun 2023 09:18:02 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-652d1d3e040so699602b3a.1;
        Fri, 02 Jun 2023 09:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722682; x=1688314682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIuYDkKOJE1IX10BTzPGqaoR1nF3MMAO1XlSet3yJDs=;
        b=C4LaH52q3riQ9hxj+nmGBN4dGKC+N7/GokiObKZ1OkKBAMCvr9ksZUwtDluhJbG24S
         VxHOtBaSREuk2x2dsakThBkkGZdrk+ckkOEXu6rDcAv7n5rKxtgYpL0dTkYxnHTfDXvC
         OW8ygVmaGhIUlm61M3pw5TDdTpQBTm5giPVpCG6GZrnbiQTRsSZJV2l4J4iTBnWsP5ax
         Jdo2qrYKtxaZINdF5TYOhv0eHcePZwUUsMW4CZmLEM5eK7DdS7opgt3FW/UprEZyFwFC
         9g5TfeaK3IRfjICsa86cPgjEqbTOc1CkqqyADFh6JEA6kcH//KndbWFbv4RnPl6fTQNW
         WpTg==
X-Gm-Message-State: AC+VfDwIBTd665jvy6k/fHf4r6lqr/G1OEtSX5E+h7wu26P0JgtNTTcG
        liWi0lBYGjKOgi+KJpBHeZdK18SUJao=
X-Google-Smtp-Source: ACHHUZ5h4LK8nR3LqCvgQi41UJHDPNhiI33aok5PNY7CA4SgCbhANkhkZWZm/gFg67kbw+vfQpiYtw==
X-Received: by 2002:a17:90a:1a11:b0:255:949b:b50d with SMTP id 17-20020a17090a1a1100b00255949bb50dmr417224pjk.4.1685722681628;
        Fri, 02 Jun 2023 09:18:01 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a284600b00247735d1463sm1491212pjf.39.2023.06.02.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:18:01 -0700 (PDT)
Date:   Fri, 2 Jun 2023 16:17:59 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH] x86/hyperv: add noop functions to x86_init mpparse
 functions
Message-ID: <ZHoWN1TYicOSGsd3@liuwe-devbox-debian-v2>
References: <1685709712-13752-1-git-send-email-ssengar@linux.microsoft.com>
 <442441b3-803e-0c1f-ff1b-5a49ecc2e423@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442441b3-803e-0c1f-ff1b-5a49ecc2e423@intel.com>
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

On Fri, Jun 02, 2023 at 08:33:13AM -0700, Dave Hansen wrote:
> On 6/2/23 05:41, Saurabh Sengar wrote:
> > In !ACPI system, there is no way to disable CONFIG_X86_MPPARSE.
> > When CONFIG_X86_MPPARSE is enabled for VTL2, the kernel will
> > scan low memory looking for MP tables. Don't allow this, because
> > low memory is controlled by VTL0 and may contain actual valid
> > tables for VTL0, which can confuse the VTL2 kernel.
> 
> Do you folks have a writeup of this VTL* setup anywhere?  I'm struggling
> to grasp why VTL0 and VTL2 share the same address space and why they
> would get confused by each other's data structures.

Dave, here is some public information about Virtual Trust Level.

https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm#virtual-trust-level-vtl

I wished it could be more detailed.

With the proper configuration, VTL2 can see memory from VTL0, but not
the other way around.

Saurabh can probably give you more information for this particular setup.

Thanks,
Wei.

> 
> $ grep -r VTL[02] Documentation/
> $
> 
> Either way, this is way better than the #ifdefs.  But the changelog is
> kinda just gibberish to me.
