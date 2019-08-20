Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2780896479
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfHTPca (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Aug 2019 11:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfHTPca (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Aug 2019 11:32:30 -0400
Received: from localhost (mobile-107-77-164-38.mobile.att.net [107.77.164.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A16322CE3;
        Tue, 20 Aug 2019 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566315149;
        bh=lYNbJtSoIqilwFc4I/5amcEJ7YyI1KE6DLz9qEEB47w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lg4i6+Xa683wrljo+flUvu0X8rS4wB6AhZzjEC7TxQf19W7qwIRx5I2B/WoFqGxoH
         WBTJDlu3/GtmQ6Lms6G2dymTGeyyiCFCUEA/mnIruBrkBSv8R0UHLxqtl+/7peOSJJ
         8LdEfgUhHfwofs5nZUiQ5eiYmnAIYzVeTFKxrbtw=
Date:   Tue, 20 Aug 2019 11:32:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2] Tools: hv: move to tools buildsystem
Message-ID: <20190820153228.GO30205@sasha-vm>
References: <20190819124100.81289-1-andriy.shevchenko@linux.intel.com>
 <87pnl16ypo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87pnl16ypo.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 19, 2019 at 04:01:39PM +0200, Vitaly Kuznetsov wrote:
>Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
>> There is a nice buildsystem dedicated for userspace tools in Linux kernel tree.
>> Switch Hyper-V daemons to be built by it.
>>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Queued up for hyperv-next, thank you.

--
Thanks,
Sasha
