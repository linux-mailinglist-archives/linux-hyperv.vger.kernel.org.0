Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3025937A01
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfFFQuf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 12:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfFFQuf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 12:50:35 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81755206BB;
        Thu,  6 Jun 2019 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559839834;
        bh=+qRKZuurwyHw2Y9SndA0cCjnZtTW9RpgmwmM7kR60ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXj/6cSo4n7syKeTiNS4CVaH9RCcruu3Dvhk+8ucah14QkDsga0vpeb4kTvyhDk9p
         gq7ANtnYzxEr3ycFrM6eQoNmWRXcq33RrLoaeo2XvWoIjS5rqXxtSqbY0zrFXsPeD6
         EaP/2g0040mkp1CPNodCZdcauQvCOcD/kLOMaCGc=
Date:   Thu, 6 Jun 2019 12:50:33 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH v2 1/1] Drivers: hv: vmbus: Break out ISA independent
 parts of mshyperv.h
Message-ID: <20190606165033.GM29739@sasha-vm>
References: <1559175219-17823-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1559175219-17823-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 30, 2019 at 12:14:00AM +0000, Michael Kelley wrote:
>Break out parts of mshyperv.h that are ISA independent into a
>separate file in include/asm-generic. This move facilitates
>ARM64 code reusing these definitions and avoids code
>duplication. No functionality or behavior is changed.
>
>Signed-off-by: Michael Kelley <mikelley@microsoft.com>
>Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>---
>Changes in v2:
>* Removed unneeded #includes in asm-generic/mshyperv.h;
>added two #includes that are needed. [Vitaly Kuznetsov]

Queued for hyperv-next, thanks!

--
Thanks,
Sasha
