Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293C91D9E21
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgESRpz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 13:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESRpz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 13:45:55 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C369520708;
        Tue, 19 May 2020 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589910355;
        bh=cHlc8fE1J62ViyaQ+0PZQXd4ySJzfbVUiBcqPeFMo6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8lJ59iYq5qN9g5SNw929Bk2LZarSUCjLpKOR+STiiUp8RF00nDK7Y5Ewf8aKQAIp
         Qltp2vtjGOsydiVEmPGVYu+17orYXbehXtf6ah6q/pKagaGJXz7Bh8aU4UExvnuRzx
         hb/Blb8y4lfO7fm8oSFjaH2IsJMRqjF1Yj9bEudw=
Date:   Tue, 19 May 2020 13:45:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexander.deucher@amd.com, chris@chris-wilson.co.uk,
        ville.syrjala@linux.intel.com, Hawking.Zhang@amd.com,
        tvrtko.ursulin@intel.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        spronovo@microsoft.com, iourit@microsoft.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-ID: <20200519174553.GF33628@sasha-vm>
References: <20200519163234.226513-1-sashal@kernel.org>
 <20200519163234.226513-2-sashal@kernel.org>
 <20200519172105.GB1101627@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200519172105.GB1101627@kroah.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 19, 2020 at 07:21:05PM +0200, Greg KH wrote:
>On Tue, May 19, 2020 at 12:32:31PM -0400, Sasha Levin wrote:
>> +
>> +#define DXGK_MAX_LOCK_DEPTH	64
>> +#define W_MAX_PATH		260
>
>We already have a max path number, why use a different one?

It's max path for Windows, not Linux (thus the "W_" prefix) :)

Maybe changing it to WIN_MAX_PATH or such will make it better?

>> +#define d3dkmt_handle		u32
>> +#define d3dgpu_virtual_address	u64
>> +#define winwchar		u16
>> +#define winhandle		u64
>> +#define ntstatus		int
>> +#define winbool			u32
>> +#define d3dgpu_size_t		u64
>
>These are all ripe for a simple search/replace in your editor before you
>do your next version :)

I've actually attempted that, and reverted that change, mostly because
the whole 'handle' thing became very confusing.

Note that we have a few 'handles', each with a different size, and thus
calling get_something_something_handle() type of functions becase very
confusing since it's not clear what handle we're working with in that
case.

With regards to the rest, I wanted to leave stuff like 'winbool' to
document the expected ABI between the Windows and Linux side of things.
Ideally it would be 'bool' or 'u8', but as you see we had to use 'u32'
here which I feel lessens our ability to have the code document itself.

I don't feel too strongly against doing the conversion, and I won't
object to doing it if you do, but just be aware that I've tried it and
preferred to go back (even though our coding style doesn't like this) :)

-- 
Thanks,
Sasha
