Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F47543042
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 14:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiFHM0D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Jun 2022 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbiFHMZ7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jun 2022 08:25:59 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FBF23D9B0;
        Wed,  8 Jun 2022 05:25:34 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id v14so1898489wra.5;
        Wed, 08 Jun 2022 05:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=miroqaPLT+voTbrWIvYlkPFyflXhDq+fnt6QQ2RQNKA=;
        b=HTLvpujmf14Aj3HpgMRl97djw/cX4dkiqrnR/xiCaI3A2c7K4bm5i1Qv2x96Nyt9W7
         ubXFQsOuHWnQDoPjE0Y6va6bu/7HdLnPaHcyuL3pML/muvqt1hqua2il715BSydzFuTe
         o3xu1GqtmZgWBwvzH/HArLKmhB6K4SOU6kRq1SGy7fNHl9bcytH4zB5D/medMhNlukSp
         N7LW8y2uevefUHLO164gGn/bqjnqeeajFtqczzo4ZaMChkz48mEiNzkxvabFjKyh+QMJ
         di//FM+evpqCRWfS9jb4cHZs2OJ973UOeQdoOpeaRhKGdZswwklb5W6FgWgBDy0lV+go
         DSTg==
X-Gm-Message-State: AOAM532Xd2IeMWbG8ijWAvaoPPlGb+4mMvUQtFXnB/xAwfi+fXcz/+72
        xnuK1jlbWwbaolP711qSkr5o7xRzS0Y=
X-Google-Smtp-Source: ABdhPJxMDHUyb6xW2jhwtjjT8glIqcx+uDz3PJG6GG31C1Nhr2KjTeHHQsG1AvjE982+/fGqJ8jojA==
X-Received: by 2002:a05:6000:170a:b0:215:6799:782c with SMTP id n10-20020a056000170a00b002156799782cmr26315518wrc.38.1654691132655;
        Wed, 08 Jun 2022 05:25:32 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l14-20020adfe58e000000b002117ef160fbsm20973946wrm.21.2022.06.08.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 05:25:31 -0700 (PDT)
Date:   Wed, 8 Jun 2022 12:25:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [RESEND PATCH v2] Drivers: hv: vmbus: Don't assign VMbus channel
 interrupts to isolated CPUs
Message-ID: <20220608122529.ub4knslhufwwsmhn@liuwe-devbox-debian-v2>
References: <1653637439-23060-1-git-send-email-ssengar@linux.microsoft.com>
 <BY3PR21MB30338E99CC13116ECAB27BD7D7DB9@BY3PR21MB3033.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY3PR21MB30338E99CC13116ECAB27BD7D7DB9@BY3PR21MB3033.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, May 28, 2022 at 01:11:21PM +0000, Michael Kelley (LINUX) wrote:
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, May 27, 2022 12:44 AM
> > 
> > When initially assigning a VMbus channel interrupt to a CPU, don’t choose
> > a managed IRQ isolated CPU (as specified on the kernel boot line with
> > parameter 'isolcpus=managed_irq,<#cpu>'). Also, when using sysfs to change
> > the CPU that a VMbus channel will interrupt, don't allow changing to a
> > managed IRQ isolated CPU.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
[...]
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
