Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA37B5C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 00:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfG3WgU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 18:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbfG3WgU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 18:36:20 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9047206E0;
        Tue, 30 Jul 2019 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564526179;
        bh=pBZlE6TKHTNpaSnKT2xBOqnrpLRxD4BputMpN6MCdcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4h6YrEZ98gJeVQSy+GjtmSA4aXzmqQPkrvsFj6ehO3wknimcuBAocoO7KtW5s8FP
         8iOb5hGRIa3niv82H+q2r1I503S1vXByrMdryQ4P9zqhHZaWZjX65TnkWwrVTm2ORn
         b00m0rEYlJtVKqy+LEq72/iQaH5Vs2LjtnxMyZwU=
Date:   Tue, 30 Jul 2019 18:36:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH 1/2] hv_balloon: Use a static page for the balloon_up
 send buffer
Message-ID: <20190730223618.GK29162@sasha-vm>
References: <1560537692-37400-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1560537692-37400-1-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 14, 2019 at 06:42:17PM +0000, Dexuan Cui wrote:
>It's unnecessary to dynamically allocate the buffer.
>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>

I've queued these up for hyperv-next, thanks!

--
Thanks,
Sasha
