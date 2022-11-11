Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA6B62654A
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 00:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiKKXS5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 18:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKKXS4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 18:18:56 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07BD6CA3B;
        Fri, 11 Nov 2022 15:18:55 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id v1so8172518wrt.11;
        Fri, 11 Nov 2022 15:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7GYDONN9orz+Y5bEhVstkZapV2GNsj+OLAyKn1P7+U=;
        b=o1Gwc706QC3IhbLlXqjcX9E3LAwwglUiGajQXa7A2gh5kc0c3plRDj19ixLHQNxB6e
         sk9MHyl8cx9MvSkD1kD2T0jN+thheUbaXEj+KcYSH1ugPZbn0Fe5KA8rqTfuT8pCfaPz
         FDfCvPgC1YlkCuUkszIECaaDhjAakdKKc2lmBlqiGj6BxXFtGlhmTP4TpvX/VyRLeLxM
         CWfWebKQ483vXvN6ZfMSLNnrWwNyhQ0/w758iJzeC+Aoyrutlbie0qNmdYfIhylssDcU
         gyIIm9AOPv+Rb1L3n92y4fpA4eRTD25617z5QKKb4MLDvqtFpzMjESeUEXXz5F/1VTwY
         Omhg==
X-Gm-Message-State: ANoB5pkrSiQgx8ZXOjs7npjwuQh83+7q4uCup6hpRxcT3+/0I2z5GBUO
        YyLugZcQLCYGfF1arWPQN5c=
X-Google-Smtp-Source: AA0mqf4HmGrK1n+4nxr7/xcevPeV77E/WZej4Wi+oy/cnT6R/qxy5jfsNcXsQRFYNYPmkk5MW3h5Vw==
X-Received: by 2002:adf:e0c6:0:b0:22e:471b:c616 with SMTP id m6-20020adfe0c6000000b0022e471bc616mr2486496wri.51.1668208734320;
        Fri, 11 Nov 2022 15:18:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d48ca000000b00236705daefesm2957391wrs.39.2022.11.11.15.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:18:53 -0800 (PST)
Date:   Fri, 11 Nov 2022 23:18:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: hv: update comment in x86 specific
 hv_arch_irq_unmask
Message-ID: <Y27YWxXI1gRdKLJq@liuwe-devbox-debian-v2>
References: <20221107171831.25283-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107171831.25283-1-olaf@aepfle.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 07, 2022 at 05:18:31PM +0000, Olaf Hering wrote:
> The function hv_set_affinity was removed in commit 831c1ae7 ("PCI: hv:
> Make the code arch neutral by adding arch specific interfaces").
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Queued to hyperv-next. Thanks.
