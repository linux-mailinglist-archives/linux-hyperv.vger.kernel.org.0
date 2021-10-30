Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB2440B97
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Oct 2021 22:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhJ3UJx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 30 Oct 2021 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhJ3UJx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 30 Oct 2021 16:09:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7BC061714
        for <linux-hyperv@vger.kernel.org>; Sat, 30 Oct 2021 13:07:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e65so13277349pgc.5
        for <linux-hyperv@vger.kernel.org>; Sat, 30 Oct 2021 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cyc43r8GdPRIRNRzw0no3zbXsiEelKCLzckzNGDsC6s=;
        b=b82oDSTzxfv98G672X0/DEzxrahh5Mz/q3bRp6zpJaskF3JiguWUYKdAMpmDihTZqi
         k/emgjqMl9bbCjn93a5OoB92FemMiqhis6t4Me94ssuoIuBuvphYARMkxGhTEs4STc8B
         7pQTnl/GnPMo6aA+c6cU8KdZ2H3zZyGxAppFMtcdCT7oQF8QUlZ1WuvmyOkHsBZ3Ko+h
         3rxZcBVB+HKyGXqJX853j/rzqEv6wl28Aw65iCZfJBwGDo+m5cnSome5PfQgDybVKmZB
         32ByL0nDZJHwDi1H/2Qsz3akZQyVwihjaxBL3jDRJ2e5tfv/Qs1p49r8NLqVAoUBynAt
         5yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cyc43r8GdPRIRNRzw0no3zbXsiEelKCLzckzNGDsC6s=;
        b=dRzGZ8tXYLhytNxoQeV8eybOXijyaskthOFmnZbxT/ek4FIFr0ZzaJXvuRaoBynZ5Z
         tW0+ZilpJT5MULZWA05UM3EB5bEBLS3Lpgc3AgGG5PbNAsZOqETcmefOmNeKscQo00yY
         xwGvGwLQSJf1qYZaof9K6iVpl3v75PqNJ5BHb40EabNzDayFul2tyv0qVunsnUluQNi/
         IApujlThgRbKBeYhooYK4ym5pAI/tyfAplmMirsMOGHHOrE9xSa+rJ++ioYDpO8QAfUj
         cQSajAmkdiL7HJuJAvmTwBj5/pcxkWTKgbYvwKCaKeBuX4D3JhWSVnAxXfmnh8qJfr+f
         dHZw==
X-Gm-Message-State: AOAM531HkuN2iGlBZ6Y7Spym2Tc/sz6mEcbunTKi2kaAymVJZeZW69/p
        Dy//+XuaGWO0z6/4xhjh9VSa5Q==
X-Google-Smtp-Source: ABdhPJw1+SO+sO4sXJozBZNr5KL4BvxlQY4xSjZVKQGmgSAXJ5bN1iMCPtgRGu6CS7IXrqyZY6sptw==
X-Received: by 2002:a63:348d:: with SMTP id b135mr14129383pga.87.1635624441806;
        Sat, 30 Oct 2021 13:07:21 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id ne7sm5039241pjb.36.2021.10.30.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 13:07:21 -0700 (PDT)
Date:   Sat, 30 Oct 2021 13:07:18 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     davem@davemloft.net, kuba@kernel.org, gustavoars@kernel.org,
        haiyangz@microsoft.com, netdev@vger.kernel.org, kys@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, shacharr@microsoft.com,
        paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com
Subject: Re: [PATCH net-next 1/4] net: mana: Fix the netdev_err()'s vPort
 argument in mana_init_port()
Message-ID: <20211030130718.3471728c@hermes.local>
In-Reply-To: <20211030005408.13932-2-decui@microsoft.com>
References: <20211030005408.13932-1-decui@microsoft.com>
        <20211030005408.13932-2-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 29 Oct 2021 17:54:05 -0700
Dexuan Cui <decui@microsoft.com> wrote:

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 1417d1e72b7b..4ff5a1fc506f 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1599,7 +1599,8 @@ static int mana_init_port(struct net_device *ndev)
>  	err = mana_query_vport_cfg(apc, port_idx, &max_txq, &max_rxq,
>  				   &num_indirect_entries);
>  	if (err) {
> -		netdev_err(ndev, "Failed to query info for vPort 0\n");
> +		netdev_err(ndev, "Failed to query info for vPort %d\n",
> +			   port_idx);

Shouldn't port_idx have been unsigned or u16?
It is u16 in mana_port_context.
