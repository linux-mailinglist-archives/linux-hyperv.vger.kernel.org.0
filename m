Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC084A0E3C
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 01:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfH1Xdy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 19:33:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35589 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfH1Xdy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 19:33:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id t50so1911697edd.2;
        Wed, 28 Aug 2019 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=ccNqdtuiMvt6E8atu6PgUd6UzKjg1A78YsekiYEtSnk=;
        b=bLT+8WPPJtUWMEXfvUFDV5YqjR2OK/pzHblHLsLXxScJ1vkjtxQdF13jyx9HdcmaqO
         q/oJKLJeGS6ArWmchOkEdgtzJ2ibOlnrFq9LCCGisOem3SvmO74q3reNstk8xH8obWxp
         hZMtUOpLpRjwIgzTb9yBonT54aWVqzlDW9AQR81afwqbjv8Xn0wIrDs5K3ZPr1lkcSIc
         OVGYDxn8bCBL2koGv32UqQ08J0MS8Rg1d0v6rMQwwv1SR6+lVgfUgMAcgHGiLNl/ykhn
         sEeGCXmbr0uj11j0XacJt6BJ0xnERq3dhf73ty3LRoOZv1jttJk3BXWCy0EvEQ54ktle
         oCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=ccNqdtuiMvt6E8atu6PgUd6UzKjg1A78YsekiYEtSnk=;
        b=nvhV8ZXz6CT1cEHm4oGEQ/tt/rpX/F/ccSw8b8H7fTPGEozb+zGqUGPAXBn6bNgHwl
         D/lNMuRzOyc2PiRpTQH3fK3EQk+7ZFAJsY2uP/i49Uzb/aOHGu7N8ffTbsamK6N451tD
         dhWCtsMPVXIZUktrSYkAV66sDJv1m2LhCjvFCk62CpOxWI5/ZmGH/ydPrrtC1tW4D9rY
         +wwH9a0qASI1V6BltgF54peueq+5N/LMPSr95tut0j8WCPPSknA4SoISk4Q/UxX58Kyh
         ApA/SoD7R9n8HcWXamem2TEUfkQ8YFqBjoNeHvQ4BBzv5AxRn603+yznGiMZeg/WNf1Q
         y3iQ==
X-Gm-Message-State: APjAAAVqz21hhwJMJ6ofjObM+A4xblqvYZxo8TxIsFewbdfTM59RC2Ja
        e2GlyMAKSLe89/jX2Z/jVnw=
X-Google-Smtp-Source: APXvYqzQtWmLg+Ff54zz0b3czHoIHOxt4Qvbah0rzrUfmbZTDmtksvM9wVOjqT28pgl4148pgVwMJQ==
X-Received: by 2002:a17:906:8409:: with SMTP id n9mr5493528ejx.128.1567035232073;
        Wed, 28 Aug 2019 16:33:52 -0700 (PDT)
Received: from [192.168.1.105] (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id h13sm107252edw.78.2019.08.28.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 16:33:51 -0700 (PDT)
Date:   Thu, 29 Aug 2019 01:33:49 +0200
From:   Krzysztof Wilczynski <kswilczynski@gmail.com>
Subject: Re: [PATCH] PCI: hv: Make functions only used locally static in
 pci-hyperv.c
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Message-Id: <1567035229.11524.0@gmail.com>
In-Reply-To: <20190828222618.GE7013@google.com>
References: <20190826154159.9005-1-kw@linux.com>
        <20190828222618.GE7013@google.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Bjorn,
Thank you for feedback.

[...]
> Maybe just:
> 
>   PCI: hv: Make functions static
> 
> since we already know it's in pci-hyperv.c, and it's obvious that you
> can only do this for functions that are only used locally.

Makes sense.  I will update the subject line in v3.

[...]
> Rewrap commit log to fill 75 columns.

Sorry about this.  I wasn't sure if one also should wrap compiler and/or
checkpatch.pl script warnings or errors.  I will fix this.

> Does this fix all the similar warnings in drivers/pci/?  If there are
> more, maybe we could fix them all in a single patch or at least a
> single series?

At the moment, while compiling the drivers/pci the compiler yields a 
similar
warning for the following files:

arch/x86/pci/xen.c
arch/x86/pci/numachip.c
drivers/pci/controller/pci-hyperv.c
drivers/pci/vc.c

I will have a look at each closer.

Krzysztof


