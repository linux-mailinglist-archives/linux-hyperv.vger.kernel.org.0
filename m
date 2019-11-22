Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D91105DA8
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Nov 2019 01:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKVA0q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Nov 2019 19:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfKVA0q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Nov 2019 19:26:46 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA07206DA;
        Fri, 22 Nov 2019 00:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574382405;
        bh=fTil7yxc8yCj0UuKEAWDgfJRsvr35/d/VBefn//EAJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfccTj2tvOzw9LmskeWAfF1jy9UHkazmIhJipHh6i6waeEZJC2mhufXtU1AG027D4
         iEXajkzs1JFe/4zy6ZwBycnhyjdMvAPSn+Fo4msHeYjVwdl2bpqBJ7skB8lDpL2nlI
         IrhfzA5JQ0G5Tfi33HdVSojK0Y/rmcwYnooKOS9c=
Date:   Thu, 21 Nov 2019 19:26:44 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        benjamin.tissoires@redhat.com, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, Alexander.Levin@microsoft.com
Subject: Re: [PATCH v2] HID: hyperv: Add the support of hibernation
Message-ID: <20191122002644.GH16867@sasha-vm>
References: <1574234096-48767-1-git-send-email-decui@microsoft.com>
 <nycvar.YFH.7.76.1911211533430.1799@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1911211533430.1799@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 21, 2019 at 03:34:10PM +0100, Jiri Kosina wrote:
>On Tue, 19 Nov 2019, Dexuan Cui wrote:
>
>> During the suspend process and resume process, if there is any mouse
>> event, there is a small chance the suspend and the resume process can be
>> aborted because of mousevsc_on_receive() -> pm_wakeup_hard_event().
>>
>> This behavior can be avoided by disabling the Hyper-V mouse device as
>> a wakeup source:
>>
>> echo disabled > /sys/bus/vmbus/drivers/hid_hyperv/XXX/power/wakeup
>> (XXX is the device's GUID).
>>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> Acked-by: Jiri Kosina <jkosina@suse.cz>
>
>My Ack still holds for v2. Sasha, this is going to be merged through your
>tree, right?

Yup, queued up for hyperv-next, thanks!

-- 
Thanks,
Sasha
