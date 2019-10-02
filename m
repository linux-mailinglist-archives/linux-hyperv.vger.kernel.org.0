Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37517C88C3
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Oct 2019 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfJBMio (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Oct 2019 08:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfJBMin (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Oct 2019 08:38:43 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD21B21920;
        Wed,  2 Oct 2019 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570019923;
        bh=HQMmTzo9+zvRqR/nVhQaW+N2GPTpVZp7d3nBoEoTmPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFPxZuRdNvktOe4qMXQU9eQM9VwnajP5nw/OAfYArBagDdU9ddNNwUwZE7y0o+YNO
         tcw0hZklpBDfeIfzvpgKDFuhg72ZJLk7qHdIW07NH5CA7aaRyHzzpeaOxTbUjanSrr
         gUV3+b1accmguO0oYIXi7OGVYjxVI74VXVSc3/CA=
Date:   Wed, 2 Oct 2019 08:38:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Iouri Tarassov <iourit@microsoft.com>
Subject: Re: [PATCH v4] video: hyperv: hyperv_fb: Obtain screen resolution
 from Hyper-V host
Message-ID: <20191002123841.GK17454@sasha-vm>
References: <20190905091120.16761-1-weh@microsoft.com>
 <DM5PR21MB0137D40DF705CDB372497266D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <PU1P153MB0169656B3EC48BFCF4D8C134BFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169656B3EC48BFCF4D8C134BFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 13, 2019 at 06:38:42AM +0000, Dexuan Cui wrote:
>> From: Michael Kelley <mikelley@microsoft.com>
>> Sent: Thursday, September 5, 2019 7:06 AM
>>
>> From: Wei Hu <weh@microsoft.com> Sent: Thursday, September 5, 2019 2:12
>> AM
>> >
>> > Beginning from Windows 10 RS5+, VM screen resolution is obtained from
>> host.
>> > The "video=hyperv_fb" boot time option is not needed, but still can be
>> > used to overwrite what the host specifies. The VM resolution on the host
>> > could be set by executing the powershell "set-vmvideo" command.
>> >
>> > Signed-off-by: Iouri Tarassov <iourit@microsoft.com>
>> > Signed-off-by: Wei Hu <weh@microsoft.com>
>> > ---
>> >     v2:
>> >     - Implemented fallback when version negotiation failed.
>> >     - Defined full size for supported_resolution array.
>> >
>> >     v3:
>> >     - Corrected the synthvid major and minor version comparison problem.
>> >
>> >     v4:
>> >     - Changed function name to synthvid_ver_ge().
>> >
>> >  drivers/video/fbdev/hyperv_fb.c | 159
>> +++++++++++++++++++++++++++++---
>> >  1 file changed, 147 insertions(+), 12 deletions(-)
>> >
>>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>
>Looks good to me.
>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>

Queued up for hyperv-next, thank you.

--
Thanks,
Sasha
