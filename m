Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE744AA713
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2019 17:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfIEPLp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 11:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbfIEPLo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 11:11:44 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B90020828;
        Thu,  5 Sep 2019 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567696304;
        bh=c6Klt7mrqAOjCZDFyaHnc54eSVIfusmbzS0lo9b8yjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BR+UiPaPkce7W1s47hLG/KmG+0HffACHMGYM2+hEDzS9b48b+DvoYN1RuWp+jOrgG
         dzZ5nt1uv8vaa+QStOAh+M3DN3zooejScHpembX/hUA1ESLusCxlyMl69h4pJT3FLt
         ZdfGF8q4IxAfflOjcKU3vyLN4Z/oIfvVASUT8pMw=
Date:   Thu, 5 Sep 2019 11:11:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: hyperv: Use in-place iterator API in the channel
 callback
Message-ID: <20190905151141.GB1616@sasha-vm>
References: <1566269763-26817-1-git-send-email-decui@microsoft.com>
 <KU1P153MB016679060F4360071B751AF0BFB90@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909041623050.31470@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1909041623050.31470@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 04, 2019 at 04:23:27PM +0200, Jiri Kosina wrote:
>On Tue, 3 Sep 2019, Dexuan Cui wrote:
>
>> > Hi Jiri, Benjamin, can this patch go through Sasha's hyperv tree:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>> >
>> > This is a purely Hyper-V specific change.
>>
>> Hi Jiri, Benjamin,
>> Are you OK if this patch for the Hyper-V HID driver goes through the Hyper-V
>> tree maintained by Sasha Levin? It's a purely Hyper-V change, and I have
>> been using the patch for several months and there is no regression.
>
>No problem with that. Feel free to add
>
>	Acked-by: Jiri Kosina <jkosina@suse.cz>
>
>in that case.

I've queued it up for hyperv-fixes, thank you!

--
Thanks,
Sasha
