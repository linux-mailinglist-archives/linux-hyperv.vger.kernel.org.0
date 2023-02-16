Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA7699781
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Feb 2023 15:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBPOeN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Feb 2023 09:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBPOeM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Feb 2023 09:34:12 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7319122A2E;
        Thu, 16 Feb 2023 06:34:11 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso1813378wmo.3;
        Thu, 16 Feb 2023 06:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eymPrMLpgAwR4cJyhDjtY285FZDJTVhOz4JmcIpGIe0=;
        b=CGyMqs7bw8cIcUK1hJ0xGfNPaGvNi/0cl0PV912CxrTEcEwFMpMBj6Xxz6V5qr4Cte
         YKmLuznzjptAzfW8i9l8s9Lpuj81j+wXq8bCYCPjDA4U+Zd8mfum2OtV4IR3gh1zx6rM
         4+zHNsmJLeV3InbaXlsJe25rdj85mHaEE440CoeEZhPqbC908O/SfU313kPN/MVgQ0pD
         Uab7OZW9W55M7Ofs2MUbOjavHrq9yCYla7gc8Otn/bFRsArw51IpZ21pr9HP6DJBykwD
         Bh99ReWH2iE7LJggcvYxkt2I7yAmAvSXRaESdTgoDi7+/pAzios4Ra0hSI0ZVYcy24xn
         2tUQ==
X-Gm-Message-State: AO0yUKWpb6NfCM5B5PX7KgBQxdxnEszvOuIJIkdD+fbC27dq7dB6uzLS
        yJ7b55nZJ7hGlbAhZr3aRNY=
X-Google-Smtp-Source: AK7set/9yHZjeWmxrGosUEPoz/oCjrW3jFBVGNwIzFxEi/G4skaHdoSXPPNhaqhk+B2W4ptu1OxInw==
X-Received: by 2002:a05:600c:44d3:b0:3e0:47:66cc with SMTP id f19-20020a05600c44d300b003e0004766ccmr4988769wmo.23.1676558049947;
        Thu, 16 Feb 2023 06:34:09 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d69cd000000b002c3e1e1dcd7sm1663024wrw.104.2023.02.16.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:34:09 -0800 (PST)
Date:   Thu, 16 Feb 2023 14:33:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, kys@microsoft.com,
        Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH] x86/hyperv: Fix hv_get/set_register for nested bringup
Message-ID: <Y+4+zT3vJoh5XVli@liuwe-devbox-debian-v2>
References: <1675980172-6851-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y+pJDbMu8WEPFnEm@liuwe-devbox-debian-v2>
 <45ca8d38-34f4-2d17-bcd6-f62c1b7f0c3a@linux.microsoft.com>
 <26f3cf0e-a95f-0a94-5179-ad7ae7cf47f1@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f3cf0e-a95f-0a94-5179-ad7ae7cf47f1@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 15, 2023 at 02:07:13PM -0800, Nuno Das Neves wrote:
> On 2/15/2023 8:35 AM, Jinank Jain wrote:
> > The patch looks good to me, apart from the comments from Wei regarding styling.
> > 
> [..]
> > On 2/13/2023 7:58 PM, Wei Liu wrote:
> >>
> >> I can fix these issues too if you don't end up sending a new version due
> >> to other issues.
> >>
> 
> Wei, feel free to fix the issues when you commit the patch.
> 

Fixed and applied.

Thanks,
Wei.
