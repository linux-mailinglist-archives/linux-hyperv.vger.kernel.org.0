Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDF25CC70
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Sep 2020 23:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgICVjG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Sep 2020 17:39:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41924 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICVjG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Sep 2020 17:39:06 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8E42720B7178;
        Thu,  3 Sep 2020 14:39:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E42720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599169145;
        bh=X8Rl+pt4VyViVuY1iqvZwrKvgNYzoNtbk1C/H/rtsqg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SExMy0z8l+hDET7uI+Q/LNihF/CkCSNZ8/8iWyTqCJFtunIbCKQmGIlnxcQQoSEw9
         wTLpR6SMvrJNUoIQeSmNFde5tb81gNlLJAMBZKnx87bD/JKDYMXi9ndvXvHHM3XkW5
         U0L+cGCVCwZ2IZFT7EOH8m4VX+zfBoqxo46/U+lQ=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        spronovo@microsoft.com
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org> <20200821135340.GA4067@bug>
 <054abab3-748e-c56b-526a-1b1734a9eaf7@linux.microsoft.com>
 <20200828061840.GE56396@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <f68415b4-f76d-680a-cc4f-2647fe54e538@linux.microsoft.com>
Date:   Thu, 3 Sep 2020 14:39:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200828061840.GE56396@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Greg,

On 8/27/2020 11:18 PM, Greg KH wrote:
> On Thu, Aug 27, 2020 at 05:25:23PM -0700, Iouri Tarassov wrote:
> > > > +bool dxghwqueue_acquire_reference(struct dxghwqueue *hwqueue)
> > > > +{
> > > > +	return refcount_inc_not_zero(&hwqueue->refcount);
> > > > +}
> > > 
> > > Midlayers are evil.
> > I strongly agree in general, but think that in our case the layers are very
> > small. It allows to quickly find all places where a reference/dereference on
> > an object is done and addition of debug tracing to catch errors.
>
> Again, no, please remove all layers like this.  They just make it
> impossible for others to review and understand the code over time.
>
> Also, in this specific case, it would have allowed me to easily realize
> that you are doing this type of call incorrectly and should be using a
> different data structure :)

Are you suggesting that the current code is incorrect? Could you comment 
what changes need to be done?

Thanks
Iouri

