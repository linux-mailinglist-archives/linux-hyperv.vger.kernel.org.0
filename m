Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E822551B6
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 01:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0Xp5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 19:45:57 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51100 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Xp4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 19:45:56 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1CC6320B7178;
        Thu, 27 Aug 2020 16:45:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CC6320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598571956;
        bh=FJqikQav9TJ+GnVPWDsN8BNbcytAK+HjdY2jfLtP0aM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WsbvAKcE0/CZQfjLnQASjVsbyukjVY6THg5Qjhuk0kruv/he2lSXMXjM5X/CWLnNA
         teAOjSfXkRmH2Hhjq0qXBQ0nlsCF/otXVjHW6Ix9zIP8Agm9gCrf27Muo/m9HUmGqQ
         xaXJNRoqjXiRwfZxd0z9UL6Fmm3hHIrOnlXDHU8I=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814125729.GB56456@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <8bf27b82-bdd9-6486-fbc9-aa6f7a3312e0@linux.microsoft.com>
Date:   Thu, 27 Aug 2020 16:45:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200814125729.GB56456@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 8/14/2020 5:57 AM, Greg KH wrote:
> On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> > Add support for a Hyper-V based vGPU implementation that exposes the
> > DirectX API to Linux userspace.
>
> Api questions:
>
> > +struct d3dkmthandle {
> > +	union {
> > +		struct {
> > +			u32 instance	:  6;
> > +			u32 index	: 24;
> > +			u32 unique	: 2;
>
> What is the endian of this?
>
> > +		};
> > +		u32 v;
> > +	};
> > +};
> > +
> > +extern const struct d3dkmthandle zerohandle;
> > +
The definition is the same as on the Windows side. The driver 
communicates with a Windows host, so I do not expect any issues with 
endiannes. Windows currently runs only on the little endian platforms.
User mode applications see this as an opaque 32 bit value 
(D3DKMTHANDLE). I prefer not to use the u32 definition to avoid mistakes 
when another integer or a 64-bit handle is assigned to the handle or  
the handle is assigned to a 64 or 32 bit integer variable. There are 
many handles in the driver model (shared NT handle, d3dkmthandle, etc). 
Using a specific type allows to avoid assigning one handle to another.
> > +struct ntstatus {
> > +	union {
> > +		struct {
> > +			int code	: 16;
> > +			int facility	: 13;
> > +			int customer	: 1;
> > +			int severity	: 2;
>
> Same here.
>
> Are these things that cross the user/kernel boundry?
>
> And why int on one and u32 on the other?
>
> > +		};
> > +		int v;
> > +	};
> > +};
> > +
"struct ntstatus" follows the definition for NTSTATUS on the Windows 
side. NTSTATUS is an integer where the negative values indicate errors. 
It is success otherwise. NTSTATUS is returned by the VM bus messages 
from host. IOCTLs from the driver return Linux negative error code or 
NTSTATUS positive success codes. DxCore applications expect certain 
positive success codes. DxCore is a shared library, which translates the 
D3DKMT* Windows interface to Linux ioctls. Applications link with DxCore 
to use a paravirtualized GPU.
D3DKMTHANDLE is a 32-bit unsigned value (bitfield), not an integer.
> > +struct winluid {
> > +	uint a;
> > +	uint b;
>
> And now uint?  Come on, be consistent please :)
Sorry about this. This came from the Windows size where we use UINT a 
lot. All uints will be replaced by u32 in the next patch set.
>
> thanks,
>
> greg k-h
>
Thank you
Iouri

