Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7C41B992
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Sep 2021 23:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbhI1VqR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 17:46:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:31874 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbhI1VqR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 17:46:17 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 17:46:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1632865104;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rwJ/pcIomhhbC2tNRRfn4x7PLuFAfWVwCK91mxmeOvg=;
    b=dHp+vTV3tN/FlhZxWUfWJLHomipLGl50zN3iPKsAcEheJk5hdPyKho+l6hjGirOc0l
    eUTDumEV85ENN2L5mXoT1aEuQEWqh6NtMFG54lkO5bRJmqOQKr9o5SG/y12SALKEfbUC
    cglEI+FwyyXSgTgdBNFP4Hj+7Rynx8TLIxOcwtd4UY5JfOCPNiRTtNwK1xqv/fQ7RAX9
    JciU702I6HBRHVWVLvpdMbYOi+gPjM57VVwNrTC1WOhIS/KNJqFxql6k6kyJez5dPGi6
    KNVRoxP/o/Cilct3PC4J5hgdYgmyW2IROLONi9JZ19XM3RBRC8Li/xAp5qZeJEzQQYib
    EKPg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4oc0Nr2ihluivdVFdyQMV0m+WjuofHQ2iy5wtYiRmw1kI7ObDDT"
X-RZG-CLASS-ID: mo00
Received: from latitude.home.arpa
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id j06d2fx8SLcNXYW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Sep 2021 23:38:23 +0200 (CEST)
Date:   Tue, 28 Sep 2021 23:38:13 +0200
From:   Olaf Hering <lkml@aepfle.de>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com, sthemmin@microsoft.com,
        anbelski@linux.microsoft.com
Subject: Re: [PATCH v3 11/19] drivers/hv: set up synic pages for intercept
 messages
Message-ID: <20210928233813.6104593b@latitude.home.arpa>
In-Reply-To: <1632853875-20261-12-git-send-email-nunodasneves@linux.microsoft.com>
References: <1632853875-20261-1-git-send-email-nunodasneves@linux.microsoft.com>
        <1632853875-20261-12-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Am Tue, 28 Sep 2021 11:31:07 -0700
schrieb Nuno Das Neves <nunodasneves@linux.microsoft.com>:

> +++ b/include/asm-generic/hyperv-tlfs.h
> -/* Define synthetic interrupt controller message constants. */

I think this code movement could be done in a separate patch.
This will reduce conflicts during backporting.

Olaf
