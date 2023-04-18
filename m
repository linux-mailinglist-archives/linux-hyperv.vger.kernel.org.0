Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9E6E6AD5
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDRRYj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRRYj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 13:24:39 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41283E2;
        Tue, 18 Apr 2023 10:24:38 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so1674229f8f.3;
        Tue, 18 Apr 2023 10:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838668; x=1684430668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPWQx/fs5PzjjHX2PHTqsYFmJ+uyZG83rV1eTD1ZyGQ=;
        b=LZUBWWwGcmeXKm1Ny4CgeFH6BpqQYwgAXjcYeH+8QuclCRXQH6F7US6R0z18LU2Fug
         E/KTM12x/nbUMKS0fuZqcLfOMbaenywT3t0bwd08RTYKXxC9AwaNCikyCjqzkRd0XCBl
         a6eJZ09EQkw7sH2oHo3BqptMsa+/aVc7O3TvD+5em8uH0zDIYQV+R9lzgdztXy88hKXs
         4fRe04U+AmiXxHfqX58U98UlamWUQ9mvy1qIeEMA+SwASf8V3qfgZIGB2fNMdpW6SnYN
         CnR01siF1IUhm27FPUN5/bZ4M3vPfwPtvx04Av90r6N34QIBFLkNL1E3Rz6l//MI0sxc
         Lwrw==
X-Gm-Message-State: AAQBX9cBNDX9SJS3kivsp/3IuS6MEYS2FssCUho/memmMHzBXRGW+8q7
        Vno32q+cQdA1OCetkiWfxfc=
X-Google-Smtp-Source: AKy350bkyxb0Z55rF5GxI1fxrzhvbX/syEuDTeJsx+jHuT+bJ+Mm216/i9WdlwWxB59lmM6YMekW9g==
X-Received: by 2002:adf:e385:0:b0:2f8:e190:e719 with SMTP id e5-20020adfe385000000b002f8e190e719mr2246664wrm.65.1681838668329;
        Tue, 18 Apr 2023 10:24:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s9-20020a5d4ec9000000b002cde25fba30sm13697879wrv.1.2023.04.18.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:24:27 -0700 (PDT)
Date:   Tue, 18 Apr 2023 17:24:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tianyu Lan <tiala@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: linux-next: build failure after merge of the hyperv tree
Message-ID: <ZD7SSCXTiEvN27xO@liuwe-devbox-debian-v2>
References: <20230418170021.90280-1-broonie@kernel.org>
 <e8780a61-96e9-4050-b0d5-8e6be43e2e27@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8780a61-96e9-4050-b0d5-8e6be43e2e27@sirena.org.uk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 18, 2023 at 06:06:58PM +0100, Mark Brown wrote:
> On Tue, Apr 18, 2023 at 06:00:21PM +0100, broonie@kernel.org wrote:
> > Hi all,
> > 
> > After merging the hyperv tree, today's linux-next build (x86 allmodconfig)
> > failed like this:
> 
> Adding more Hyper-V CCs, sorry the capitialisation in MAINTAINERS
> confused my search.

I will fix this. Thanks for the heads up and sorry for the breakage.

Wei.
