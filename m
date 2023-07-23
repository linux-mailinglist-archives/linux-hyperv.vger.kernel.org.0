Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699475E5B9
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jul 2023 01:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGWXTw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jul 2023 19:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGWXTv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jul 2023 19:19:51 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35240E5D;
        Sun, 23 Jul 2023 16:19:50 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-666edfc50deso2362517b3a.0;
        Sun, 23 Jul 2023 16:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690154389; x=1690759189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zGk1Niam6UZ2jy2licKvwrBdebUzet8WIVWth2StMA=;
        b=Jtclg3eedaDYMmGNcFYEtB0xWHNLUT94yn4GUFiGynd3CWOKzCXWKfwD/L/smBjl36
         O8B7wFqRj7wKhFJ+1x9h98sd5zFMXaharsYntpX6JpNYMVE65johWjekWP3yHIh4uhBl
         jb6R5OIOCfPn5IrxqFtB4D1NdhRM9Eu1sLGYTWXxZUPa1Oef2BSGhCH0OTPH8PEn9XmN
         klbAd/NEMWrh1Wglkmxra6oVgtX8qSLm3yvxWI9GtYKAutEqajvLFNU0uC19YIpfT5lO
         F87K9GWMmByuWZLa7C9um2bSnVyCnl/6YqzeR0bA5bKq5bKKz5BlTfNa99VlTYNDax1p
         EV3g==
X-Gm-Message-State: ABy/qLarJdATQTlpBIKo8j4m9yencp5eMJ0+coX3TmJzauI1X/dbOLgY
        TT1V7Bh/AOuCe8TlZvVwhys=
X-Google-Smtp-Source: APBJJlG7c6VUFMt9StjN8OzLFMiRjZ1/RdPf879H3Fo6SfW3Faqo+7wmGxoBDjyGcjGmQ58fyWUPRQ==
X-Received: by 2002:a05:6a20:2446:b0:130:7ef2:ff21 with SMTP id t6-20020a056a20244600b001307ef2ff21mr12157563pzc.19.1690154389642;
        Sun, 23 Jul 2023 16:19:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id m198-20020a633fcf000000b0054fe6bae952sm7190723pga.4.2023.07.23.16.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 16:19:49 -0700 (PDT)
Date:   Sun, 23 Jul 2023 23:19:47 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Ani Sinha <anisinha@redhat.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmbus_testing: fix wrong python syntax for integer value
 comparison
Message-ID: <ZL21k2GWKgZldIq4@liuwe-devbox-debian-v2>
References: <20230705134408.6302-1-anisinha@redhat.com>
 <761F02E9-7A80-486B-8CB4-B5E067D7F587@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <761F02E9-7A80-486B-8CB4-B5E067D7F587@redhat.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 17, 2023 at 01:13:25PM +0530, Ani Sinha wrote:
> 
> 
> > On 05-Jul-2023, at 7:14 PM, Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > It is incorrect in python to compare integer values using the "is" keyword.
> > The "is" keyword in python is used to compare references to two objects,
> > not their values. Newer version of python3 (version 3.8) throws a warning
> > when such incorrect comparison is made. For value comparison, "==" should
> > be used.
> > 
> > Fix this in the code and suppress the following warning:
> > 
> > /usr/sbin/vmbus_testing:167: SyntaxWarning: "is" with a literal. Did you mean "=="?
> 
> Ping …
> 

Applied to hyperv-fixes. Thanks.
