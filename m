Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F8C4002
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Oct 2019 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfJASiy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Oct 2019 14:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfJASiy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Oct 2019 14:38:54 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B672133F;
        Tue,  1 Oct 2019 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569955133;
        bh=aKf91XR6JvMxLueo2TS8zQiXeT9A/x7VMo135oAwuig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuXkiaROFJoI6oXe+BcXrLaPgpC7sGZqhXV/w5YFDQFtqnS6C7arSyCZQmvb1G2H5
         LOwi+IixflbF6IJTQGnFQUza/0iZdTghdy3XlfugK5ShPQ32eXYh3CSfwGItH0I71S
         O4o4KOK8duAr5ndH49JIIpCAumc9/jBlIKFFpdxM=
Date:   Tue, 1 Oct 2019 14:38:52 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Add the support of hibernation
Message-ID: <20191001183852.GB8171@sasha-vm>
References: <1568244905-66625-1-git-send-email-decui@microsoft.com>
 <yq1zhj7byph.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <yq1zhj7byph.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 13, 2019 at 06:47:38PM -0400, Martin K. Petersen wrote:
>
>Dexuan,
>
>> When we're in storvsc_suspend(), we're sure the SCSI layer has
>> quiesced the scsi device by scsi_bus_suspend() -> ... ->
>> scsi_device_quiesce(), so the low level SCSI adapter driver only needs
>> to suspend/resume its own state.
>
>Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Queued up for hyperv-next, thanks!

--
Thanks,
Sasha
