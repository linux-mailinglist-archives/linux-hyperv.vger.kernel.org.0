Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D171DB12BD
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfILQ1A (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Sep 2019 12:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbfILQ1A (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Sep 2019 12:27:00 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A01B681DE0
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Sep 2019 16:26:59 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n6so12155025wrm.20
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Sep 2019 09:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qziAxNyAubhHTYBSD4yRsXHN9OiFD1ZQQkCUflFkono=;
        b=EEySS7kmi+fHLybarru40zTanejZiipdGCr8nY1X1F3DSX+zWOwRXPnp1O4ba3mMR+
         kR4M2CY9dR8vn/JiHOSTEXAmfcHj7Em07ojfF1KONDJlEdrPeavscOOgeBt26zw0ehh5
         rdn4CqQ5TLzxESVGvve0LonRyeSQ0TcdMC/FoYiUNG8OjLJd7ymo8gAW6TpyV5dtDy/M
         16bgjaIg1WcqSgEHGoKtQEhwY58vC59nyi+oWqg4mVVHffD8/jIfohM+nx82grOo/7zJ
         J7MZnuDD/P13AH0Hk9LIzh23ac/O5llpgM04CigaRp3kgomglQgZ3VKyTg5L2PRBzu/Y
         +c0w==
X-Gm-Message-State: APjAAAXtlAOU9un4kbsJSSD27WtxJ5IYiOsz8XqY2MyBTTgXe5JOWjFg
        6++BQnd5IlP0KlSNJF5CZBHA18fEqHf4TESGWLhy1bbMTwDJ7gJMTgnmtdpICMIABrYC0B9j442
        Gx2a+NzQXOO9PRNilyUnUlFWE
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr30494548wrs.179.1568305618361;
        Thu, 12 Sep 2019 09:26:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztK9Z/gMX7ORCbNgZ1dSvJGdv9fZucXr5OOgjDSMAriajITOz+b+G+khvqtWA6VKF/ll3rqg==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr30494531wrs.179.1568305618131;
        Thu, 12 Sep 2019 09:26:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n1sm30678076wrg.67.2019.09.12.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 09:26:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 2/3] hv_utils: Support host-initiated hibernation request
In-Reply-To: <1568245130-70712-3-git-send-email-decui@microsoft.com>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com> <1568245130-70712-3-git-send-email-decui@microsoft.com>
Date:   Thu, 12 Sep 2019 18:26:56 +0200
Message-ID: <87a7b9cwfj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> +static void perform_hibernation(struct work_struct *dummy)
> +{
> +	/*
> +	 * The user is expected to create the program, which can be a simple
> +	 * script containing two lines:
> +	 * #!/bin/bash
> +	 * echo disk > /sys/power/state

'systemctl hibernate' is what people do nowadays :-)

> +	 */
> +	static char hibernate_cmd[PATH_MAX] = "/sbin/hyperv-hibernate";
> +

Let's not do that (I remember when we were triggering network restart
from netvsc and it was a lot of pain).

Receiving hybernation request from the host is similar to pushing power
button on your desktop: an ACPI event is going to be generated and your
userspace will somehow react to it. I see two options:
1) We try to hook up some existing userspace (udev?)
2) We write a new hyperv-daemon handling the request (with a config file
instead of hardcoding please).

-- 
Vitaly
