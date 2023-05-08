Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CC96FB5CB
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 May 2023 19:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjEHRQa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 May 2023 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjEHRQ3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 May 2023 13:16:29 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A686195;
        Mon,  8 May 2023 10:16:22 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-643a1fed360so2342583b3a.3;
        Mon, 08 May 2023 10:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566182; x=1686158182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzOOqSCPNKiU1z19Qsto2uhpiIKkCaCK2nxX6iUR0io=;
        b=alm2oq+TMJHKfk3fXEWNHGnSivqdgjVNvvnTFhcsdqx/WspOKrKCVre7y3cwPhmlLm
         rk7PrWHYPQEaTigMY5HjEgE+IWVlzvE42EVblNXcehhJBHq7E8A4DKWmmHig9wTEiPZ1
         Th7v8FG//4kzklA7aAoeGzr2lp567tFZW8kQjSkXPLqkWd1ff+citQ23dBgE9smirC4j
         y8s4pOHAqZkEJpj1iYuk3FkXt9NxGfFdj+2A/xy229lfQUxBZmz/zsT8AJc8m5DI+D5R
         Xlk43AHf4EKQ/c3TSzXvkzGvduywfsz57NTHOusE/FBcuFIlpvATn/pJL6s5mOmeGsq6
         28uA==
X-Gm-Message-State: AC+VfDwtiLky8+mUxeZCt9JnGXBBvY4mnlGu7CVUKyAurQEx/Cb8/4Fx
        +d8NmjWkQRgFaXm/SnP0UyM=
X-Google-Smtp-Source: ACHHUZ7HOwiiqFWJeJkAq1dFrXDsfmJDRk7j8C0aO+PxZbiU0CSNe+iN3xmqaMoGRGSjULgVMfjtcg==
X-Received: by 2002:a05:6a00:1a89:b0:63f:1037:cc24 with SMTP id e9-20020a056a001a8900b0063f1037cc24mr12743543pfv.32.1683566181785;
        Mon, 08 May 2023 10:16:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b0063d2bb0d107sm233250pff.64.2023.05.08.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:16:21 -0700 (PDT)
Date:   Mon, 8 May 2023 17:16:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508191246.2fcd6eb5.olaf@aepfle.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
> 
> > Olaf, is this a reviewed-by from you? :-)
> 
> Sorry, I did not review the new functionality, just tried to make sure there will be no regression for existing consumers.

Okay, this is fine, too. Thank you for looking into this.


> 
> Olaf


