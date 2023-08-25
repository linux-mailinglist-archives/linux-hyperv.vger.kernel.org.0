Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E6787C69
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Aug 2023 02:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjHYAGu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Aug 2023 20:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbjHYAG2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Aug 2023 20:06:28 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE26B19B4;
        Thu, 24 Aug 2023 17:06:26 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-26fc9e49859so247676a91.0;
        Thu, 24 Aug 2023 17:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692921986; x=1693526786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWdk9Nh27lTWI9Sy3qG2N2twh7bN52t5s/fVvyXjmsM=;
        b=fRbuU66ME25jaQ4bEUhcYLG1rzlFQxrVEAJSMn4eaWJwIKJoC34NStiSazm81xPqww
         a57eJ1YBlhWqezCfwD4+DofcC6K/i2IqVB+1Ud6FazvA10Q7RtHoPpBH5FTvW4qRbNw1
         QF1QikZ47fz4PAs3RFvFxA9qlmeCXzZOBD2+swGCxKw6S5RtkGiXpOksQSY7Otg6naXU
         RgrVMM1UIf9eOyxLFvODsKtHuIYIWv5SeN49vzPCr0Z9iJP4m0XjgApSkjEJ/UIOHDVK
         26hBIBNW+Wm4futPKe4l2kQYhajo0EtSv7YdLiN5Lw+VCYjYrf79AFSjgCFFcJN6g3LR
         NE0A==
X-Gm-Message-State: AOJu0YxPbWKaM0vNhabAx+xvAwK0Gm7VwhGeYwacGEWNKSczuu8ta6rc
        E15qgPM34kC+QOhWHa+sVm0=
X-Google-Smtp-Source: AGHT+IEDTuEdW/fF2X8esUeNnTXm7RIMpfL/KicU8T2LpUpKyl82EpoWSQT1cG5TzHh4+GefRdQHUg==
X-Received: by 2002:a17:90a:6806:b0:268:5e70:508a with SMTP id p6-20020a17090a680600b002685e70508amr13746847pjj.43.1692921986135;
        Thu, 24 Aug 2023 17:06:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a498500b00264040322desm285608pjh.40.2023.08.24.17.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 17:06:25 -0700 (PDT)
Date:   Fri, 25 Aug 2023 00:06:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] x86/hyperv: Remove duplicate include
Message-ID: <ZOfwa7ujBcs3AaFQ@liuwe-devbox-debian-v2>
References: <20230824080352.98945-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824080352.98945-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 24, 2023 at 04:03:52PM +0800, Jiapeng Chong wrote:
> ./arch/x86/hyperv/ivm.c: asm/sev.h is included more than once.
> ./arch/x86/hyperv/ivm.c: asm/coco.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6212
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to hyperv-next, thanks!
