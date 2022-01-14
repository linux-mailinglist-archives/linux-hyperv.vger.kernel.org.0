Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0F48E160
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jan 2022 01:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiANAII (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 19:08:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42522 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbiANAII (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 19:08:08 -0500
Received: from [192.168.1.17] (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 38C9A20B8001;
        Thu, 13 Jan 2022 16:08:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38C9A20B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642118888;
        bh=EYi6DpvE0IcY78PvkeNIXuYbnvYY5FdUQa5w4jGDZyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fgt7tDUh397tSFpIlyxbZ/eCrVVPxzcWFsWGJ62bX77+KvjdT+f2w+lO1lDkR3N2N
         3nhxrn8vsIlhiw2NLZS5vCP+8c4E4tPRdhRUsR3PrUfHjphJXfMi66L52Fa1gXARsN
         uRmtdNXma567l7J8AFSSdb9JEwRzXP8NtiRkJBDE=
Message-ID: <19e524e6-d0fc-20a7-03c6-c1094681a2a6@linux.microsoft.com>
Date:   Thu, 13 Jan 2022 16:08:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 1/9] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
 <Yd/YvU5RQOAvLOhC@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yd/YvU5RQOAvLOhC@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 1/12/2022 11:46 PM, Greg KH wrote:
> On Wed, Jan 12, 2022 at 11:55:06AM -0800, Iouri Tarassov wrote:
> > +	dev_dbg(dxgglobaldev, "%s: %x:%x %p %pUb\n",
> > +		    __func__, adapter->luid.b, adapter->luid.a, hdev->channel,
> > +		    &hdev->channel->offermsg.offer.if_instance);
>
> When I see something like "global device pointer", that is a HUGE red
> flag.
>
> No driver should ever have anything that is static to the driver like
> this, it should always be per-device.  Please use the correct device
> model here, which does not include a global pointer, but rather unique
> ones that are given to you by the driver core.  That way you are never
> tied to only "one device per system" as that is a constraint that you
> will have to fix eventually, might as well do it all correctly the first
> time as it is not any extra effort to do so
Hi Greg,

dxgglobaldev is a pointer to the global driver data. By design there is a
single hyper-v VM bus and a single corresponding /dev/dxg device.
Virtual GPU adapters are present on the VM bus. /dev/dxg device is used
to enumerate all virtual GPUs, which are accessible only via IOCTLs
to /dev/dxg. dxgglobaldev has a list of all vGPU adapters and
other global driver state. This follows the design on Windows where a single
global object in dxgkrnl.sys driver is used to enumerate and access all
GPU devices. This is also how the public D3DKMT interface to dxgkrnl is
structured.

Thanks
Iouri
