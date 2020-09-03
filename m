Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A925C903
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Sep 2020 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgICSzT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Sep 2020 14:55:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49486 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbgICSzR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Sep 2020 14:55:17 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9A96E20B7178;
        Thu,  3 Sep 2020 11:55:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A96E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599159316;
        bh=8xhM8jGePlugAVfDZrVZ6mcs+yU+1QsE8K/2rdY/HpE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lClAnmBSVvGfF+CmDdsCfTe8NQ6eXsmcDHykjYZcB9L82hXYeHzfG+dv9KnLzIf+o
         RGlRYIWmFMiuCetQeRpWwuvxFSkrb/FYALOyp0eVFDPH+sKWRQns59MvgE8AGOVvc3
         eh9PhAqxAkn+NxzOoYvsdhs/3tDJzx9c9o7exED4=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, spronovo@microsoft.com
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814130406.GC56456@kroah.com>
 <cfb9eb69-24f9-2a0c-1f1b-9204c6666aa8@linux.microsoft.com>
 <20200828061257.GB56396@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <d8f6ed37-11dc-1103-8908-ad79482a4694@linux.microsoft.com>
Date:   Thu, 3 Sep 2020 11:55:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200828061257.GB56396@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Greg,

I appreciate your comments and working to address them.

On 8/27/2020 11:12 PM, Greg KH wrote:
> As for "matching names", why does that matter?  Who sees both names at
> the same time?
>
> > > 
> > > endian issues?
> > > 
> > > If not, why are these bit fields?
> > This matches the definition on the Windows side. Windows only works on
> > little endian platforms.
>
> But Linux works on both, so you need to properly document/handle this somehow.
This driver works only in a Linux container in conjunction with the 
Windows host. The structure definitions are  the same on the host and 
the container. The driver will not be enabled or work on platforms, 
where Windows does not run.
>
> > > 
> > > > +struct d3dkmt_destroydevice {
> > > > +	struct d3dkmthandle		device;
> > > > +};
> > > 
> > > Again, single entity structures?
> > > 
> > > Are you trying to pass around "handles" and cast them backwards?
> > > 
> > > If so, great, but then use the real kernel structures for that like
> > > 'struct device' if these are actually devices.
> > > 
> > Again. The structure matches the definition on the Windows side to avoid
> > confusion.
>
> Who is confused here?  We accept naming conventions that do not match
> the normal Linux style when they are referring to external sources of
> the data.  Examples of this are USB device field names, and other
> hardware specifications that are public.  You aren't sharing code with a
> Windows system, so please follow the Linux coding style rules, as you
> want Linux developers to be helping you maintain this code, not
> developers who have ever read code from other operating systems.
>
> So please follow the rule of, "unless these fields and structures are
> publically defined somewhere, use Linux naming rules", like all of the
> rest of us do.
>
The d3dkmt* structures, like d3dkmt_destroydevice are publicly 
documented on MSDN 
(https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/d3dkmthk/ns-d3dkmthk-_d3dkmt_destroydevice). 
I am using the same definitions in the driver, so it is easy to find the 
corresponding definition and description of the structure. I have no 
problem to change the names, but I think using the same public 
definition will help the driver maintainers.

Thanks

Iouri

